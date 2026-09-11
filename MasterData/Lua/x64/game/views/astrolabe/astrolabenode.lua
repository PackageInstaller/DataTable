local AstrolabeNode = class("AstrolabeNode")

function AstrolabeNode:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.data_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.transform_.localPosition = Vector3(0, 0, 0)
	self.posX = arg_1_3
	self.aniStrCfg = {
		"yellow",
		"red",
		"blue"
	}

	self:InitUI()
	self:Init()
end

function AstrolabeNode:SetParent(arg_2_1)
	if self.transform_ then
		self.transform_:SetParent(arg_2_1)

		self.transform_.localEulerAngles = Vector3(0, 0, 0)
		self.transform_.localPosition = Vector3(0, 0, 0)
		self.transform_.localScale = Vector3(1, 1, 1)
	end
end

function AstrolabeNode:RefreshData(arg_3_1, arg_3_2)
	self.data_ = arg_3_1
	self.info_ = arg_3_2

	self:Render()
end

function AstrolabeNode:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.transform_)
	self.itemEventtriggerlistener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(self, self.OnClick)))
end

function AstrolabeNode:Render()
	self:RefreshUI(self.info_)
end

function AstrolabeNode:RefreshUI(arg_6_1, arg_6_2)
	self.textTm_.font = Asset.Load("Fonts/SourceHanSans_SDF", true)
	self.data_ = arg_6_1
	self.info_ = arg_6_2

	if arg_6_1 then
		if HeroTools.IsSpHero(arg_6_2.id) then
			if self.spAni_ then
				self.curAnimator.runtimeAnimatorController = self.spAni_.runtimeAnimatorController
			end

			self:ShowSpState(arg_6_1)
		else
			self.curAnimator.runtimeAnimatorController = ({
				self.yellowAni_,
				self.redAni_,
				self.blueAni_
			})[self.posX].runtimeAnimatorController

			self:ShowNormalState(arg_6_1)
		end

		self.textTm_.text = GetI18NText(HeroAstrolabeCfg[arg_6_1.id].name)

		if self.lineStar then
			SetActive(self.lineStar.gameObject, (self.heroViewProxy_:GetNextIsEquiped(arg_6_1.id, self.info_.id)))
		end
	end
end

function AstrolabeNode:ShowNormalState(arg_7_1)
	if arg_7_1.isEquiped then
		self.curAnimator:Update(0)
		self.curAnimator:Play("star1_" .. self.aniStrCfg[self.posX], 0, 0)

		self.nodeState = AstrolabeConst.NODE_STATE.EQUIPED
	elseif not arg_7_1.isUnlock then
		if arg_7_1.isCanLock then
			self.nodeState = AstrolabeConst.NODE_STATE.CANLOCK

			self.curAnimator:Play("lock1")
		else
			self.curAnimator:Play("lock2")

			self.nodeState = AstrolabeConst.NODE_STATE.LOCK
		end
	elseif arg_7_1.isUnlock then
		self.curAnimator:Play("star2_" .. self.aniStrCfg[self.posX])

		self.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
	end
end

function AstrolabeNode:ShowNextEffect()
	if self.lineStar then
		SetActive(self.lineStar.gameObject, (self.heroViewProxy_:GetNextIsEquiped(self.data_.id, self.info_.id)))
	end
end

function AstrolabeNode:ShowSelfEffect()
	if self.lineStar then
		SetActive(self.lineStar.gameObject, self.data_.isEquiped)
	end
end

function AstrolabeNode:ShowNextSpEffect()
	local var_10_0 = self.heroViewProxy_:GetNextSPNodeIsEquiped(self.data_.id, self.info_.id)

	if self.lineStar2 then
		SetActive(self.lineStar2.gameObject, (self.posX == 3 or nil) and self.heroViewProxy_:GetLastIsEquiped(self.data_.id, self.info_.id))
	end
end

function AstrolabeNode:ResetEffect()
	if self.lineStar2 then
		SetActive(self.lineStar2.gameObject, false)
	end

	if self.lineStar then
		SetActive(self.lineStar.gameObject, false)
	end
end

function AstrolabeNode:ShowSpState(arg_12_1)
	if arg_12_1.isEquiped then
		self.curAnimator:Play("star_sp_2")

		self.nodeState = AstrolabeConst.NODE_STATE.EQUIPED
	elseif not arg_12_1.isUnlock then
		self.nodeState = AstrolabeConst.NODE_STATE.LOCK

		self.curAnimator:Play("lock_sp_1")
	elseif arg_12_1.isUnlock then
		self.curAnimator:Play("star_sp_1")

		self.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
	end
end

function AstrolabeNode:ShowSelect(arg_13_1)
	if self.icon_selectGo_ then
		SetActive(self.icon_selectGo_, arg_13_1)
	end
end

function AstrolabeNode:Init()
	self:RefreshUI(self.info_)
end

function AstrolabeNode:SetNodeNameIsHide(arg_15_1)
	if self.textTm_ then
		SetActive(self.textTm_.gameObject, not arg_15_1)
	end

	self:SetRedPoint(false)
end

function AstrolabeNode:Dispose()
	self:RemoveAllListeners()

	self.clickFunc = nil

	if self.gameObject_ then
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
		self.transform_ = nil
	end
end

function AstrolabeNode:OnClick()
	if self.clickFunc then
		self:clickFunc()
	end
end

function AstrolabeNode:RemoveAllListeners()
	if self.gameObject_ and not isNil(self.gameObject_) then
		self.itemEventtriggerlistener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
	end
end

function AstrolabeNode:RegistCallBack(arg_19_1)
	self.clickFunc = arg_19_1
end

function AstrolabeNode:GetItemInfo()
	return self.data_
end

function AstrolabeNode:SetRedPoint(arg_21_1)
	if self.notice_imgGo_ then
		SetActive(self.notice_imgGo_, arg_21_1)
	end
end

function AstrolabeNode:SetProxy(arg_22_1)
	self.heroViewProxy_ = arg_22_1
end

return AstrolabeNode
