--[[ 
-----------------------------------------------------
@filename       : RankBaseView
@Description    : 排行榜基础页面
@date           : 2021-08-16 19:47:02
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.rank.view.RankBaseView', Class.impl(TabSubView))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rank/RankBaseView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mGroupRank = self:getChildGO("mGroupRank")
    self.mTxtNameLab = self:getChildGO("mTxtNameLab"):GetComponent(ty.Text)
    self.mTxtRoleLab = self:getChildGO("mTxtRoleLab"):GetComponent(ty.Text)
    self.mTxtScoreLab = self:getChildGO("mTxtScoreLab"):GetComponent(ty.Text)
    self.mScrollRank = self:getChildGO("mScrollRank"):GetComponent(ty.LyScroller)
    self.mScrollRank:SetItemRender(self:getItemRender())

    self.mGroupMyHead = self:getChildTrans("mGroupMyHead")
    self.mTxtMyRank = self:getChildGO("mTxtMyRank"):GetComponent(ty.Text)
    self.mTxtMyName = self:getChildGO("mTxtMyName"):GetComponent(ty.Text)
    self.mTxtMyScore = self:getChildGO("mTxtMyScore"):GetComponent(ty.Text)
    self.mImgMyTitle = self:getChildGO("mImgMyTitle"):GetComponent(ty.AutoRefImage)
    self.mTxtMyRankLab = self:getChildGO("mTxtMyRankLab"):GetComponent(ty.Text)

    self.mGroupReward = self:getChildGO("mGroupReward")
    self.mScrollReward = self:getChildGO("mScrollReward"):GetComponent(ty.LyScroller)
    self.mScrollReward:SetItemRender(rank.RankRewardItem)
    self.mBtnReward1 = self:getChildGO("mBtnReward1")
    self.mBtnReward2 = self:getChildGO("mBtnReward2")

    self.mImgInfoBg = self:getChildGO("mImgInfoBg")
    self.mImgBottomBg = self:getChildGO("mImgBottomBg")
    self.mImgNo = self:getChildGO("EmptyStateItem")
    self.mTxtNoRank = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.cusPage = args.type
    self:reqRankData()
    rank.RankManager:addEventListener(rank.RankManager.EVENT_RANK_UPDATE, self.onUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.SET_RANK_SUBTYPE, self.updateRankSubIndex, self)

    self.curView = 1
    self:changeView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    rank.RankManager:removeEventListener(rank.RankManager.EVENT_RANK_UPDATE, self.onUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.SET_RANK_SUBTYPE, self.updateRankSubIndex, self)
    self.mScrollRank:CleanAllItem()
    if (self.mPlayerHead) then
        self.mPlayerHead:poolRecover()
        self.mPlayerHead = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtNoRank.text = _TT(48010) -- "暂无排名"
    self.mTxtMyRankLab.text = _TT(48028)

    self.mTxtNameLab.text = self:getNameLab()
    self.mTxtRoleLab.text = self:getRoleLab()
    self.mTxtScoreLab.text = self:getScoceLab()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

-- 请求排行数据
function reqRankData(self)
    GameDispatcher:dispatchEvent(EventName.REQ_RANK_DATA, { type = self.cusPage })
end

-- 返回更
function onUpdateHandler(self)
    self.mScrollRank:CleanAllItem()
    self:updateRankView()
end

-- 使用的item（Override）
function getItemRender(self)
    return rank.RankBaseItem
end

-- 标签（Override）
function getNameLab(self)
    return _TT(48011) -- "名次"
end
-- 标签（Override）
function getRoleLab(self)
    return _TT(48012) -- "指挥官"
end
-- 标签（Override）
function getScoceLab(self)
    if self.cusPage == rank.RankConst.RANK_CYCLE then 
        return _TT(48013) -- "通关时长"
    else
        return _TT(48031)
    end
end

function changeView(self)
    if self.curView == 1 then
        self.mGroupRank:SetActive(true)
        self.mGroupReward:SetActive(false)
        self:updateRankView()
    else
        self.mGroupRank:SetActive(false)
    end
end

function updateRankSubIndex(self, subIndex)
    if self.cusPage ~= subIndex then 
        self.cusPage = subIndex
        self:reqRankData()
        -- self:updateRankView()
    end
end

function updateRankView(self)
    local infoVo = rank.RankManager:getRankInfoVo(self.cusPage)
    local rankList = infoVo and infoVo:getRankList()

    if not infoVo or #rankList <= 0 then
        self.mImgNo:SetActive(true)
        self.mImgInfoBg:SetActive(false)
        self.mImgBottomBg:SetActive(false)
        return
    end
    self.mImgNo:SetActive(false)
    self.mImgInfoBg:SetActive(true)
    self.mImgBottomBg:SetActive(true)

    self.mTxtScoreLab.text = self:getScoceLab()
    self.mTxtRoleLab.text = self:getRoleLab()

    for i=1, #rankList do
        rankList[i].tweenId = i * 1.5
    end
    if self.mScrollRank.Count <= 0 then
        self.mScrollRank.DataProvider = rankList
    else
        self.mScrollRank:ReplaceAllDataProvider(rankList)
    end
    self:updateMyRank(infoVo)
end

function updateMyRank(self, rankVo)
    local myRank = rankVo.myRank
    local maxRankCount = rankVo.myAllRankCount
    local str = ""
    if myRank == 0 then
        str = _TT(48015)
    else
        local maxCount = rank.RankManager:getRankNum(self.cusPage)
        if myRank > 0 and myRank <= maxCount then
            str = myRank
        elseif myRank / maxRankCount > 0.5 then
            str = _TT(48029)
        else
            str = _TT(48030, math.floor(myRank / maxRankCount * 100))
        end
    end

    self.mTxtMyRank.text = str
    self.mTxtMyName.text = role.RoleManager:getRoleVo():getPlayerName()
    if rankVo.type == rank.RankConst.RANK_CYCLE then 
        self.mTxtMyScore.text = "评分:" .. self:getScoreLab(rankVo)
    else
        self.mTxtMyScore.text = "层数:" .. self:getScoreLab(rankVo)
    end

    if (not self.mPlayerHead) then
        self.mPlayerHead = PlayerHeadGrid:poolGet()
    end
    self.mPlayerHead:setData(role.RoleManager:getRoleVo():getAvatarId())
    self.mPlayerHead:setHeadFrame(role.RoleManager:getRoleVo():getAvatarFrameId())
    self.mPlayerHead:setParent(self.mGroupMyHead)
    self.mPlayerHead:setCallBack(self, self.__onClickHeadHandler)
end

function getScoreLab(self, rankVo)
    if rankVo.type == rank.RankConst.RANK_CYCLE then 
        return rankVo.myRankVal
    elseif rankVo.type == rank.RankConst.RANK_CLIMBTOWER then
        local dupVo = dup.DupClimbTowerManager:datas()[rankVo.myRankVal]
        if dupVo then   
            return dupVo.layer
        end
        return 0
    else
        local dupVo = dup.DupClimbTowerManager:getDeepDupVo(rankVo.myRankVal)
        if dupVo then   
            return dupVo.layer
        end
        return 0
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(48029):	"后50%"
	语言包: _TT(48028):	"我的排名"
]]
