--[[ 
-----------------------------------------------------
@filename       : WelfareOptSevenDayItem
@Description    : 新手目标Item
@date           : 2022-03-28
@Author         : lyx
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.tab.WelfareOptSevenDayItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mGridProp = nil
    self.mGridProp2 = nil
    self.mPropsVo = nil
    self.serverVo = nil
    self.awardPropsList = {}
    self.mImgBg = self:getChildGO("mImgBg")
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
   -- self.mImgState = self:getChildGO("mImgState"):GetComponent(ty.Image)
    self.mTxtStageDesc = self:getChildGO("mTxtStageDesc"):GetComponent(ty.Text)
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mSlider = self:getChildGO("mSlider"):GetComponent(ty.Image)
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnGoto = self:getChildGO("mBtnGoto")
    self.mTxtBtn = self:getChildGO("mTxtBtn"):GetComponent(ty.Text)
    self:addOnClick(self.mBtnGet, self.onClickRecHandler)
    self:addOnClick(self.mBtnGoto, self.onClickGotoHandler)
    self.mImgHasRec = self:getChildGO("mImgHasRec")
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

-- -- 由MonoBehaviour Start 调用
-- function onStart(self)
--     if self.data.isFrist == false then
--         self.mAnimator:SetTrigger("show01")
--     else
--         self.mAnimator:SetTrigger("show")
--     end
-- end

function setData(self, param)
    super.setData(self, param)
    self:recoverGrid()
    self.mPropsVo = self.data.localData
    self.serverVo = self.data.serverData
    self.mGridProp = PropsGrid:create(self:getChildTrans("mImgHolder1"), self.mPropsVo.reward[1], 0.65)
    self.mGridProp2 = PropsGrid:create(self:getChildTrans("mImgHolder2"), self.mPropsVo.reward[2], 0.65)
    self.mTxtStageDesc.text = _TT(self.mPropsVo.describe)
    self.mTxtProgress.text = self.serverVo.count .. "/" .. self.mPropsVo.time
    self.mSlider.fillAmount = self.serverVo.count / self.mPropsVo.time
    if (self.serverVo.state == 2) then   --已领取
        self.mBtnGet:SetActive(false)
        self.mBtnGoto:SetActive(false)
        self.mImgHasRec:SetActive(true)
        -- self.mImgState.gameObject:SetActive(false)
    else
        -- self.mImgState.gameObject:SetActive(true)
        if (self.serverVo.state == 0) then --达成
            self.mBtnGet:SetActive(true)
            self.mBtnGoto:SetActive(false)
            self.mImgHasRec:SetActive(false)
            self.mTxtBtn.text = _TT(412)  -- "领取"
            -- self.mImgState.color=gs.ColorUtil.GetColor("FCAD48ff")
        else    --未达成
            -- self.mImgState.color = gs.ColorUtil.GetColor("202226ff")
            self.mBtnGet:SetActive(false)
            self.mBtnGoto:SetActive(true)
            self.mImgHasRec:SetActive(false)
            self.mTxtBtn.text = _TT(4)    -- "前往"
        end
    end
    self:setGuideTrans("guide_WelfareOpt_SevenDayItem" .. self.serverVo.id, self.mBtnGet.transform)
end

function onClickRecHandler(self)
    if (self.serverVo.state == 0) then --完成未领取
        GameDispatcher:dispatchEvent(EventName.REQ_ACTIVITY_TARGET_GAIN_AWARD, { self.serverVo.id })
        for i = 1, #self.mPropsVo.reward do
            local props = props.PropsManager:getPropsVo({ tid = self.mPropsVo.reward[i][1], num = self.mPropsVo.reward[i][2] })
            table.insert(self.awardPropsList, props)
        end
    end
end

function onClickGotoHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = self.mPropsVo.uiCode })
end

function recoverGrid(self)
    if self.mGridProp then
        self.mGridProp:poolRecover()
        self.mGridProp = nil
    end
    if self.mGridProp2 then
        self.mGridProp2:poolRecover()
        self.mGridProp2 = nil
    end
    for i = 1, #self.awardPropsList do
        self.awardPropsList[i]:poolRecover()
    end
    self.awardPropsList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]