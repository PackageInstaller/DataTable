-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueRoleLiPaiItem.lua

module("logic.extensions.roguelike.view.widgets.RogueRoleLiPaiItem", package.seeall)

local M = class("RogueRoleLiPaiItem")
local kDefaultFov = 60

function M:ctor(go)
	self._go = go
	self._animation = self._go:GetComponent(ComponentType.Animation)

	local temp = ""

	self._goEmpty = goutil.findChild(go, "empty")
	go = goutil.findChild(go, "normal")
	self._goNormal = go
	self._imgIcon = goutil.findChildComponent(go, "cardBg/charaterIcon", UIComponentType.Image)
	self._imgCampIcon = goutil.findChildComponent(go, "cardBg/campIcon", UIComponentType.Image)
	self._txtHp = goutil.findChildComponent(go, "hp/txtHp", UIComponentType.Text)
	self._goSan = goutil.findChild(go, "san")
	self._goHp = goutil.findChild(go, "hp")
	self._goHpChange = goutil.findChild(go, "hpAffect")
	self._goSanChange = goutil.findChild(go, "sanAffect")
	self._txtHpChange = goutil.findChildComponent(go, "hpAffect/txtHp", UIComponentType.Text)
	self._txtSan = goutil.findChildComponent(go, "san/txtSan", UIComponentType.Text)
	self._txtSanChange = goutil.findChildComponent(go, "sanAffect/txtSan", UIComponentType.Text)
	self._txtIndex = goutil.findChildComponent(go, "cardInfo/Text1", UIComponentType.Text)
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._btnAdd = UIComponentType.ButtonAdapter(goutil.findChild(self._goEmpty, "btnAdd"))
	self._select1Go = goutil.findChild(go, "select")
	self._goLock = goutil.findChild(go, temp .. "lock")
	self._goModel = goutil.findChild(go, "RawImage")
	self._roleModel = Astral.LuaComponentContainer.Add(self._goModel, PhotoModel)

	self._roleModel:setModelLoadCallback(self._onModelLoaded, self)

	self._goSixDimensionInfo = goutil.findChild(go, temp .. "sixDimensionInfo")
	self._qua6Ploygon = UIPolygon.Get(goutil.findChild(go, temp .. "sixDimensionInfo/imgDimension"))

	self._qua6Ploygon:Init(6)

	if goutil.findChild(go, "sixDimensionInfo/power") ~= nil then
		self._txtQua6List = {
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/power/txtLevel", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/agile/txtLevel", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/Knowledge/txtLevel", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/communicate/txtLevel", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/insight/txtLevel", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/lucky/txtLevel", UIComponentType.Text)
		}
		self._txtQua6AddList = {
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/power/txtAffect", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/agile/txtAffect", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/Knowledge/txtAffect", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/communicate/txtAffect", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/insight/txtAffect", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/lucky/txtAffect", UIComponentType.Text)
		}
		self._goQua6SelectList = {
			goutil.findChild(go, temp .. "sixDimensionInfo/power/select"),
			goutil.findChild(go, temp .. "sixDimensionInfo/agile/select"),
			goutil.findChild(go, temp .. "sixDimensionInfo/Knowledge/select"),
			goutil.findChild(go, temp .. "sixDimensionInfo/communicate/select"),
			goutil.findChild(go, temp .. "sixDimensionInfo/insight/select"),
			goutil.findChild(go, temp .. "sixDimensionInfo/lucky/select")
		}
	else
		self._txtQua6List = {
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtPower", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtAgile", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtKnowledge", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtCommunicate", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtInsight", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtLucky", UIComponentType.Text)
		}
	end

	local qua6SelectPloygonGo = goutil.findChild(go, temp .. "sixDimensionInfo/imgDimensionAffect")

	if qua6SelectPloygonGo then
		self._qua6SelectPloygon = UIPolygon.Get(qua6SelectPloygonGo)

		self._qua6SelectPloygon:Init(6)
	end

	self:bindEvents()

	self._changeAniList = {}
end

function M:_onModelLoaded(inst, res)
	if not inst then
		return
	end

	TransformUtils.SetEulerAngles(inst.transform, 0, 180, 0)
	Astral.GameObjectUtil.SetLayerRecursively(inst, SceneLayer.Unit_Value)
	self._roleModel:setCameraCullingLayer(SceneLayer.Unit_Value)
	self._roleModel:setCameraTag(SceneTag.RTCamera)

	if self._enterAni then
		self._roleModel:playAni(self._enterAni)
	end

	if self._isAttackPlane then
		local plateObjPrefix = "common_pt606_new/prefab/%s"
		local resPath = GameUrl.getScenePrefabUrl(string.format(plateObjPrefix, "s606_plane_select_role"))

		self:attachEffect("effect", resPath)
		self:setCameraFov(16)
		self:setCameraPosition(0, 0.6, -10)
	end
end

function M:bindEvents()
	if self._isBind then
		return
	end

	self._btnClick:AddClickListener(self.onClick, self)
	self._btnAdd:AddClickListener(self.onClick, self)

	self._isBind = true
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
	self._btnAdd:RemoveClickListener()

	self._isBind = false

	self:setCameraFov(kDefaultFov)
	removetimer(self.delayShowHighLight, self)
end

function M:setAttackPlane()
	self._isAttackPlane = true
end

function M:attachEffect(attachName, resPath)
	self._roleModel:clearAttachEffect(attachName)
	self._roleModel:attachEffect(attachName, resPath, SceneLayer.Unit_Value)

	self._isAttackEffect = true
end

function M:setCameraFov(fieldOfView)
	self._roleModel:setCameraFov(fieldOfView)
end

function M:setCameraPosition(x, y, z)
	self._roleModel:setCameraPosition(x, y, z)
end

function M:setHp(hp)
	self._txtHp.text = hp
end

function M:setHpChange(change)
	if change == 0 then
		return
	end

	self._txtHpChange.text = change > 0 and string.format("+%d", change) or string.format("%d", change)

	goutil.setActive(self._txtHpChange.gameObject, true)
	table.insert(self._changeAniList, 1)
	self:showChangeAni()
end

function M:setCard(san)
	self._txtSan.text = san > 0 and string.format("%d", san) or string.format("%d", san)
end

function M:setSanChange(change)
	if change == 0 then
		return
	end

	self._txtSanChange.text = change > 0 and string.format("+%d", change) or string.format("%d", change)

	goutil.setActive(self._txtSanChange.gameObject, true)
	table.insert(self._changeAniList, 2)
	self:showChangeAni()
end

function M:showChangeAni()
	if #self._changeAniList > 1 or #self._changeAniList == 0 then
		return
	end

	local last = self._changeAniList[#self._changeAniList]

	if last == 1 then
		goutil.setActive(self._goHpChange, true)
	else
		goutil.setActive(self._goSanChange, true)
	end

	settimer(2, self._delayHideChangeAni, self, false)
end

function M:_delayHideChangeAni()
	if #self._changeAniList > 1 then
		goutil.setActive(self._goHpChange, false)
		goutil.setActive(self._goSanChange, false)
	end

	table.remove(self._changeAniList, 1)
	self:showChangeAni()
end

function M:setIndex(index)
	if self._txtIndex then
		-- block empty
	end
end

function M:setHeadIcon(roleId, useHeadIcon)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)
	local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

	if useHeadIcon then
		-- block empty
	end
end

function M:setSelect(isSelect)
	goutil.setActive(self._select1Go, isSelect)
end

function M:updateData(data)
	local roleId = data.roleId

	self._roleId = roleId
	self._enterAni = data.enterAni
	self._index = data.index

	self:setIndex(data.index)

	self._attrChangeList = data.attrChange
	self._isAllowEmptyClick = data.isAllowEmptyClick

	if self._imgCampIcon then
		goutil.setActive(self._imgCampIcon.gameObject, roleId ~= 0)

		if roleId ~= 0 then
			local characterCo = CharacterConfig.instance:getCharacterItemInfo(roleId)
		end
	end

	if self._isAttackEffect == true then
		self._roleModel:clearAttachEffect("effect")
	end

	if roleId ~= 0 then
		local entityCO = CharacterConfig.instance:getCfgInfoByID(roleId)
		local modelCO = ModelConfig.instance:getModelConfig(entityCO.modelId)

		self._roleModel:updateRes(GameUrl.getRoguelikeMeshModelUrl(modelCO.rogueResName), GameUrl.getRoguelikeMeshModelUrl("100021_muxue"))

		if not self._isAttackPlane then
			self._roleModel:setCameraPosition(0, 0.6, -2)
		end
	end

	goutil.setActive(self._goHpChange, false)
	goutil.setActive(self._goSanChange, false)
	goutil.setActive(self._goEmpty.gameObject, roleId == 0)
	goutil.setActive(self._btnAdd.gameObject, data.showAddBtn and roleId == 0)
	goutil.setActive(self._goNormal, roleId ~= 0)
	goutil.setActive(self._qua6Ploygon.gameObject, roleId ~= 0)
	goutil.setActive(self._select1Go, false)

	self._txtHpChange.text = ""
	self._txtSanChange.text = ""
	self._clickCallback = data.callback

	if roleId == 0 then
		goutil.setActive(self._go, true)

		if self._qua6SelectPloygon then
			goutil.setActive(self._qua6SelectPloygon.gameObject, false)
		end

		for index = 1, 6 do
			self._qua6Ploygon:InitPolygon(index, 0)

			self._txtQua6List[index].text = "-"
		end

		return
	end

	self:setHeadIcon(roleId, data.useHeadIcon)

	local heroData = HeroDepotModel.instance:getHeroInfoByID(roleId)
	local level = RoguelikeConfig.instance:getConstByName("GuideRoleLv").numValue

	if heroData then
		level = heroData:getLevel()
	end

	self._level = level

	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)

	if data.hp then
		self:setHp(data.hp)
	else
		self:setOriginHp(roleCo)
	end

	self._txtSan.text = data.card or #roleCo.roguelikeCards

	local hpScale = 1.4
	local sanScale = 0.6

	if data.hpChange and data.hpChange ~= 0 then
		self:setHpChange(data.hpChange)

		hpScale = 2
	end

	local qua6List = roleCo.qua6

	if RogueMgr.instance:isInRogue() then
		local roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(roleId)

		if roleMo ~= nil then
			qua6List = {}

			for i = 1, 6 do
				table.insert(qua6List, roleMo.roleProp:getPropertyLevel(i))
			end
		end
	end

	function getRealIndex(idx)
		if idx == 1 then
			return 2
		elseif idx == 2 then
			return 1
		elseif idx == 6 then
			return 3
		elseif idx == 5 then
			return 4
		elseif idx == 3 then
			return 0
		elseif idx == 4 then
			return 5
		end
	end

	for index = 1, #qua6List do
		local value = qua6List[index]

		self._qua6Ploygon:InitPolygon(getRealIndex(index), CharacterCOUtil.qua2Ratio(value))

		self._txtQua6List[index].text = value

		TextUtils.SetColor(self._txtQua6List[index], CharacterCOUtil.qua2Color(value))
		goutil.setActive(self._txtQua6AddList[index].gameObject, false)
		goutil.setActive(self._goQua6SelectList[index], index == data.selectAttr)

		if data.selectAttr then
			self._txtQua6List[index].text = index == data.selectAttr and self._txtQua6List[index].text or ""
		end
	end

	if self._attrChangeList then
		goutil.setActive(self._qua6SelectPloygon.gameObject, true)

		for index = 1, #qua6List do
			local value = qua6List[index]

			printWarn(index, value, self._attrChangeList[index])

			if self._attrChangeList[index] then
				local hadChange = true

				value = value + self._attrChangeList[index]

				if value > 6 then
					value = 6
					hadChange = false

					FloatWordMgr.instance:show(lang("tip_r_attr_max"))
				elseif value < 1 then
					value = 1
					hadChange = false

					FloatWordMgr.instance:show(lang("tip_r_attr_min"))
				end

				if self._attrChangeList[index] > 0 then
					self._txtQua6AddList[index].text = string.format("<size=22>+%d</size>", self._attrChangeList[index])
				else
					self._txtQua6AddList[index].text = string.format("<size=22>%d</size>", self._attrChangeList[index])
				end

				goutil.setActive(self._txtQua6AddList[index].gameObject, hadChange)
			end

			self._qua6SelectPloygon:InitPolygon(getRealIndex(index), CharacterCOUtil.qua2Ratio(value))
		end

		if self._attrChangeList[RoguelikeConst.ROLE_PROP.HP] then
			self:setHpChange(self._attrChangeList[RoguelikeConst.ROLE_PROP.HP])
		end
	elseif self._qua6SelectPloygon then
		goutil.setActive(self._qua6SelectPloygon.gameObject, false)
	end

	goutil.setActive(self._goSixDimensionInfo, not data.isHideSixInfo)
	goutil.setActive(self._btnClick.gameObject, not data.isHideClick)
	goutil.setActive(self._go, true)

	if data.enable ~= nil then
		self:setEnable(data.enable)
	end

	self:bindEvents()
end

function M:delayShowHighLight()
	if RogueMgr.instance:isInRogue() then
		local roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(self._roleId)

		if roleMo ~= nil and roleMo.roleProp:getIsDeath() then
			self:setHighLight(false)

			return
		end
	end

	self:setHighLight(true)
end

function M:setOriginHp(roleCo)
	local hp = RoguelikeConfig.instance:getConstByName("InitialHp").numValue

	self:setHp(hp)
end

function M:setOriginCard(roleCo)
	local card = roleCo.roguelikeCards or {}

	self:setCard(#card)
end

function M:onClick()
	if self._isEnable == false then
		return
	end

	if self._clickCallback then
		self._clickCallback(self._index)
	end
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:setDelayHide(time)
	settimer(time, self._hideObject, self, false)
end

function M:_hideObject()
	self:setActive(false)
end

function M:playAni(ani)
	self._roleModel:playAni(ani)
end

function M:setModelActive(isActive)
	goutil.setActive(self._goModel, isActive)
end

function M:setHighLight(isLight)
	local aniName = isLight and "run_group_lipai_item_liang" or "run_group_lipai_item_an"

	self._animation:Play(aniName)
end

function M:setEnable(isEnable)
	self._isEnable = isEnable

	settimer(0.02, function()
		self:setHighLight(isEnable)
	end, self, false)
end

function M:getEnable()
	return self._isEnable
end

return M
