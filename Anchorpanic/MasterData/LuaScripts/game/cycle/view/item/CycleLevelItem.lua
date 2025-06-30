module("cycle.CycleLevelItem", Class.impl(lib.component.BaseItemRender))
function onInit(self, go)
    super.onInit(self, go)
    self.mIsSelect = self:getChildGO("GroupSelect")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtItemNum = self:getChildGO("mTxtItemNum"):GetComponent(ty.Text)
    self.mBtnClick = self:getChildGO("mBtnClick")
    self.mImgLvState = self:getChildGO("mImgLvState")
    self.mImgLvState2 = self:getChildGO("mImgLvState2")
    self.mTxtTile_01 = self:getChildGO("mTxtTile_01"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mImgLine_01 = self:getChildGO("mImgLine_01"):GetComponent(ty.Image)
    self.mImgLvFill = self:getChildGO("mImgLvFill"):GetComponent(ty.Image)
    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)
    self.mReceive = self:getChildGO("mImgReceive")
    self.mReceived = self:getChildGO("mIsGet")
    self.mIneligible = self:getChildGO("mImgIneligible")
    self.mImgLine_02 = self:getChildGO("mImgLvFill_01")
    self:addOnClick(self.mBtnClick, self.onClickHandler)
    self:addOnClick(self.m_childGos["mBtnOnClickItem"], function()
        if self.mPropsTid then
            TipsFactory:propsTips({ propsVo = props.PropsManager:getPropsConfigVo(self.mPropsTid) }, { rectTransform = nil })
        end
    end)
end


function setData(self, data)
    super.setData(self, data)
    self.mLv = self.data.id
    self.curLv = cycle.CycleManager.mHistoryInfo.lv
    self.mPropsTid = data.reward[1]
    self.propsUrl = props.PropsManager:getPropsIconUrl(data.reward[1])
    local name = props.PropsManager:getName(data.reward[1])
    self.nextLvExp = 0
    local maxLen = cycle.CycleManager:getMaxLv()
    if self.mLv < maxLen then
        self.nextLvExp = cycle.CycleManager:getCycleLvData(self.mLv + 1).needExp
    else
        self.nextLvExp = cycle.CycleManager:getCycleLvData(self.mLv).needExp
    end
    local propsNum = data.reward[2]
    self.mTxtDes.text = name
    self.mTxtItemNum.text = "X" .. propsNum
    self.mTxtLv.text = self.mLv
    if self.mLv < self.curLv then
        self.mIneligible:SetActive(false)
        self.mReceived:SetActive(false)
        self.mReceive:SetActive(true)
        self.mImgLvState:SetActive(true)
        self.mImgLvState2:SetActive(false)
        self.mImgLine_01.color = gs.ColorUtil.GetColor("0057FFff")
        self.mImgLvFill.fillAmount = 1
        self.mTxtLv.color = gs.ColorUtil.GetColor("202226ff")
        self.mTxtTile_01.color = gs.ColorUtil.GetColor("202226ff")
    elseif self.mLv == self.curLv then
        self.mReceive:SetActive(true)
        self.mIneligible:SetActive(false)
        self.mReceived:SetActive(false)
        self.mTxtLv.color = gs.ColorUtil.GetColor("202226ff")
        self.mTxtTile_01.color = gs.ColorUtil.GetColor("202226ff")
        self.mImgLvState:SetActive(true)
        self.mImgLvState2:SetActive(false)
        self.mImgLvFill.fillAmount = cycle.CycleManager.mHistoryInfo.exp / self.nextLvExp
        self.mImgLine_01.color = gs.ColorUtil.GetColor("0057FFff")
    elseif self.mLv > self.curLv then
        self.mReceive:SetActive(false)
        self.mIneligible:SetActive(true)
        self.mReceived:SetActive(false)
        self.mTxtLv.color = gs.ColorUtil.GetColor("82898cff")
        self.mTxtTile_01.color = gs.ColorUtil.GetColor("82898cff")
        self.mImgLvState:SetActive(false)
        self.mImgLvState2:SetActive(true)
        self.mImgLine_01.color = gs.ColorUtil.GetColor("364055ff")
        self.mImgLvFill.fillAmount = 0
    end
    if self.mLv == maxLen then
        self.mImgLvFill.gameObject:SetActive(false)
        self.mImgLine_02:SetActive(false)
    end
    if next(cycle.CycleManager.mHistoryInfo.gained_lv_reward_list) then
        for _, v in pairs(cycle.CycleManager.mHistoryInfo.gained_lv_reward_list) do
            if v == self.mLv then
                self.mReceived:SetActive(true)
                self.mIneligible:SetActive(false)
                self.mReceive:SetActive(false)
                break
            end
        end
    end
end

function active(self)
    super.active(self)
    self.mImgProps:SetImg(UrlManager:getIconPath(self.propsUrl), false)
    self:setData(self.data)
end

function deActive(self)
    super.deActive(self)
    self:recover()
end

function recover(self)
    self.mImgLine_02:SetActive(true)
    self.mImgLvFill.gameObject:SetActive(true)
end

function onClickHandler(self)
    if self.mLv > self.curLv then
        return
    else
        cycle.CycleManager:onClickReceiveItem(self.mLv)
    end

end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]