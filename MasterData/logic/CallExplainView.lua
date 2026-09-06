-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/CallExplainView.lua

module("logic.extensions.lottery.view.CallExplainView", package.seeall)

local CallExplainView = class("CallExplainView", TableViewComponent)

function CallExplainView:ctor()
	CallExplainView.super.ctor(self)

	self.poolCfg = nil
	self.isShowTitle = false
	self.petColumnCount = 6
end

function CallExplainView:bindEvents()
	GameUtil.asBtn(self.viewCloseGo):AddClickListener(function()
		self:close()
	end, self)
end

function CallExplainView:unbindEvents()
	GameUtil.asBtn(self.viewCloseGo):RemoveClickListener()
end

function CallExplainView:onEnterFinished()
	return
end

function CallExplainView:onExitFinished()
	return
end

function CallExplainView:destroyUI()
	return
end

function CallExplainView:onExit()
	self.poolCfg = nil
	self._curViewDatas = nil
end

function CallExplainView:buildUI()
	CallExplainView.super.buildUI(self)

	self.viewCloseGo = self:getGo("Button")
	self.viewDesTxt = goutil.findChildComponent(self.mainGO, "viewBgIma/left/titleDesTxt/Viewport/Content", "Text")
	self.petLockGo = self:getGo("viewBgIma/petLockGo")

	self.petLockGo:SetActive(false)

	local path = self:_getPath()

	if path and path.cellPath2 then
		self._tableCell2 = self:getGo(path.cellPath2)

		self._tableCell2:SetActive(false)
	end
end

function CallExplainView:onEnter()
	local curPoolId = 3

	if self._viewPresentor._openParam and self._viewPresentor._openParam[1] then
		curPoolId = self._viewPresentor._openParam[1]
	end

	self.poolCfg = LotteryConfig.instance:GetPoolCfg(curPoolId)

	if self.poolCfg == nil then
		print("sr_召唤精灵    CallExplainView:onEnter()  获取的池为空 = ", curPoolId)

		return
	end

	self.viewDesTxt.text = self.poolCfg.desc

	self:UpdateViewData()
	self._tableview:ReloadData()
end

function CallExplainView:UpdateViewData()
	self._curViewDatas = {}

	local basePoolCfg = LotteryConfig.instance:GetBasePoolCfg(self.poolCfg.poolId)
	local nowTime = ServerTime.now()
	local upCount = 0
	local extPool = {}
	local usingPool = {}

	if self.poolCfg then
		extPool = LotteryConfig.instance:GetExtPoolCfg(self.poolCfg.poolId)

		if LotteryConfig.instance:GetSelfSelectPetGroupCfg(self.poolCfg.poolId) then
			local rate = 270

			self.poolCfg.upList = {
				rate
			}
			extPool = {
				[rate] = {}
			}

			local info = LotteryModel.instance:getSelfSelectInfo(self.poolCfg.poolId) or {}

			if not info.selfSelectPets then
				local selfSelectPets = {}

				for i, petPb in ipairs(selfSelectPets) do
					local data = LotteryConfig.instance:getBasePoolPetData(self.poolCfg.poolId, petPb.raceId)

					if data then
						table.insert(extPool[rate], data)
					end
				end
			end
		end

		if self.poolCfg.upList and #self.poolCfg.upList > 0 then
			upCount = #self.poolCfg.upList
		end
	end

	for index = upCount, 1, -1 do
		local data = {}

		data.num = 5
		data.rate = self.poolCfg.upList[index]
		data.petList = {}

		for k, v in ipairs(extPool[data.rate] or {}) do
			local needTimer = GameUtil.string2time(v.onlineTime)
			local isShow = true
			local isUnlock = true

			usingPool[v.raceId] = data.rate

			if not string.nilorempty(v.joinValidator) then
				isUnlock = FuncOpenController.instance:getConditionReached(v.joinValidator)

				if not isUnlock and v.isShowPool > 1 then
					isShow = false
				end
			end

			if needTimer <= nowTime and isShow then
				table.insert(data.petList, {
					raceId = v.raceId,
					isUnlock = isUnlock
				})
			end
		end

		if #data.petList > 0 then
			table.insert(self._curViewDatas, data)
		end
	end

	for index = 4, 1, -1 do
		local data = {}

		data.num = index
		data.rate = ((not string.nilorempty(self.poolCfg.weightDesc) or nil) and string.split(self.poolCfg.weightDesc, ","))[index]
		data.petList = {}

		for k, v in ipairs(basePoolCfg[data.num] or {}) do
			local needTimer = GameUtil.string2time(v.onlineTime)
			local isShow = true
			local isUnlock = true

			if checknumber(usingPool[v.raceId]) ~= 0 then
				isShow = false
			end

			if not string.nilorempty(v.joinValidator) then
				isUnlock = FuncOpenController.instance:getConditionReached(v.joinValidator)

				if not isUnlock and v.isShowPool > 1 then
					isShow = false
				end
			end

			if needTimer <= nowTime and isShow then
				table.insert(data.petList, {
					raceId = v.raceId,
					isUnlock = isUnlock
				})
			end
		end

		if #data.petList > 0 then
			table.insert(self._curViewDatas, data)
		end
	end
end

function CallExplainView:_getPath()
	return {
		cellPath = "viewBgIma/callItemSR/Viewport/Content/title",
		viewPath = "viewBgIma/callItemSR",
		cellPath2 = "viewBgIma/callItemSR/Viewport/Content/petRate"
	}
end

function CallExplainView:_cellSize(sv, index)
	if self.isShowTitle then
		-- block empty
	else
		local petListNum = #self._curViewDatas[index + 1].petList
		local row = math.ceil(petListNum / self.petColumnCount)

		return 640, 42 + row * 116.5 + 15
	end
end

function CallExplainView:_updateCell(view, cell, data)
	if self.isShowTitle then
		-- block empty
	else
		self:UpdatePetRateInfo(cell, data)
	end
end

function CallExplainView:UpdatePetRateInfo(cell, data)
	local rareImg = goutil.findChildComponent(cell, "rateTitle/rareImg", "UIImageSpriteChange")
	local upTxtGo = goutil.findChild(cell, "rateTitle/upTxtGo")
	local rateTxt = goutil.findChildTextComponent(cell, "rateTitle/rateTxt")

	if data.num > 4 then
		rareImg:SetState(3)

		rateTxt.text = langPara("text_lottery_desc_11", "ffd74a", data.rate / 10)

		upTxtGo:SetActive(true)
	else
		rareImg:SetState(data.num - 1)

		local color = "ffd74a"

		if data.num == 3 then
			color = "df4dff"
		elseif data.num == 2 then
			color = "1cc2ff"
		elseif data.num == 1 then
			color = "C0CDE7FF"
		end

		rateTxt.text = langPara("text_lottery_desc_12", color, data.rate)

		upTxtGo:SetActive(false)
	end

	local petListRoot = goutil.findChild(cell, "petList")
	local petItem = goutil.findChild(cell, "item")

	petItem:SetActive(false)

	local childCount = petListRoot.transform.childCount
	local petNum = #data.petList

	for i = 1, childCount do
		local go = petListRoot.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
		go:SetActive(false)
	end

	local width = 110
	local scale = 0.85
	local realWidth = width * scale
	local gap = 15
	local gapY = 23
	local col = childCount + 1
	local row = 1

	while col > self.petColumnCount do
		col = col - self.petColumnCount
		row = row + 1
	end

	while childCount < petNum do
		local go = goutil.clone(petItem, "pet" .. childCount + 1)

		go.transform:SetParent(petListRoot.transform)
		Framework.TransformUtil.SetLocalPos(go.transform, (col - 1) * (realWidth + gap), -(row - 1) * (realWidth + gapY), 0)
		Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)

		childCount = childCount + 1
		col = col + 1

		if col > self.petColumnCount then
			col = 1
			row = row + 1
		end
	end

	for i = 1, petNum do
		local petData = data.petList[i]
		local item = MatType.Pet .. ":" .. petData.raceId .. ":" .. 0
		local go = petListRoot.transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		MaterialMgr.resetAll(go)

		local proxy = MaterialMgr.setCellByCfg(item, go)

		proxy.binder:setShowName(true)

		local lockGo = goutil.findChild(go, "petLockGo")

		if petData.isUnlock then
			if lockGo and lockGo.activeSelf then
				lockGo:SetActive(false)
			end
		else
			if lockGo == nil then
				lockGo = UnityEngine.GameObject.Instantiate(self.petLockGo, go.transform)
				lockGo.name = "petLockGo"
			end

			lockGo:SetActive(true)
			lockGo.transform:SetAsLastSibling()
			GameUtil.asBtn(lockGo):AddClickListener(function()
				local petCfg = CharacterConfig.instance:getPetCo(petData.raceId)

				if petCfg == nil or string.nilorempty(petCfg.source) then
					error("sr_召唤精灵  CallExplainView:UpdatePetRateInfo() 精灵获取途径未配置  raceId = " .. petData.raceId)

					return
				end

				local list = string.split(petCfg.source, ",")

				if list == nil or #list == 0 then
					error("sr_召唤精灵  CallExplainView:UpdatePetRateInfo() 精灵获取途径配置错误  raceId = " .. petData.raceId)

					return
				end

				local temp = {}

				for i = 1, #list do
					if list[i] and list[i] ~= "100" then
						table.insert(temp, list[i])
					end
				end

				if temp == nil or #temp == 0 then
					error("sr_召唤精灵  CallExplainView:UpdatePetRateInfo() 精灵获取途径只配置了100？  raceId = " .. petData.raceId)

					return
				end

				UIStateManager.instance:push(ViewName.ItemSource, table.concat(temp, ","), true, function()
					self:close()
				end)
			end, self)
		end
	end
end

function CallExplainView:_cellAtIndex(view, idx)
	local cell

	if self.isShowTitle then
		-- block empty
	else
		cell = view:DequeueCellByTag(1)
		cell = cell or view:AddChild(self._tableCell2, 1)
	end

	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

return CallExplainView
