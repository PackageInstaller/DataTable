--[[-----------------------------------------------------
@filename       : WelfareOptFestivalView
@Description    : 节日福利
@Author         : sxt
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.tab.WelfareOptFestivalView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("welfareOpt/tab/WelfareOptFestivalView.prefab")

function initData(self)
    self.mFestivalItemList = {}

    self.mFestivalPropsItemList = {}
end

function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function configUI(self)
    self.mFestivalScroll = self:getChildGO("mFestivaScroll"):GetComponent(ty.ScrollRect)
    self.mFestivalSingleItem = self:getChildGO("mFestivalSingleItem")
    self.mFestivaPropsItem = self:getChildGO("mFestivaPropsItem")

    self.mTxtRem = self:getChildGO("mTxtRem"):GetComponent(ty.Text)
    self.mTxtRemTime = self:getChildGO("mTxtRemTime"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_FESTIVAL_REWARD, self.showPanel, self)
    self:showPanel(true)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FESTIVAL_REWARD, self.showPanel, self)
    self:clearFestivalItem()
end

function initViewText(self)
    self.mTxtRem.text = _TT(85014)
end

function addAllUIEvent(self)
end

function showPanel(self, isInit)
    self:clearFestivalItem()
    local signDay = welfareOpt.WelfareOptManager:getSignDay()
    local list = welfareOpt.WelfareOptManager:getFestivalData()

    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Festival)
    self.mTxtRemTime.text = mainActivityVo:getRemainingTime()

    for i = 1, #list do
        local vo = list[i]
        local geted = welfareOpt.WelfareOptManager:getSignRewardGeted(i)

        local item = SimpleInsItem:create(self.mFestivalSingleItem, self.mFestivalScroll.content, "FestivalSingleItem")
        item:getGo():SetActive(false)
        local tween = item:getGo():GetComponent(ty.UIDoTween)

        if isInit == true then
            local frameSn = LoopManager:addFrame(4 + i * 2, 1, self, function()
                item:getGo():SetActive(true)
                tween:BeginTween()
            end)

            table.insert(self.mFrameSnList, frameSn)
        else
            item:getGo():SetActive(true)
        end
        item:getChildGO("mGeted"):SetActive(geted)
        -- item:getChildGO("mBtnClick"):SetActive(geted == false and i <= signDay)
        local canget = geted == false and i <= signDay or geted
        item:getChildGO("mCanGet"):SetActive(canget)
        item:getChildGO("mReceive"):SetActive(canget and not geted)
        local txt1=(geted == false and i <= signDay) and _TT(48151) or _TT(48152)
        item:getChildGO("mTxtState"):GetComponent(ty.Text).text = item:getChildGO("mCanGet").activeSelf==true and txt1 or _TT(48150,self:getHanziNum(i))
        item:getChildGO("mTxtState"):GetComponent(ty.Text).color = item:getChildGO("mCanGet").activeSelf==true and gs.ColorUtil.GetColor("FFFFFFFF") or gs.ColorUtil.GetColor("FFFFFFFF")
        item:getChildGO("mTxtDay"):GetComponent(ty.Text).text= item:getChildGO("mCanGet").activeSelf==true and  HtmlUtil:color("0"..i,"FFFFFFFF") or HtmlUtil:color("0"..i,"FFFFFFFF")

        for j = 1, #vo.mReward do
            local itemData = vo.mReward[j]
            local propsItem = SimpleInsItem:create(self.mFestivaPropsItem, item:getChildTrans("mPropsContent"), "FestivaPropsItem")
            local itemUrlBg = (geted == false and i <= signDay) and "celebration_36" or "celebration_28"
            propsItem:getChildGO("mPropsImg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(itemData[1]), false)
            propsItem:getGo():GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("celebration/"..itemUrlBg..".png"), false)
            propsItem:getChildGO("mTxtCount"):GetComponent(ty.Text).text ="X".. itemData[2]
            propsItem:getChildGO("mImgLight"):SetActive(canget)
            propsItem:addUIEvent("mPropsImg", function()
                if geted or i > signDay then
                    local propsVo = props.PropsManager:getPropsConfigVo(itemData[1])
                    TipsFactory:propsTips({ propsVo = propsVo, isShowUseBtn = nil }, { rectTransform = propsItem:getChildTrans("mPropsImg") })
                else
                    GameDispatcher:dispatchEvent(EventName.REQ_FESTIVAL_REWARD, {
                    day = i
                })
                end
            end)

            table.insert(self.mFestivalPropsItemList, propsItem)
        end

        item:addUIEvent("mBtnClick", function()
            if geted then
                gs.Message.Show(_TT(48118))
            elseif i > signDay then
                gs.Message.Show(_TT(list[i].language))
            else
                GameDispatcher:dispatchEvent(EventName.REQ_FESTIVAL_REWARD, {
                    day = i
                })
            end
        end)

        table.insert(self.mFestivalItemList, item)
    end
end

function clearFestivalItem(self)
    if self.mFrameSnList then
        for i, v in ipairs(self.mFrameSnList) do
            LoopManager:removeFrameByIndex(v)
        end
    end
    self.mFrameSnList = {}
    
    self:clearFestivalPropsItem()
    for i = 1, #self.mFestivalItemList do
        self.mFestivalItemList[i]:poolRecover()
    end
    self.mFestivalItemList = {}
end

function clearFestivalPropsItem(self)
    for i = 1, #self.mFestivalPropsItemList do
        self.mFestivalPropsItemList[i]:poolRecover()
    end
    self.mFestivalPropsItemList = {}
end

function getHanziNum(self,i)
    if i==1 then
        return "一"
    elseif i==2 then
        return "二"
    elseif i==3 then
        return "三"
    elseif i==4 then
        return "四"
    elseif i==5 then
        return "五"
    elseif i==6 then
        return "六"
    else
        return "七"
    end
end

return _M