--[[ 
-----------------------------------------------------
@filename       : DupImpliedEnterPanel
@Description    : 默示之境副本进入页面
@date           : 2021-07-05 11:50:53
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dupImplied.view.DupImpliedEnterPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupImplied/DupImpliedEnterPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52087))
    self:setBg("dupImplied_bg_1.jpg", false, "dupImplied")
    self:setUICode(LinkCode.DupImplied)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mStageItemList = {}
end

-- 初始化
function configUI(self)
    -- :GetComponent(ty.Image)
    self.mBtnRank = self:getChildGO("mBtnRank")

    self.mMapItemlist = {}
    for i=1,6 do
        self.mMapItemlist[i] = {}
        self.mMapItemlist[i].item = self:getChildGO("mGroupLevel_" .. i)
        self.mMapItemlist[i].item:SetActive(false)
    end

    for i=1,6 do
        if not self.mMapItemlist[i] then 
            self.mMapItemlist[i] = {}
        end

        self.mMapItemlist[i].bg = self:getChildGO("mImgMap_" .. i)
        self.mMapItemlist[i].bg:SetActive(false)
    end

    self.mTextLevelSelect = self:getChildGO("mTextLevelSelect"):GetComponent(ty.Text)
    self.mBtnLevelSelect = self:getChildGO("mBtnLevelSelect")

    self.mImgDissolve = self:getChildGO("mImgDissolve"):GetComponent(ty.Image)

    self:setGuideTrans("funcTips_codeImplied_tipsLevel", self:getChildTrans("mTipsLevel"))
end

--激活
function active(self)
    super.active(self)
    dup.DupImpliedManager:addEventListener(dup.DupImpliedManager.EVENT_IMPLIED_INFO_UPDATE, self.onInfoUpdate, self)
    self:updateStage()
    self:updateDiff()
    if self.isReshow ~= true then
        self:setDissolve()
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    dup.DupImpliedManager:removeEventListener(dup.DupImpliedManager.EVENT_IMPLIED_INFO_UPDATE, self.onInfoUpdate, self)

    LoopManager:removeFrame(self, self.onFrame)
    self.mImgDissolve.material:SetFloat("_Clip", 3)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRank, self.onOpenRank)
    self:addUIEvent(self.mBtnLevelSelect,self.openLevelSelect)
end

function setDissolve(self)
    self.clipValue = 0.35
    LoopManager:removeFrame(self, self.onFrame)
    LoopManager:addFrame(1, 0, self, self.onFrame)
end

function onFrame(self)
    self.clipValue = self.clipValue + 0.02
    if self.clipValue >= 3 then
        LoopManager:removeFrame(self, self.onFrame)
    end
    self.mImgDissolve.material:SetFloat("_Clip", self.clipValue)
end

--打开难度选择界面
function openLevelSelect(self)
    if not dup.DupImpliedManager:getIsCanSelectDiffLevel() then
        gs.Message.Show(_TT(42111))
        return 
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_LEVELSELECTPANEL)
end

-- 打开排行奖励
function onOpenRank(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RANK_MAIN_PANEL, { type = rank.RankConst.RANK_IMPLIED })
end

function onInfoUpdate(self)
    local curDiffId = dup.DupImpliedManager:getImpliedDiffId()
    if curDiffId == 0 then 
        self:close()
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_ENTER_PANEL)
        return
    end

    self:updateStage()
    self:updateDiff()
end

function updateStage(self)
    -- self:recoverListItem()
    local list = dup.DupImpliedManager:getOpenStageList()
    for i, v in ipairs(list) do
        local item = SimpleInsItem:create2(self.mMapItemlist[v.id].item)
        self.mMapItemlist[v.id].bg:SetActive(true)
        item:setText("mTxtName", v.name)
        item:setText("mTxtStage", nil, string.format("%02d", v.id))
        item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(string.format("dupImplied_new/img_main_enter0%s.png", v.id)), true)

        if dup.DupImpliedManager:getStageAllTime(v.id) == 0 then
            item:setText("mTxtTime", nil, "--:--:--")
        else
            local timeStr = TimeUtil.getHMSByTime(dup.DupImpliedManager:getStageAllTime(v.id))
            item:setText("mTxtTime", nil, timeStr)
        end

        local count = 0
        local dupList = dup.DupImpliedManager:getCurDiffStageList(v.id)
        for i, v in ipairs(dupList) do
            local info = dup.DupImpliedManager:getDupInfo(v)
            if info and info.roundPassTime > 0 then
                count = count + 1
            end
        end

        local value = count / #dupList 
        item:setText("mTXTProgress",nil,string.format("%s%%",math.ceil(value * 100)))
        item:getChildGO("mImgProgress"):GetComponent(ty.Image).fillAmount = value

        item:getChildGO("mImgPass"):SetActive(dup.DupImpliedManager:getStageIsPass(v.id))
        item:addUIEvent("mGroupClick", function()
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_DUP_PANEL, { stageId = v.id })
        end)
        table.insert(self.mStageItemList, item)
    end


end
--更新难度
function updateDiff(self)
    local curDiffId = dup.DupImpliedManager:getImpliedDiffId()
    self.mTextLevelSelect.text = curDiffId
end
-- 回收项
function recoverListItem(self)
    if self.mStageItemList then
        for i, v in pairs(self.mStageItemList) do
            v:poolRecover()
        end
    end
    self.mStageItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
