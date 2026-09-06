-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/BookSpiritSelectPopView.lua

module("logic.extensions.formation.view.BookSpiritSelectPopView", package.seeall)

local BookSpiritSelectPopView = class("BookSpiritSelectPopView", ViewComponent)

function BookSpiritSelectPopView:buildUI()
	BookSpiritSelectPopView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._tableviewLeft = self:getGo("left/tableview")
	self._tableviewRight = self:getGo("right/tableview")
	self._cell = self:getGo("item")
	self._skillIcon = self:getGo("right/info/skillIcon")
	self._txtSkillName = self:getTxt("right/info/txtName")
	self._txtSkillDesc = self:getTxt("right/info/txtDesc")
	self._rightEmpty = self:getGo("right/empty")
	self._leftScrollList = ScrollerList.create(self._tableviewLeft, self._cell, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))
	self._rightScrollList = ScrollerList.create(self._tableviewRight, self._cell, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self._clearRightCell, self))
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
end

function BookSpiritSelectPopView:bindEvents()
	BookSpiritSelectPopView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function BookSpiritSelectPopView:unbindEvents()
	BookSpiritSelectPopView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function BookSpiritSelectPopView:onEnter()
	BookSpiritSelectPopView.super.onEnter(self)

	local params = self:getOpenParam()

	self._petMoList = params[1]
	self._allPetList = params[2]

	if #self._petMoList == 0 or #self._petMoList == 0 then
		self:close()

		return
	end

	self._selectLeftIdx = 1
	self._selectPetId = 0

	self:_updateLeftList()
end

function BookSpiritSelectPopView:onExit()
	BookSpiritSelectPopView.super.onExit(self)
	self:_removeIcons()
end

function BookSpiritSelectPopView:_onClickClose()
	self:close()
end

function BookSpiritSelectPopView:_onClickSure()
	local petMo = self._petMoList[self._selectLeftIdx]

	if petMo then
		if self._selectPetId > 0 then
			if petMo.bookSpiritPetId ~= self._selectPetId then
				PetAgent.instance:sendPM_BookSpiritLinkReq(petMo.petId, self._selectPetId)
			end
		elseif checknumber(petMo.bookSpiritPetId) > 0 then
			PetAgent.instance:sendPM_BookSpiritLinkReq(petMo.petId, -1)
		end
	end

	self:_onClickClose()
end

function BookSpiritSelectPopView:_updateLeftCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btnClick:AddClickListener(function()
		self:_onClickLeftBtn(data, cell.data)
	end)

	local petMo = self._petMoList[self._selectLeftIdx]

	if petMo then
		local proxy = MaterialMgr.setCellByMo(petMo, node)
	end

	goSelect:SetActive(cell.data == self._selectLeftIdx)
end

function BookSpiritSelectPopView:_clearLeftCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function BookSpiritSelectPopView:_updateRightCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passed = goutil.findChild(cell, "passed")

	btnClick:AddClickListener(function()
		self:_onClickRightBtn(data)
	end)

	local proxy = MaterialMgr.setCellByMo(data, node)

	goSelect:SetActive(data.petId == self._selectPetId)
end

function BookSpiritSelectPopView:_clearRightCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function BookSpiritSelectPopView:_updateLeftList()
	self._leftScrollList:reloadData(self._petMoList)
	self:_updateRightList()
end

function BookSpiritSelectPopView:_updateRightList()
	self._txtSkillName.text = "书灵吞噬效果"
	self._txtSkillDesc.text = lang("未激活任何吞噬效果")

	local list = {}

	self._selectPetId = 0

	local petMo = self._petMoList[self._selectLeftIdx]

	MaterialMgr.clearIcon(self._skillIcon)

	if petMo then
		for i, mo in ipairs(self._allPetList) do
			if ContractConfig.instance:getBookSpiritByRaceId(petMo.raceId, mo.raceId) and mo.isMyPackPet == true then
				table.insert(list, mo)
			end
		end

		self._selectPetId = petMo.bookSpiritPetId

		self:_updateSkillShow(petMo.raceId)
	end

	self._rightScrollList:reloadData(list)
	GameUtil.SetActive(self._rightEmpty, #list == 0)
end

function BookSpiritSelectPopView:_updateRightDesc()
	local selectRaceId = 0

	for i, mo in ipairs(self._allPetList) do
		if mo.petId == self._selectPetId then
			selectRaceId = mo.raceId

			break
		end
	end

	local petMo = self._petMoList[self._selectLeftIdx]
	local bookSpiritCfg = ContractConfig.instance:getBookSpiritByRaceId(petMo.raceId, selectRaceId)

	if bookSpiritCfg then
		self._txtSkillDesc.text = bookSpiritCfg.desc

		MaterialMgr.setIcon(self._skillIcon, MatType.Pet, selectRaceId)
	else
		self._txtSkillDesc.text = lang("未激活任何吞噬效果")

		MaterialMgr.clearIcon(self._skillIcon)
	end
end

function BookSpiritSelectPopView:_updateSkillShow(raceId)
	MaterialMgr.clearIcon(self._skillIcon)

	if checknumber(raceId) > 0 then
		local petCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)

		if checknumber(petCfg.bookSpiritSkillId) > 0 then
			MaterialMgr.setCell(MatType.Skill, petCfg.bookSpiritSkillId, self._skillIcon)

			local cfg = BattleConfig.instance:getSkillCo(petCfg.bookSpiritSkillId, raceId)

			if cfg then
				self._txtSkillName.text = cfg.name
				self._txtSkillDesc.text = lang("阿特拉斯成为不朽书灵，令薄伽丘免疫无法行动效果、气势降低效果，并在首次受到致命伤害时复活并获得80%血量。")
			end
		end
	end
end

function BookSpiritSelectPopView:_onClickLeftBtn(petMo, index)
	if index == self._selectLeftIdx then
		return
	end

	self._selectLeftIdx = index

	self._leftScrollList:refresh()
	self:_updateRightList()
end

function BookSpiritSelectPopView:_onClickRightBtn(data)
	self._selectPetId = self._selectPetId == data.petId and 0 or data.petId

	self._rightScrollList:refresh()
end

function BookSpiritSelectPopView:_updateRightSelect(newSelectIndex)
	for i, v in ipairs(self._rightScrollList:getData()) do
		if v.isSelect and v.index ~= newSelectIndex then
			v.isSelect = false

			self._rightScrollList:getView():UpdateCellAtIndex(i - 1)
		end

		if v.index == newSelectIndex then
			v.isSelect = true

			self._rightScrollList:getView():UpdateCellAtIndex(i - 1)
		end
	end
end

function BookSpiritSelectPopView:_removeIcons()
	MaterialMgr.resetAll(self._skillIcon)
end

return BookSpiritSelectPopView
