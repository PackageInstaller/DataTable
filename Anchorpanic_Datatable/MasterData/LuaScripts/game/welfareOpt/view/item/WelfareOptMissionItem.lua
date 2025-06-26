--[[ 
-----------------------------------------------------
@filename       : WelfareNoviceMissionItem
@Description    : 新手目标Item
@date           : 2022-03-28
@Author         : lyx
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]] module("game.welfareOpt.view.tab.WelfareOptNoviceMissionItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mGridProp = {}
    self.mPropsVo = nil
    self.configVo = nil
    self.awardPropsList = {}
    self.mImgBg = self:getChildGO("mImgBg")
    self.mTxtStageDesc = self:getChildGO("mTxtStageDesc"):GetComponent(ty.Text)
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mSlider = self:getChildGO("mSlider"):GetComponent(ty.Slider)
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnGoto = self:getChildGO("mBtnGoto")
    self.mTxtBtn = self:getChildGO("mTxtBtn"):GetComponent(ty.Text)
    self:addOnClick(self.mBtnGet, self.onClickRecHandler)
    self:addOnClick(self.mBtnGoto, self.onClickGotoHandler)
    self.mImgItemState = self:getChildGO("mImgItemState"):GetComponent(ty.Image)
    self.mImgHasRec = self:getChildGO("mImgHasRec")
    self.mRedPoint0 = self:getChildTrans("mRedPoint0")
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
    self:removeOnClick(self.mBtnGet, self.onClickRecHandler)
    self:removeOnClick(self.mBtnGoto, self.onClickGotoHandler)
    self:recoverGrid()
end

function setData(self, param)
    super.setData(self, param)
    self:recoverGrid()
    self.mPropsVo = self.data
    self.configVo = welfareOpt.WelfareOptManager:getNoviceData(self.mPropsVo.id)
    for i, rewardVo in ipairs(self.configVo.mReward) do
        local item = PropsGrid:create(self:getChildTrans("mAwardGroup"), rewardVo, 1)
        item:setCountTextSize(24)
        table.insert(self.mGridProp, item)
    end
    self.mTxtStageDesc.text = _TT(self.configVo.mDescribe)
    local color = self.mPropsVo.count >= self.configVo.mTime and "03950dff" or "d53529ff"
    self.mTxtProgress.text = HtmlUtil:color(self.mPropsVo.count, color) .. "/" .. self.configVo.mTime
    self.mSlider.value = self.mPropsVo.count == 0 and 0 or self.mPropsVo.count / self.configVo.mTime

    if (self.mPropsVo.state == 2) then -- 已领取
        self.mBtnGet:SetActive(false)
        self.mBtnGoto:SetActive(false)
        self.mImgHasRec:SetActive(true)
        self.mImgItemState.color = gs.ColorUtil.GetColor("202226ff")
    else
        if (self.mPropsVo.state == 0) then -- 达成
            self.mBtnGet:SetActive(true)
            self.mBtnGoto:SetActive(false)
            self.mImgHasRec:SetActive(false)
            self.mTxtBtn.text = _TT(412) -- "领取"
            self.mImgItemState.color = gs.ColorUtil.GetColor("FCAD48ff")
        else -- 未达成
            self.mBtnGet:SetActive(false)
            self.mBtnGoto:SetActive(true)
            self.mImgHasRec:SetActive(false)
            self.mTxtBtn.text = _TT(4) -- "前往"
            self.mImgItemState.color = gs.ColorUtil.GetColor("202226ff")
        end
    end

    self:setGuideTrans("guide_WelfareOpt_MissionItem" .. self.mPropsVo.id, self.mBtnGet.transform)
end

function onClickRecHandler(self)
    if (self.mPropsVo.state == 0) then -- 完成未领取
        GameDispatcher:dispatchEvent(EventName.REQ_TRAINER_REWARD, {self.mPropsVo.id})
        local vo = welfareOpt.WelfareOptManager:getNoviceData(self.mPropsVo.id)
        for i = 1, #vo.mReward do
            local props = props.PropsManager:getPropsVo({
                tid = vo.mReward[i][1],
                num = vo.mReward[i][2]
            })
            table.insert(self.awardPropsList, props)
        end
        GameDispatcher:dispatchEvent(EventName.REQ_TRAINER_PANEL)
    end
end

function onClickGotoHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
        linkId = self.configVo.mUiCode
    })
end

function recoverGrid(self)
    if #self.mGridProp > 0 then
        for i, vo in ipairs(self.mGridProp) do
            vo:poolRecover()
            vo = nil
        end
        self.mGridProp = {}
    end

    for i = 1, #self.awardPropsList do
        self.awardPropsList[i]:poolRecover()
    end
    self.awardPropsList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
