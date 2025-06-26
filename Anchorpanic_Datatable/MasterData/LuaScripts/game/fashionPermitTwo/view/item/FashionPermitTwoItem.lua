
module("fashionPermitTwo.FashionPermitTwoItem", Class.impl("lib.component.BaseItemRender"))
--对应的ui文件
function onInit(self, go)
    super.onInit(self, go)
    self.mPropsList = {}
    self.mImgNomal = self:getChildGO("mImgNomal")
    self.mImgMoney = self:getChildGO("mImgMoney")
    self.mImgUnlock = self:getChildGO("mImgUnlock")
    self.mTansNomal = self:getChildTrans("mTansNomal")
    self.mTansMoney = self:getChildTrans("mTansMoney")
    self.mImgCurState = self:getChildGO("mImgCurState")
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
    self.mTxtCurLv = self:getChildGO("mTxtCurLv"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_FASHION_PERMIT_TWO_PANEL, self.updateState, self)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FASHION_PERMIT_TWO_PANEL, self.updateState, self)
  
    self:closeProsList()
end

function setData(self, param)
    super.setData(self, param)
    self.mTxtNum.text = self.data.lv
    self:updateState()
end

function onClickReciveNHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GAIN_FASHION_PERMIT_TWO_REWARD, { lv = self.data.lv, isSenior = 0 })
end

function onClickReciveSHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GAIN_FASHION_PERMIT_TWO_REWARD, { lv = self.data.lv, isSenior = 1 })
end

function closeProsList(self)
    if #self.mPropsList > 0 then
        for _, item in ipairs(self.mPropsList) do
            item:poolRecover()
        end
        self.mPropsList = {}
    end
end

function updateState(self)
    self:closeProsList()
    -- self.mTxtCurLv.text = HtmlUtil:size(self.data.lv, 30)
    self.mTxtCurLv.text =  self.data.lv
    local isShow = ((not self.data:getIsNomalRecived()) or ((not self.data:getIsSeniorRecived()) and self.data:getIsBuy()))
   
    --self.mTxtCurLv.color = (self.data:getIsUnlock() and isShow) and gs.ColorUtil.GetColor("20222645") or gs.ColorUtil.GetColor("20222623")
    self.mImgCurState:SetActive((self.mTxtCurLv.color == gs.ColorUtil.GetColor("202226ff")))
    for _, propsVo in ipairs(self.data:getNoamlAwardList()) do
        local propGrid = PropsGrid:create(self.mTansNomal, { tid = propsVo.tid, num = propsVo.num ~= nil and propsVo.num or 1 }, 0.7, false)
        propGrid:setHasRec((self.data:getIsNomalRecived() and self.data:getIsUnlock()))
        propGrid:setIsShowCanRec(((not self.data:getIsNomalRecived()) and self.data:getIsUnlock()))
        propGrid:setCountTextSize(24)
        if ((not self.data:getIsNomalRecived()) and self.data:getIsUnlock()) then
            propGrid:setCallBack(self, self.onClickReciveNHandler)
        elseif (self.data:getIsNomalRecived()) then
            propGrid:setCallBack(self, function()
                gs.Message.Show(_TT(411))
                return
            end)
        end
        table.insert(self.mPropsList, propGrid)
    end
    if #self.data:getSeniorAwardList() > 1 then
        gs.TransQuick:Scale0(self.mTansMoney, 0.5)
    else
        gs.TransQuick:Scale0(self.mTansMoney, 0.7)
    end
    for _, propsVo1 in ipairs(self.data:getSeniorAwardList()) do
        local propGrid = PropsGrid:create(self.mTansMoney, { tid = propsVo1.tid, num = propsVo1.num ~= nil and propsVo1.num or 1 })
        propGrid:setHasRec((self.data:getIsSeniorRecived() and self.data:getIsUnlock()))

        local isBuy = fashionPermitTwo.FashionPermitTwoManager:getIsBuyFashionPermit()
        propGrid:setIsShowCanRec( not self.data: getIsSeniorRecived() and self.data:getIsUnlock() and isBuy ) --((self.mImgCurState.activeSelf == true) and self.data:getIsBuy()))
        propGrid:setCountTextSize(24)
        if ((not self.data:getIsSeniorRecived()) and self.data:getIsUnlock() and self.data:getIsBuy()) then
            propGrid:setCallBack(self, self.onClickReciveSHandler)
        elseif (self.data:getIsSeniorRecived()) then
            propGrid:setCallBack(self, function()
                gs.Message.Show(_TT(411))
                return
            end)
        end
        table.insert(self.mPropsList, propGrid)
    end

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]