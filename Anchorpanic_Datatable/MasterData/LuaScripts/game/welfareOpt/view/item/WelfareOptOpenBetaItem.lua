--[[ 
-----------------------------------------------------
@filename       : WelfareOptOpenBetaItem
@Description    : 公测福利Item
@date           : 2023-7-3 15:59
@Author         : tonn
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.item.WelfareOptOpenBetaItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mTxtItemDay = self:getChildGO("mTxtItemDay"):GetComponent(ty.Text)
    self.mTxtDay = self:getChildGO("mTxtDay"):GetComponent(ty.Text)
    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)
    self.mAniProps = self:getChildGO("mImgProps"):GetComponent(ty.Animator)
    self.mPropsRect = self:getChildGO("mImgProps"):GetComponent(ty.RectTransform)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
    self.mDayItem = self:getChildGO("mImgDayItemBg"):GetComponent(ty.AutoRefImage)
    self:getChildGO("mTxtCondition"):GetComponent(ty.Text).text = _TT(91003)
    self:addOnClick(self:getChildGO("mGet"), function()
        if self.canReceive then
            welfareOpt.WelfareOptOpenBetaManager:sendReceiveReq(self.day)
        else
            if not self.mIsPassMainStage then
                local stageVo = battleMap.MainMapManager:getStageVo(sysParam.SysParamManager:getValue(SysParamType.OPEN_BETA_MAINSTAGE_ID))
                if stageVo then
                    gs.Message.Show(_TT(53609, stageVo.indexName))
                end
            else
                gs.Message.Show(_TT(48134))
            end
        end
    end
    )
    self:addOnClick(self:getChildGO("mImgPropsClick"), function()
        TipsFactory:propsTips({ propsVo = self.mPropVo, isShowUseBtn = false }, { rectTransform = nil })
    end
    )
end

function active(self)
    super.active(self)
    welfareOpt.WelfareOptOpenBetaManager:addEventListener(welfareOpt.WelfareOptOpenBetaManager.UPDATE_RECEIVE_AWARD, self.updateView, self)
    self:_playAni()
end


-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    welfareOpt.WelfareOptOpenBetaManager:removeEventListener(welfareOpt.WelfareOptOpenBetaManager.UPDATE_RECEIVE_AWARD, self.updateView, self)
end


function setData(self, param)
    super.setData(self, param)
    if self.data then
        self.day = self.data.day
        local mCNDay = welfareOpt.WelfareOptOpenBetaManager:getDayChineseById(self.data.day)
        self.mTxtItemDay.text = _TT(91004, mCNDay)
        self.mTxtDay.text = "0" .. self.data.day
        self.mTxtNum.text = "X" .. self.data.num
        self.mPropVo = props.PropsManager:getPropsConfigVo(self.data.itemTid)
        self.mTxtName.text = self.mPropVo.name
        self.mImgProps:SetImg(UrlManager:getIconPath(self.mPropVo.icon), false)
        local mMainStageId = battleMap.MainMapManager:getMainMapCurStage()
        self.mIsPassMainStage = mMainStageId > sysParam.SysParamManager:getValue(SysParamType.OPEN_BETA_MAINSTAGE_ID)
        self:getChildGO("mTxtCondition"):SetActive(self.mIsPassMainStage == false)
        self:updateView()
    end

end

-- 覆盖基类Start
function onStart(self)

    local tween = self.UIObject:GetComponent(ty.UIDoTween)
    if not gs.GoUtil.IsCompNull(tween) and self:getTweenIndex() then
        if self.mGroupItem then
            self.mGroupItem:SetActive(false)
            self:onTweenStart(self:getTweenIndex() * 0.02)
        end
    end

end

--覆盖基类DoTween动画
function onTweenStart(self, time)
    local function callTween()
        if (not gs.GoUtil.IsCompNull(self.UIObject:GetComponent(ty.UIDoTween))) then
            if self.mGroupItem then
                self.mGroupItem:SetActive(true)
                self.UIObject:GetComponent(ty.UIDoTween):BeginTween()
                self:_playAni()
            end
        end
    end
    LoopManager:clearTimeout(self.tweenTimeSn)
    self.tweenTimeSn = LoopManager:setTimeout(time, self, callTween)
end

--更新UI
function updateView(self)
    local msgVo = welfareOpt.WelfareOptOpenBetaManager:getMsgVoById(self.day)
    local received = msgVo > 0
    self:getChildGO("mGot"):SetActive(received)
    local nowOpenDay = welfareOpt.WelfareOptOpenBetaManager:getOpenDays()
    self.canReceive = nowOpenDay >= self.day and self.mIsPassMainStage
    self.mDayItem:SetImg(UrlManager:getPackPath(self.canReceive and "welfareOptOpenBeta/pnl_03.png" or "welfareOptOpenBeta/pnl_06.png"), false)
    if self.canReceive then
        if received then
            self:getChildGO("mImgPropsClick"):SetActive(true)
            self:getChildGO("mGroupRecFx"):SetActive(false)
            self:getChildGO("mGroupRecFx01"):SetActive(false)
            self.isPlayPropsAni = false
        else
            self:getChildGO("mGroupRecFx"):SetActive(true)
            self:getChildGO("mGroupRecFx01"):SetActive(true)
            self:getChildGO("mImgPropsClick"):SetActive(false)
            self.isPlayPropsAni = true
        end
    else
        self:getChildGO("mImgPropsClick"):SetActive(true)
        self:getChildGO("mGroupRecFx"):SetActive(false)
        self:getChildGO("mGroupRecFx01"):SetActive(false)
        self.isPlayPropsAni = false
    end
    self:_playAni()
end

--播放动画
function _playAni(self)
    if self.mAniProps then
        self.mAniProps:SetBool("show", self.isPlayPropsAni)
    else
        self.mAniProps = self:getChildGO("mImgProps"):GetComponent(ty.Animator)
        self.mAniProps:SetBool("show", self.isPlayPropsAni)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]