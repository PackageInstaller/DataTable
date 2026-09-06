-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroEnemyCell.lua

module("logic.extensions.aoqihero.view.AoQiHeroEnemyCell", package.seeall)

local AoQiHeroEnemyCell = class("AoQiHeroEnemyCell")
local HPGO_ANCHORED_X = -5
local HPGO_ANCHORED_Y = -30
local BUFFGO_ANCHORED_X = 5
local BUFFGO_ANCHORED_Y = -43
local KUANG_WIDTH = 95
local KUANG_HEIGHT = 95
local TXT_HP_SIZE = 12
local TXT_RANGE_SIZE = 12

function AoQiHeroEnemyCell:ctor(componetContainer)
	self._container = componetContainer.gameObject
	self._txtName = goutil.findChildTextComponent(self._container, "txt")
	self._petInfoGo = goutil.findChild(self._container, "petInfo")
	self._hpGo = goutil.findChild(self._container, "hp")
	self._petCon = goutil.findChild(self._container, "petInfo/petCon")
	self._txtHpGO = goutil.findChild(self._container, "hp/slider/txt")
	self._txtHp = goutil.findChildTextComponent(self._container, "hp/slider/txt")
	self._sliderHp = Framework.SliderAdapter.GetFrom(self._container, "hp/slider")
	self._sliderEnergy = Framework.SliderAdapter.GetFrom(self._container, "petInfo/energy")
	self._selectGo = goutil.findChild(self._container, "select")
	self._selectKuangGo = goutil.findChild(self._container, "select/kuang")
	self._buffTableView = goutil.findChild(self._container, "buffTableView")
	self._buffTableCell = goutil.findChild(self._container, "buffTableView/buffTableCell")
	self._buffTableList = ScrollerList.create(self._buffTableView, self._buffTableCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._petTypeGo = goutil.findChild(self._container, "hp/petType")
	self._typeChange = goutil.findChildComponent(self._petTypeGo, "type", "UIImageSpriteChange")
	self._petInfo = goutil.findChild(self._container, "petInfo")
	self._itemCon = goutil.findChild(self._container, "itemCon")
	self._itemImageChange = goutil.findChildComponent(self._container, "itemCon", ComponentType.UIImageSpriteChange)
	self._range = goutil.findChild(self._container, "hp/range")
	self._txtRangeGo = goutil.findChild(self._container, "hp/range/txt")
	self._txtRange = goutil.findChildTextComponent(self._container, "hp/range/txt")

	self:_onBuildEvent()

	self._curHp = 0
	self._sizeX = 1
	self._sizeY = 1
end

function AoQiHeroEnemyCell:_onBuildEvent()
	GameUtil.addClickHandler(self._container, self._onClickEnemy, self)
end

function AoQiHeroEnemyCell:initCell(enemyMo, view)
	local sizeX, sizeY = enemyMo.sizeX, enemyMo.sizeY

	GameUtil.setLocalScale(self._container, sizeY, sizeX, 1)

	local maxScaleSize = math.min(sizeX, sizeY)
	local scaleY, scaleX = maxScaleSize / sizeX, maxScaleSize / sizeY

	GameUtil.setLocalScale(self._petInfoGo, scaleX, scaleY, 1)
	GameUtil.setLocalScale(self._hpGo, scaleX, scaleY, 1)
	GameUtil.setLocalScale(self._itemCon, scaleX, scaleY, 1)
	GameUtil.setLocalScale(self._buffTableView, scaleX, scaleY, 1)
	GameUtil.setLocalScale(self._txtHpGO, 1 / maxScaleSize, 1 / maxScaleSize, 1)
	GameUtil.setLocalScale(self._txtRangeGo, 1 / maxScaleSize, 1 / maxScaleSize, 1)
	GameUtil.setLocalScale(self._selectKuangGo, 1 / sizeY, 1 / sizeX, 1)
	GameUtil.setAnchoredPos(self._hpGo, HPGO_ANCHORED_X * scaleX, HPGO_ANCHORED_Y * scaleY)
	GameUtil.setAnchoredPos(self._buffTableView, BUFFGO_ANCHORED_X * scaleX, BUFFGO_ANCHORED_Y * scaleY)
	GameUtil.setWidth(self._selectKuangGo, KUANG_WIDTH * sizeY)
	GameUtil.setHeight(self._selectKuangGo, KUANG_HEIGHT * sizeX)

	self._txtHp.fontSize = TXT_HP_SIZE * maxScaleSize
	self._txtRange.fontSize = TXT_RANGE_SIZE * maxScaleSize
	self._sizeX = sizeX
	self._sizeY = sizeY
	self._txtName.text = enemyMo.id

	self:updateCell(enemyMo)

	self._enemyId = enemyMo.id
	self._view = view

	local petCfg = AoQiHeroConfig.instance:getPetCfg(enemyMo.activityId, enemyMo.configId)

	if checknumber(petCfg.faceIds) ~= 0 then
		MaterialMgr.setIcon(self._petCon, MatType.Pet, checknumber(petCfg.faceIds))
	end

	if petCfg.elementId > 0 then
		GameUtil.SetActive(self._petTypeGo, true)
		self._typeChange:SetState(petCfg.elementId - 1)
	else
		GameUtil.SetActive(self._petTypeGo, false)
	end

	if string.nilorempty(petCfg.res) then
		GameUtil.SetActive(self._petInfo, true)
		GameUtil.SetActive(self._itemCon, false)
	else
		self._itemImageChange:ChangeSprite(petCfg.res)
		GameUtil.SetActive(self._petInfo, false)
		GameUtil.SetActive(self._itemCon, true)
	end

	local skillCfg = AoQiHeroConfig.instance:getSkillCfg(enemyMo.normalSkillId)

	GameUtil.SetActive(self._range, checknumber(skillCfg.attackParam) > 0)

	self._txtRange.text = langPara("距离：%d", checknumber(skillCfg.attackParam))
end

function AoQiHeroEnemyCell:getSize()
	return self._sizeX, self._sizeY
end

function AoQiHeroEnemyCell:setEnemyCellSelect(state)
	GameUtil.SetActive(self._selectGo, state)
end

function AoQiHeroEnemyCell:updateCell(enemyMo)
	local curHp, maxHp = checkint(enemyMo.curHp), checkint(enemyMo:getMaxHp())
	local hpRate = curHp / maxHp

	self._sliderHp:SetValue(hpRate)

	self._txtHp.text = string.format("%d", checkint(curHp))

	local curEnergy, maxEnergy = enemyMo:getEnergy(), enemyMo:getMaxEnergy()

	self._sliderEnergy:SetValue(curEnergy / maxEnergy)

	self._curHp = curHp
	self._maxHp = maxHp

	local list = {}
	local buffMap = {}

	for i, v in ipairs(enemyMo.buffList) do
		local buffMo = AoQiHeroBuffMgr.instance:getBuff(v)

		if not buffMap[buffMo.configId] then
			buffMap[buffMo.configId] = true

			if not string.nilorempty(buffMo.buffCfg.buffIcon) then
				table.insert(list, buffMo.configId)
			end
		end
	end

	self._buffTableList:reloadData(list)
end

function AoQiHeroEnemyCell:changeNumber(num)
	self._curHp = self._curHp + num
	self._curHp = math.max(self._curHp, 0)

	self._sliderHp:SetValue(self._curHp / self._maxHp)

	self._txtHp.text = string.format("%d", self._curHp)
end

function AoQiHeroEnemyCell:getGo()
	return self._container
end

function AoQiHeroEnemyCell:_updateBuffCell(view, cell, data, tag)
	local go = cell.gameObject
	local buffCfg = AoQiHeroConfig.instance:getSkillAffixCfg(data)

	uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, buffCfg.buffIcon)
end

function AoQiHeroEnemyCell:_clearBuffCell(cell)
	local go = cell.gameObject

	uGuiUtil.clearImage(go)
end

function AoQiHeroEnemyCell:_onClickEnemy()
	local enemyMo = AoQiHeroEntityMgr.instance:getPet(self._enemyId)

	if enemyMo and self._view then
		local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._container)
		local param = {}

		param.pos = pos
		param.sizeDelta = sizeDelta
		param.view = self._view
		param.activityId = enemyMo.activityId
		param.raceId = enemyMo.configId
		param.isAttack = false
		param.lv = enemyMo.level

		ViewMgr.instance:open(ViewName.AoqiHeroPetTipsView, param)
	end
end

function AoQiHeroEnemyCell:_onDestory()
	self._view = nil
	self._enemyId = nil
end

return AoQiHeroEnemyCell
