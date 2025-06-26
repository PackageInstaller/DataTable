--[[ 
-----------------------------------------------------
@filename       : WelfareOptSevenLoadingView
@Description    : 七天登录
@Author         : sxt
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.tab.WelfareOptSevenLoadingView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("welfareOpt/tab/WelfareOptSevenLoadingView.prefab")

function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mPropItems = {}
    self.itemList = {}
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_SEVEN_DAY_PANEL, self.__updateView, self)
    self:showPanel()
    -- self:actionSound()
end

function __updateView(self)
    self:showPanel()
end

function actionSound(self)
    local OpenSoundPath = self:getOpenSoundPath()
    if not string.NullOrEmpty(OpenSoundPath) then
        AudioManager:playSoundEffect(OpenSoundPath)
    end
end

function getOpenSoundPath()
    return UrlManager:getUIBaseSoundPath("ui_event_7.prefab")
end

function showPanel(self)
    self:removeAllItem()
    self.sevenDic = welfareOpt.WelfareOptManager:getSevenLoadingData()
    self.serverData = welfareOpt.WelfareOptManager:getSevenLoadingServerData()
    if self.serverData then
        for id, data in pairs(self.sevenDic) do
            local item = SimpleInsItem:create2(self:getChildGO("mDayItem_0" .. id))
            if id == 1 then
                self:setGuideTrans("guide_WelfareOpt_SevenLoading_1", item:getTrans())
            end
            local geted = table.indexof01(self.serverData.list, id) > 0
            local StateUrl = geted and "sevenDayLogin_9" or "sevenDayLogin_8"
            local nomalUrl = (id <= self.serverData.day and not geted) and StateUrl or "sevenDayLogin_7"
            local propVo = props.PropsManager:getTypePropsVoByTid(data.rewardId)
            local propGrid = PropsGrid:create(item:getChildTrans("mAwardTrans"), { data.rewardId, data.rewardNum }, 1, true)
            table.insert(self.mPropItems, propGrid)
            item:getChildGO("mGot"):SetActive(geted)
            item:getChildGO("mTxtState"):GetComponent(ty.Text).text = (self.serverData.day + 1 == id) and "明日奖励" or _TT(3)
            item:getChildGO("mGet"):SetActive((id <= self.serverData.day and not geted))
            local sevenColor = item:getChildGO("mGet").activeSelf == true and "906F59ff" or "A7A7A7ff"
            local color = id >= 7 and sevenColor or "10151Dff"
            item:getChildGO("mTxtDay"):GetComponent(ty.Text).text = HtmlUtil:color(string.format('%02d', id), color)
            local sevenUrl = item:getChildGO("mGet").activeSelf == true and "sevenDayLogin_12" or "sevenDayLogin_11"
            local isShow = (item:getChildGO("mGet").activeSelf == true) or (self.serverData.day + 1 == id)
            local stateImg = id >= 7 and sevenUrl or nomalUrl
            item:getChildGO("mTxtState"):SetActive(isShow)
            item:getChildGO("mGroupIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("sevenDayLogin/" .. stateImg .. ".png"), true)
            item:getChildGO("mClcikGet"):SetActive(true)
            if id <= 6 then
                item:getChildGO("mClcikGet"):SetActive(item:getChildGO("mGet").activeSelf == true)
            end
            item:addUIEvent("mClcikGet", function()
                self:onClickPropHandler(id, propVo, item:getTrans():GetComponent(ty.RectTransform))
            end)
            table.insert(self.itemList, item)
        end
    end
end

function onClickGetHandler(self, id)
    GameDispatcher:dispatchEvent(EventName.REQ_GAIN_SEVEN_DAY_REWARD, { day = id })
end

function onClickPropHandler(self, id, propVo, rect)
    if id > self.serverData.day or table.indexof01(self.serverData.list, id) > 0 then
        TipsFactory:propsTips({ propsVo = propVo }, { rectTransform = rect })
        return
    end
    self:onClickGetHandler(id)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SEVEN_DAY_PANEL, self.__updateView, self)
    self:removeAllItem()
    self:removeRedPoint()
end

function removeRedPoint(self)
    for k, v in pairs(self.itemList) do
        RedPointManager:remove(v:getChildTrans("mRedPoint"))
    end
end

function removeAllItem(self)
    if #self.mPropItems > 0 then
        for _, item in ipairs(self.mPropItems) do
            item:poolRecover()
        end
        self.mPropItems = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(7):	"已领取"
	语言包: _TT(3):	"领取"
]]