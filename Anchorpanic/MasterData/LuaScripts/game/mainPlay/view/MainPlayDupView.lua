--[[ 
-----------------------------------------------------
@filename       : DupDailyMainPanel
@Description    : 日常副本总入口
@date           : 2021-01-27 16:22:54
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainPlay.MainPlayDupView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("mainPlay/MainPlayDupView.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)
    self.mDupItemList = {}
    self.tweenTimeSn = {}
end

function configUI(self)
    super.configUI(self)
    --self.mDoTween = self.UIObject:GetComponent(ty.UIDoTween)
    self.mTypeItem = self:getChildGO("mTypeItem")
    self.mDupContent = self:getChildTrans("mDupContent")
end

function active(self, args)
    super.active(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID }, 1)
    dup.DupDailyBaseManager.mIsShowDupAni = true
    dup.DupEquipBaseManager.mIsShowDupAni = true
    self:updateView()
    --if dup.DupDailyBaseManager.mIsShowMain == true then
    --    self.mDoTween:BeginTween()
    --end
    --self:setGuideTrans("guide_MainPlayDup_Chip", self.mGroupChip.transform)
    --self:setGuideTrans("guide_MainPlayDup_Daily", self.mGroupDaily.transform)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    self:recoverSn()
    self:closeDupItemList()
    self.mIsTween = true

end

function closeDupItemList(self)
    if #self.mDupItemList > 0 then
        for _, item in pairs(self.mDupItemList) do
            item:poolRecover()
        end
        self.mDupItemList = {}
    end
end

function updateView(self)
    self:closeDupItemList()
    local list = mainPlay.MainPlayDupConst:getTabList()
    for index, dupVo in pairs(list) do
        local item = SimpleInsItem:create(self.mTypeItem, self.mDupContent, "MainPlayDupViewmTypeItem")
        self:setGuideTrans("MainPlayDupItem_" .. index, item.m_trans)
        local color = (funcopen.FuncOpenManager:isOpen(dupVo.funcId, false) == true) and mainPlay.MainPlayDupConst:getColorByType(dupVo.page) or "888d91ff"
        item:getChildGO("mImgDesBg"):SetActive(index ~= 1)
        item:getChildGO("mImgDesBg_02"):SetActive(index == 1)
        item:getChildGO("mTxtDes"):GetComponent(ty.Text).text = dupVo.des
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = dupVo.nomalLan
        item:getChildGO("mImgTitle"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)
        item:getChildGO("mImgLeft"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(color)
        item:getChildGO("mImgNum"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dupResources/dup_chip_num_0" .. index .. ".png"), true)
        item:getChildGO("mImgTypeBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dupResources/dup_chip_0" .. dupVo.page .. ".png"), true)
        item:getChildGO("mImgTypeBg"):GetComponent(ty.AutoRefImage):SetGray(funcopen.FuncOpenManager:isOpen(dupVo.funcId, false) == false)
        item:getChildGO("mImgType"):SetActive(dupVo.page == mainPlay.MainPlayDupConst.MAINPLAYDUP_DAILY and dup.DupMainManager:getIsShowUp())
        item:addUIEvent(nil, function()
            if funcopen.FuncOpenManager:isOpen(dupVo.funcId, true) then
                GameDispatcher:dispatchEvent(dupVo.openEventName)
            end
        end)
        item:getGo():SetActive(false)
        self.mDupItemList[index] = item
    end
    self:recoverSn()
    local i = 1
    table.insert(self.tweenTimeSn, LoopManager:addFrame(2, #self.mDupItemList, self, function()
        if self.mDupItemList[i] ~= nil then
            self.mDupItemList[i]:getGo():SetActive(true)
            i = i + 1
        end
    end))
end

function fadeInShowUI(self)

end

-- UI事件管理
function addAllUIEvent(self)

end
--打开芯片副本界面
function onCilckOpenChipViewHandler()
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_EQUIP, true) == true then
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_DUP)
    end
end
--打开物资副本界面
function onCilckOpenDailyViewHandler()
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_DUP_DAILY, true) == true then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL)
    end
end

function recoverSn(self)
    if next(self.tweenTimeSn) then
        for i = 1, #self.tweenTimeSn do
            LoopManager:removeFrameByIndex(self.tweenTimeSn[i])
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]