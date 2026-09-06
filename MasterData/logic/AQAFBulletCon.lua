-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFBulletCon.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFBulletCon", package.seeall)

local AQAFBulletCon = class("AQAFBulletCon")

function AQAFBulletCon:ctor(container, view)
	self._view = view
	self.curUnit = nil
	self.isDie = true

	self:buildUI(container)
end

function AQAFBulletCon:buildUI(container)
	self.container = container
	self.img = goutil.findChild(self.container, "img")
end

function AQAFBulletCon:setUnit(unit)
	self.curUnit = unit

	if self.curUnit then
		self.isDie = false

		self:updatePos()
		self:updateRotate()

		self.container.name = "bullet_" .. self.curUnit.id

		local cfg = self.curUnit._bulletCfg

		GameUtil.setLocalRotation(self.img, 0, 0, cfg.relativeRotate)
		GameUtil.setLocalPos(self.img, cfg.relativePos[1], cfg.relativePos[2], 0)

		local scale = cfg.relativeScale

		GameUtil.setLocalScale(self.img, scale, scale, scale)

		if self._path ~= cfg.resPath then
			self._path = cfg.resPath

			local picPath = string.format("%s.png", cfg.resPath)

			uGuiUtil.setSpriteToImage(self.img.gameObject, uGuiUtil.SpriteType.BigBg, picPath, function()
				local img = self.img.gameObject:GetComponent(goutil.Type_UIImage)

				img:SetNativeSize()

				img.raycastTarget = false
			end)
		end

		goutil.setActive(self.container, true)
	end
end

function AQAFBulletCon:lateUpdate()
	if self.isDie then
		self:reset()

		return
	end

	if self.curUnit then
		if not self.curUnit:isActive() then
			self:reset()

			return
		end

		if self.curUnit.isMove then
			self:updatePos()
		end

		if self.curUnit.isRotate then
			self:updateRotate()
		end
	end
end

function AQAFBulletCon:updatePos()
	if self.curUnit then
		GameUtil.setLocalPos(self.container, self.curUnit.position.x, self.curUnit.position.y, 0)
	end
end

function AQAFBulletCon:updateRotate()
	if self.curUnit then
		GameUtil.setLocalRotation(self.container, 0, 0, self.curUnit.rotationZ)
	end
end

function AQAFBulletCon:reset()
	goutil.setActive(self.container, false)
end

function AQAFBulletCon:destroy()
	self:reset()
	goutil.destroy(self.container)

	self.container = nil
end

function AQAFBulletCon:die()
	self.isDie = true

	self:reset()
end

return AQAFBulletCon
