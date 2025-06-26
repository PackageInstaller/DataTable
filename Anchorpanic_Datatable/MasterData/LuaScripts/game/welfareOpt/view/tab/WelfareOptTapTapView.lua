--[[ 
-----------------------------------------------------
@filename       : WelfareOptTapTapView
@Description    : TAPTAP联动
@Author         : sxt
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.tab.WelfareOptTapTapView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("welfareOpt/tab/WelfareOptTapTapView.prefab")

function initData(self)

end

function ctor(self)
    super.ctor(self)
end

-- 析构  
function dtor(self)
end

function configUI(self)

    self.mTxtEnd = self:getChildGO("mTxtEnd"):GetComponent(ty.Text)
    self.mSliderBg = self:getChildGO("mSliderBg"):GetComponent(ty.Slider)
    --self.mSlider = self:getChildGO("mSlider"):GetComponent(ty.RectTransform)
    self.mTxtMax = self:getChildGO("mTxtMax"):GetComponent(ty.Text)
    self.mTxtCurrent = self:getChildGO("mTxtCurrent"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mImgReward = self:getChildGO("mImgReward"):GetComponent(ty.AutoRefImage)
    self.mBtnReward = self:getChildGO("mImgReward")
    self.mBtnCheck = self:getChildGO("mBtnCheck")

    self.mTxtTaskCount = self:getChildGO("mTxtTaskCount"):GetComponent(ty.Text)
    self.mTxtTaskDes = self:getChildGO("mTxtTaskDes"):GetComponent(ty.Text)
    self.mBtnRecAll = self:getChildGO("mBtnRecAll")

    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(welfareOpt.welfareOptTapTapItem)
end


function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_TAPTAP_TASK_PANEL,self.showPanel,self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TAPTAP_TASK_PANEL,self.showPanel,self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

function initViewText(self)
    self.mTxtTaskDes.text = _TT(48146)
    self.mTxtDes.text = _TT(48147)
    self.mTxtEnd.text = _TT(48148)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnReward, self.onBtnRewardClick)
    self:addUIEvent(self.mBtnCheck, self.onBtnCheckClick)
    self:addUIEvent(self.mBtnRecAll, self.onBtnRecAllClick)
end

function onBtnRewardClick(self)
    local isGain = welfareOpt.WelfareOptManager:getIsGainGrandPrize() == 1

    if isGain then
        gs.Message.Show(_TT(266))
    elseif self.canGain == false then
        gs.Message.Show(_TT(48145))
    else
        GameDispatcher:dispatchEvent(EventName.REQ_TAPTAP_TASK_GRAND)
    end
end

function onBtnCheckClick(self)
    -- gs.Message.Show("TODO")
    GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW, { heroTid = 1010, fashionId = 3 , isShow3D = true})
end

function onBtnRecAllClick(self)
    local taptapDic = welfareOpt.WelfareOptManager:getTapTapTask()

    local list = {}
    for id, vo in pairs(taptapDic) do
        local severInfo = welfareOpt.WelfareOptManager:getTapTapServerInfo(vo.id)
        if severInfo.state == 0 then
           table.insert(list,id)
        end
    end
    GameDispatcher:dispatchEvent(EventName.REQ_TAPTAP_TASK,list)
end

function showPanel(self)
    local isGain = welfareOpt.WelfareOptManager:getIsGainGrandPrize() == 1

    self.canGain = welfareOpt.WelfareOptManager:canGetGain() 
    if welfareOpt.WelfareOptManager:canGetGain() then
        RedPointManager:add(self.mImgReward.transform,nil,25,25)
    else
        RedPointManager:remove(self.mImgReward.transform)
    end

    self.mImgReward:SetImg(isGain and UrlManager:getPackPath("taptap/activity_taptapld_icon_04.png") or 
        UrlManager:getPackPath("taptap/activity_taptapld_icon_03.png"))

    local taptapDic = welfareOpt.WelfareOptManager:getTapTapTask()

    local canGetAll = false
    local list = {}
    for id, vo in pairs(taptapDic) do
        local serverInfo = welfareOpt.WelfareOptManager:getTapTapServerInfo(vo.id)
        if serverInfo.state == 0 then
           canGetAll = true 
        end
        vo:setServerInfo(serverInfo)
        table.insert(list,vo)
    end

    table.sort(list,function (a,b)
        if (a.serverInfo.state ~= b.serverInfo.state) then
            return a.serverInfo.state < b.serverInfo.state
        else
            return a.id < b.id
        end
    end)

    self.mBtnRecAll:SetActive(canGetAll)
    self.mTxtMax.text ="/" .. #list
    local currentCount = welfareOpt.WelfareOptManager:getTapTapGedCount()
    self.mTxtCurrent.text = currentCount 
    if isGain then
        self.mSliderBg.value = 1
    else
        self.mSliderBg.value = currentCount /  #list
    end

    self.canGain = currentCount >=  #list

    
    for i = 1, 4 do
        if list[i] then
            list[i].tweenId = 6 + i * 2
        end
    end

    if (self.mLyScroller.Count <= 0) then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
end

return _M