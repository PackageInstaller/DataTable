local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local BagNewArtifactRightInfoComp = class("BagNewArtifactRightInfoComp", require("app.fairyGUI.bagNew.UI_BagNewArtifactRightInfoComp"))

function BagNewArtifactRightInfoComp:ctor(arg_1_1)
	self.m_tipsBtn:addClickListener(handler(self, self._onTipsBtnClick))
	self.m_developBtn:addClickListener(handler(self, self._onBtnClick))
	self.m_enhanceLable:addClickListener(handler(self, self._onShowAttrsClick))
	self.m_relatedKnight:addClickListener(handler(self, self._onKnightIconClick))

	self._isFrag = false
end

function BagNewArtifactRightInfoComp:playEnterAnim()
	if self.m_enterTransition then
		self.m_enterTransition:play()
	end
end

function BagNewArtifactRightInfoComp:updateComp(arg_3_1, arg_3_2)
	self._isFrag = arg_3_2
	self._artifactStruct = arg_3_1

	self.m_typeController:setSelectedIndex(self._isFrag and 1 or 0)

	if arg_3_1 then
		self._baseId = arg_3_1:getArtifactBaseId()
		self._belongToKnightId = self._artifactStruct:getBelongToKnightAvdIdIncludingMainRole()

		if self._belongToKnightId then
			self.m_relatedKnight:getChild("maskKnightIcon"):updateBelongToIcon(self._belongToKnightId)
		end

		if self._isFrag then
			local var_3_0, var_3_1 = arg_3_1:getFragNums()

			if arg_3_1:isOwn() then
				local var_3_2, var_3_3, var_3_4 = arg_3_1:canStarUp()

				self.m_progNumText:setText(var_3_1 .. "/" .. var_3_3)
			else
				self.m_progNumText:setText(var_3_1 .. "/" .. var_3_0)
			end
		end

		self:_updateAttrs()
		self:_updateSkill()
		self:_updateBaseInfo()
		self:_updateBtn()
	end
end

function BagNewArtifactRightInfoComp:_updateAttrs()
	if self._isFrag then
		self._baseAttrsData = self._artifactStruct:getBaseAttrsData(true)
	else
		self._baseAttrsData = self._artifactStruct:getBaseAttrsData()

		self.m_starComp:initStar({
			index = 3,
			style = 2,
			gap = -55,
			max = self._artifactStruct:getMaxStar(),
			num = self._artifactStruct:getStar()
		})
	end

	for iter_4_0 = 1, 4 do
		if self["m_adAttr" .. iter_4_0] then
			if self._baseAttrsData[iter_4_0] then
				self["m_adAttr" .. iter_4_0]:setVisible(true)
				self["m_adAttr" .. iter_4_0]:updateAttr(self._baseAttrsData[iter_4_0])
			else
				self["m_adAttr" .. iter_4_0]:setVisible(false)
			end
		end
	end
end

function BagNewArtifactRightInfoComp:_updateSkill()
	self.m_skillIcon:updateIcon({
		artifact = self._artifactStruct,
		knightPos = self._knightPos,
		isFrag = self._isFrag
	})
	self.m_descTxt:setText(var_0_1.artifactData:getSkillEnhanceInfoByBaseId(self._baseId).description)
	self.m_skillNameTxt:setText(self._artifactStruct:getSkillInfo().name)
end

function BagNewArtifactRightInfoComp:_updateBaseInfo()
	self.m_infoBaseComp:setData({
		bgScale = 0.5,
		bgOpacity = 0.7,
		title = self._artifactStruct:getArtifactName(),
		loaderUrl = var_0_0:getBagNewQualityBgPath(self._artifactStruct:getQuality()),
		icon = g.core.common.Path:getArtifactImg(self._artifactStruct:getCfg().res_id),
		bgUrl = g.core.common.Path:getArtifactGroupIcon((self._artifactStruct:getBelongToGroup()))
	})
end

function BagNewArtifactRightInfoComp:_updateBtn()
	self.m_developBtn:setVisible(true)

	if self._isFrag then
		if self._artifactStruct:isOwn() then
			if self._artifactStruct:canStarUp() then
				self.m_developBtn:setTitle(g.core.lang:get(205503))
			elseif self._artifactStruct:isMaxStar() then
				self.m_developBtn:setVisible(false)
			else
				self.m_developBtn:setTitle(g.core.lang:get(205522))
			end
		elseif self._artifactStruct:canCompose() then
			self.m_developBtn:setTitle(g.core.lang:get(205523))
		else
			self.m_developBtn:setTitle(g.core.lang:get(205522))
		end
	elseif self._artifactStruct:canStarUp() then
		self.m_developBtn:setTitle(g.core.lang:get(205503))
	elseif self._artifactStruct:isLineup() then
		self.m_developBtn:setTitle(g.core.lang:get(205502))
	else
		self.m_developBtn:setTitle(g.core.lang:get(205521))
	end
end

function BagNewArtifactRightInfoComp:_onBtnClick()
	if self._isFrag then
		if self._artifactStruct:isOwn() then
			if self._artifactStruct:canStarUp() then
				if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP) then
					g.core.module.ModuleManager:pushModule(g.view.entrance.ARTIFACT_DEVELOP, {
						tabType = 3,
						artifact = self._artifactStruct
					})
				end
			elseif not self._artifactStruct:isMaxStar() and g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ARTIFACT_BASE) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT, {
					route1 = 5
				})
			end
		elseif self._artifactStruct:canCompose() then
			g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
				num = 1,
				id = self._artifactStruct:getCfg().fragment_id
			})
		elseif g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ARTIFACT_BASE) then
			g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT, {
				route1 = 5
			})
		end
	elseif g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT) then
		if self._artifactStruct:canStarUp() then
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.ARTIFACT_DEVELOP, {
					tabType = 3,
					artifact = self._artifactStruct
				})
			end
		elseif self._artifactStruct:isLineup() then
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_ENHANCE) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.ARTIFACT_LINE_UP, {
					tabType = 2,
					knightIndex = self._artifactStruct:getFormationPos()
				})
			end
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.ARTIFACT_DEVELOP, {
				artifact = self._artifactStruct
			})
		end
	end
end

function BagNewArtifactRightInfoComp:_onTipsBtnClick()
	if not self._isFrag and self._artifactStruct then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.artifact.view.ArtifactInfoPop").new({
			baseId = self._artifactStruct:getArtifactBaseId()
		}), {
			touchDisappear = true
		})
	end
end

function BagNewArtifactRightInfoComp:_onShowAttrsClick()
	if self._artifactStruct then
		local var_10_0

		if not self._isFrag then
			var_10_0 = require("app.view.module.artifact.view.ArtifactStarUpAttrPop").new({
				starUpShowAttrs = self._artifactStruct:getPopShowStarAttrs(),
				isFullStar = self._artifactStruct:isMaxStar(),
				isExclutive = self._artifactStruct:isNonExclusive()
			})
		else
			local var_10_1 = require("app.view.module.artifact.view.ArtifactStarUpAttrPop").new
			local var_10_2 = {
				isFullStar = true
			}

			var_10_2.starUpShowAttrs = self._artifactStruct:getPopShowStarAttrs((self._artifactStruct:getMaxStarId()))
			var_10_0 = require("app.view.module.artifact.view.ArtifactStarUpAttrPop").new(var_10_2)
		end

		g.core.module.ModuleManager:pushPopup(nil, {
			touchDisappear = true
		})
	end
end

function BagNewArtifactRightInfoComp:_onKnightIconClick()
	if self._artifactStruct then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightAdvId = self._artifactStruct:getBelongToKnightAvdIdIncludingMainRole()
		}), {
			hideContinue = true,
			touchDisappear = true
		})
	end
end

return BagNewArtifactRightInfoComp
