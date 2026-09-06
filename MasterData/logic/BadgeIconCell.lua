-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/badge/BadgeIconCell.lua

module("logic.extensions.material.proxy.badge.BadgeIconCell", package.seeall)

local BadgeIconCell = class("BadgeIconCell", MaterialCell)

function BadgeIconCell:ctor(target)
	BadgeIconCell.super.ctor(self, target)

	self._btn = Framework.ButtonAdapter.Get(self.target)
	self._imgC_Bg = goutil.findChildComponent(self.target, "ImgC_Bg", "UIImageSpriteChange")
	self._iconMask = goutil.findChildComponent(self.target, "icon", "Mask")
	self._icon = goutil.findChild(self.target, "icon/Image")
	self._badgeBgChange = goutil.findChildComponent(self.target, "icon/badgeBg", "UIImageSpriteChange")
	self._iconImage = goutil.findChildComponent(self.target, "icon", goutil.Type_UIImage)
	self._pet = goutil.findChild(self.target, "icon/pet")
	self._farme = goutil.findChild(self.target, "farme")
	self._attrBg = goutil.findChildComponent(self.target, "farme/attrBg", "UIImageSpriteChange")
	self._attrIcon = goutil.findChildComponent(self.target, "farme/attrBg/icon", "UIImageSpriteChange")
	self._jobIcon = goutil.findChildComponent(self.target, "farme/jobBg/icon", "UIImageSpriteChange")
	self._jobIcon2 = goutil.findChildComponent(self.target, "farme/jobBg/icon2", "UIImageSpriteChange")

	self._btn:AddClickListener(self._OnClick, self)

	self._petImg = self._pet:GetComponent(goutil.Type_UIImage)
	self._cacheMat = self._petImg.material
end

function BadgeIconCell:setCfgData(cfg)
	BadgeIconCell.super.setCfgData(self, cfg)

	if cfg.petHead then
		goutil.setActive(self._farme, true)
		goutil.setActive(self._icon, false)
		GameUtil.SetActive(self._badgeBgChange, false)
		goutil.setActive(self._pet, true)

		self._iconImage.enabled = true
		self._iconMask.enabled = true

		local petMo = CharacterConfig.instance:getModelCo(cfg.petHead[1])

		uGuiUtil.setSpriteToImage(self._pet, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petMo.headName))

		local petCo = CharacterConfig.instance:getPetCo(cfg.petHead[1])

		uGuiUtil.setSpriteToImage(self._farme, uGuiUtil.SpriteType.BigBg, BadgeModel.instance:getPetBadgeFrameUrl(petCo.rare))

		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(cfg.petHead[1])

		race = race % 10

		self._attrBg:SetState(race - 1)
		self._attrIcon:SetState(race - 1)

		local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(cfg.petHead[1])

		if secondJobIdx > 0 then
			self._jobIcon2:SetState(secondJobIdx - 1 - 20)
			goutil.setActive(self._jobIcon.gameObject, false)
			goutil.setActive(self._jobIcon2.gameObject, true)
		else
			local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.petHead[1])

			self._jobIcon:SetState(firstJobIdx - 1)
			goutil.setActive(self._jobIcon.gameObject, true)
			goutil.setActive(self._jobIcon2.gameObject, false)
		end

		if cfg.quality then
			self._imgC_Bg:SetState(cfg.quality)
		else
			local rare = CharacterConfig.instance:getRareByAwakenLv(petCo.initAwakenLv)

			self._imgC_Bg:SetState(rare + 1)
		end
	else
		goutil.setActive(self._farme, false)
		goutil.setActive(self._icon, true)
		GameUtil.SetActive(self._badgeBgChange, false)
		goutil.setActive(self._pet, false)

		self._iconImage.enabled = false
		self._iconMask.enabled = false

		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, BadgeConfig.instance:getCommonValue("URL_ICON") .. cfg.icon)
		GameUtil.setAnchoredPos(self._icon, 0, 0)
		GameUtil.setLocalScale(self._icon, 1, 1, 1)
		self._imgC_Bg:SetState(cfg.quality)
	end

	goutil.setActive(self._imgC_Bg.gameObject, true)
end

function BadgeIconCell:_OnClick()
	if self.autoTips and self.cfg then
		CommonTipsMgr.instance:_openOneView(ViewName.BadgeTipView, self.cfg.id)
	end

	GameUtil.callBack(self.callback, self.handler)
end

function BadgeIconCell:setClick(clickFunc, obj)
	self.callback = clickFunc
	self.handler = obj
end

function BadgeIconCell:setLevel(level)
	self._level = level

	if level and checknumber(self.cfg.iconGroupId) > 0 and not self.cfg.petHead then
		local groupCfg = BadgeConfig.instance:getIconGroup(self.cfg.iconGroupId)
		local iconRes = self.cfg.icon

		iconRes = groupCfg[self._level] and groupCfg[self._level].icon or groupCfg[#groupCfg].icon

		GameUtil.SetActive(self._badgeBgChange, false)
		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, BadgeConfig.instance:getCommonValue("URL_ICON") .. iconRes)
		GameUtil.setLocalScale(self._icon, 1, 1, 1)
		GameUtil.setAnchoredPos(self._icon, 0, 0)

		if groupCfg and #groupCfg >= 3 then
			GameUtil.setLocalScale(self._icon, 0.7, 0.7, 0.7)
			GameUtil.setAnchoredPos(self._icon, 0, -6)
			GameUtil.SetActive(self._badgeBgChange, true)

			if level then
				self._badgeBgChange:SetState(math.min(level - 1, 2))
			else
				self._badgeBgChange:SetState(0)
			end
		else
			GameUtil.SetActive(self._badgeBgChange, false)
		end
	end
end

function BadgeIconCell:setBadgeBg(bool)
	GameUtil.SetActive(self._badgeBgChange, bool)

	if not bool then
		GameUtil.setLocalScale(self._icon, 1, 1, 1)
		GameUtil.setAnchoredPos(self._icon, 0, 0)
	else
		GameUtil.setLocalScale(self._icon, 0.7, 0.7, 0.7)
		GameUtil.setAnchoredPos(self._icon, 0, -6)
	end
end

function BadgeIconCell:removeClick()
	self.callBack = nil
	self.handler = nil
end

function BadgeIconCell:setGray(isGray)
	uGuiUtil.setImageGrayStateRecursive(self.target, isGray)

	if not isGray then
		self._petImg.material = self._cacheMat
	end
end

function BadgeIconCell:setActiveImgC_Bg(flag)
	goutil.setActive(self._imgC_Bg.gameObject, flag)
end

return BadgeIconCell
