

module("doundless.DoundlessRankPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("doundless/DoundlessRankPanel.prefab")
panelType = 1-- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0--是否开启适配刘海 0 否 1 是

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(62203))
    self:setSize(0, 0)
    self:setBg("Infinitycity_bg_01.jpg", false, "doundless")
end
-- 初始化数据
function initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mTxtWar = self:getChildGO("mTxtWar"):GetComponent(ty.Text)
    self.mTxtMyRankBig = self:getChildGO("mTxtMyRankBig"):GetComponent(ty.Text)
    self.mTxtMyRank = self:getChildGO("mTxtMyRank"):GetComponent(ty.Text)
    self.mTxtMyName = self:getChildGO("mTxtMyName"):GetComponent(ty.Text)
    self.mTxtMyScore = self:getChildGO("mTxtMyScore"):GetComponent(ty.Text)
    self.mTxtMyGuild = self:getChildGO("mTxtMyGuild"):GetComponent(ty.Text)
    self.mMyHeadGridNode = self:getChildTrans("mMyHeadGridNode")
    --self.mTxtMyRankDec = self:getChildGO("mTxtMyRankDec"):GetComponent(ty.Text)
    --self.mImgSeasonDan = self:getChildGO("mImgSeasonDan"):GetComponent(ty.AutoRefImage)
    --self.mTxtSeasonDan = self:getChildGO("mTxtSeasonDan"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(doundless.DoundlessRankItem)
    self.mTxtTilte_02 = self:getChildGO("mTxtTilte_02"):GetComponent(ty.Text)
    self.mTxtMyLayer = self:getChildGO("mTxtMyLayer"):GetComponent(ty.Text)
end


function initViewText(self)
    --self.mTxtMyRankDec.text = _TT(159)
    self.mTxtTilte_02.text = "当前排行"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function active(self)
    super.active(self)
   self:updateView()
end

function deActive(self)
    super.deActive(self)
    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
    GameDispatcher:removeEventListener(EventName.UPDATE_ARENA_RANK, self.updateView, self)
end

function updateView(self)
    self.warId = doundless.DoundlessManager:getServerWayId()
    local warName = doundless.getWarName(self.warId)
    local cityData = doundless.DoundlessManager:getDoundlessCityDataByWar(self.warId)
    self.mTxtWar.text = warName.. "("..cityData.leftLevel.."-"..cityData.rightLevel..")"
    local list = doundless.DoundlessManager:getServerPlayerInfo()

    for i = 1, 4 do
        if list [i] then
            list[i].tweenId = i
        end
    end
    if (self.mScroller.Count <= 0) then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end
    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    if (not self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end

    local myInfo = doundless.DoundlessManager:getMyPlayerInfo()
    self.mPlayerHeadGrid:setData(myInfo.avatar_id)
    self.mPlayerHeadGrid:setParent(self.mMyHeadGridNode)
    self.mPlayerHeadGrid:setHeadFrame(myInfo.avatar_frame_id)
    self.mPlayerHeadGrid:setScale(1)
    self.mPlayerHeadGrid:setCallBack(self, self.onClickHeadHandler)
    self.mTxtMyGuild.text = myInfo.guild_name == "" and _TT(97053) or myInfo.guild_name
    self.mTxtMyLayer.text = doundless.DoundlessManager:getDupLayer(myInfo.dup_id)
    local myRank = myInfo.rank
    
    -- local url = UrlManager:getArenaRankIconUrl(myRank)
    self.m_childGos["mImgColor2"]:SetActive(myRank < 4)
    self.mTxtMyRankBig.gameObject:SetActive(myRank <= 10 and myRank ~= 0)
    self.mTxtMyRank.gameObject:SetActive(myRank > 10)
    self.m_childGos["mTxtMyRank_02"]:SetActive(myRank <= 0)
    self.mTxtMyRankBig.text = myRank
    if myRank <= 0 then
        self.m_childGos["mTxtMyRank_02"]:GetComponent(ty.Text).text = _TT(161)
    elseif myRank <= 3 and myRank > 0 then
        self.mTxtMyRank.text = ""
    elseif myRank <= 100 then
        self.mTxtMyRank.text = myRank
    end
    self.mTxtMyName.text = role.RoleManager:getRoleVo():getPlayerName()
    self.mTxtMyScore.text = myInfo.point
end

--段位不同显示图片
function onClickHeadHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = role.RoleManager:getRoleVo().playerId })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]