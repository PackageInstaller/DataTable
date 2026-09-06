-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualbox/view/AnnualBoxView.lua

module("logic.extensions.annualbox.view.AnnualBoxView", package.seeall)

local AnnualBoxView = class("AnnualBoxView", ViewComponent)

function AnnualBoxView:ctor()
	AnnualBoxView.super.ctor(self)

	self._upCurDatas = nil
	self._downCurDatas = nil
	self._annualBoxInfo = nil
	self._upEffsList = nil
	self._upItemList = nil
	self._downItemList = nil
end

function AnnualBoxView:bindEvents()
	AnnualBoxView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "annualbox")
	end, self)
	self._copyBtn:AddClickListener(function()
		NativeBridge.instance:invoke("com.baitian.wrap.ClipboardWrap", "copyclip", {
			content = self._annualBoxInfo.userCode
		})
	end, self)
	self._shareBtn:AddClickListener(self._onClickShare, self)
	self._btnCanGet:AddClickListener(self._onClickCanGet, self)
end

function AnnualBoxView:unbindEvents()
	AnnualBoxView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._copyBtn:RemoveClickListener()
	self._shareBtn:RemoveClickListener()

	for _, item in pairs(self._upItemList or {}) do
		if item and item.clickGo then
			GameUtil.asBtn(item.clickGo):RemoveClickListener()
		end
	end

	for _, item in pairs(self._downItemList or {}) do
		if item and item.clickGo then
			GameUtil.asBtn(item.clickGo):RemoveClickListener()
		end
	end

	self._btnCanGet:RemoveClickListener()
end

function AnnualBoxView:onExit()
	AnnualBoxView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataAnnualBoxInfo, self._updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.AssembleOrderGainRegressionPrizeRes, self._updateReturnRewards, self)

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._annualBoxInfo = nil

	for _, item in pairs(self._upItemList or {}) do
		if item and item.goodsGo then
			MaterialMgr.resetAll(item.goodsGo)
		end
	end

	for _, item in pairs(self._downItemList or {}) do
		if item and item.goodsGo then
			MaterialMgr.resetAll(item.goodsGo)
		end
	end

	for _, eff in pairs(self._upEffsList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._upEffsList = nil

	self:_clearReturnRewards()
end

function AnnualBoxView:destroyUI()
	AnnualBoxView.super.destroyUI(self)

	for _, item in pairs(self._upItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._upItemList = nil

	for _, item in pairs(self._downItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._downItemList = nil
end

function AnnualBoxView:buildUI()
	AnnualBoxView.super.buildUI(self)

	self._sprintGo = self:getGo("sprineGo")
	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._idInputTxt = goutil.findChildTextComponent(self.mainGO, "idInputGo/idInputTxt")
	self._copyBtn = self:getBtn("copyBtn")
	self._shareBtn = self:getBtn("shareBtn")

	local rightInfoGo = self:getGo("rightInfoGo")

	self._upDescTxt = goutil.findChildTextComponent(rightInfoGo, "upDescGo/upDescTxt")
	self._upItemSRTran = goutil.findChild(rightInfoGo, "upItemSR"):GetComponent(goutil.Type_RectTransform)
	self._upContent = goutil.findChild(rightInfoGo, "upItemSR/ViewPort/Content")
	self._upProBar = goutil.findChild(rightInfoGo, "upItemSR/ViewPort/Content/upProBar"):GetComponent("Slider")
	self._upCellTran = goutil.findChild(rightInfoGo, "upItemSR/ViewPort/Content/upCellTran").transform
	self._upCountTxt = goutil.findChildTextComponent(rightInfoGo, "upCountTxt")
	self._downDescTxt = goutil.findChildTextComponent(rightInfoGo, "downDescGo/downDescTxt")
	self._downContent = goutil.findChild(rightInfoGo, "downItemSR/ViewPort/Content")
	self._downProBar = goutil.findChild(rightInfoGo, "downItemSR/ViewPort/Content/downProBar"):GetComponent("Slider")
	self._downCellTran = goutil.findChild(rightInfoGo, "downItemSR/ViewPort/Content/downCellTran").transform
	self._downCountTxt = goutil.findChildTextComponent(rightInfoGo, "downCountTxt")
	self._itemCell = goutil.findChild(rightInfoGo, "itemCell")

	GameUtil.SetActive(self._itemCell, false)

	self._timeTxt = goutil.findChildTextComponent(rightInfoGo, "time/txt")
	self._upProBar.value = 0
	self._downProBar.value = 0
	self._upCountTxt.text = ""
	self._downCountTxt.text = ""
	self._timeTxt.text = ""
	self._rewardCells = {}

	for i = 1, 3 do
		self._rewardCells[i] = self:getGo("reward/item" .. i)
	end

	self._btnCanGet = self:getBtn("reward/btnCanGet")
	self._maskGeted = self:getGo("reward/maskGeted")
	self._rectTrans = self:getGo("reward"):GetComponent(goutil.Type_RectTransform)

	goutil.setActive(self._btnCanGet.gameObject, false)
	goutil.setActive(self._maskGeted, false)
end

function AnnualBoxView:registCallbacks()
	self._upItemSR:RegisterCallback(function()
		return 1
	end, self._cellSizeUp, self._cellAtIndexUp, self)
	self._upItemSR:RegisterUpdateCellCallback(self._onCellUpdateUp)
	self._downItemSR:RegisterCallback(function()
		return 1
	end, self._cellSizeDown, self._cellAtIndexDown, self)
	self._downItemSR:RegisterUpdateCellCallback(self._onCellUpdateDown)
end

function AnnualBoxView:_cellSizeUp()
	if self._upCurDatas == nil or #self._upCurDatas == 0 then
		return 0, 216
	end

	return 136 + (#self._upCurDatas - 1) * 206, 216
end

function AnnualBoxView:_cellAtIndexUp(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._upCellTran.gameObject)
	cell.data = index + 1
	cell.index = index

	self:_updateUpCell(cell)

	return cell
end

function AnnualBoxView:_onCellUpdateUp(view, cell)
	cell.data = cell.index + 1

	self:_updateUpCell(cell)
end

function AnnualBoxView:_cellSizeDown()
	if self._downCurDatas == nil or #self._downCurDatas == 0 then
		return 0, 216
	end

	return 136 + (#self._downCurDatas - 1) * 206, 216
end

function AnnualBoxView:_cellAtIndexDown(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._downCellTran.gameObject)
	cell.data = index + 1
	cell.index = index

	self:_updateDownCell(cell)

	return cell
end

function AnnualBoxView:_onCellUpdateDown(view, cell)
	cell.data = cell.index + 1

	self:_updateDownCell(cell)
end

function AnnualBoxView:onEnter()
	AnnualBoxView.super.onEnter(self)

	self._idInputTxt.text = "角色专属ID："
	self._upDescTxt.text = "邀请好友拿精美皮肤"
	self._downDescTxt.text = "帮好友拆礼盒抽钻石，最多可得8888钻"

	local actId = AnnualBoxConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataAnnualBoxInfo, self._updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.AssembleOrderGainRegressionPrizeRes, self._updateReturnRewards, self)

	self._actCfg = AnnualBoxConfig.instance:getAnnualActivityCfg(actId)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self._actCfg.petId, self._sprintGo, 1, function(go)
		Framework.TransformUtil.SetLocalRotation(go.transform, 0, 0, 0)
	end, true, 0, 0)
	self._timeTxt.text = self._actCfg.timeStr
	self._upCurDatas = AnnualBoxConfig.instance:getAnnualInvitePrizeCfgs(actId)
	self._downCurDatas = AnnualBoxConfig.instance:getAnnualHelpPrizeCfgs(actId)
	self._curRewardCount = 0

	self:_initReturnRewards()
	self:_updateView()
	AnnualBoxController.instance:csRequestAssembleOrderInfoReq()
end

function AnnualBoxView:_updateView(index, isHelp)
	self:_updateReturnRewards()
	self:_updataViewRightShow(index, isHelp)
end

function AnnualBoxView:_initReturnRewards()
	self:_clearEffect()
	goutil.setActive(self._btnCanGet.gameObject, false)
	goutil.setActive(self._maskGeted, false)

	local str = self._actCfg.helpRegressionPrize

	self._curRewardCount = 0

	if not string.nilorempty(str) then
		local rewardList = MaterialMgr.changeItemStrArr(str)
		local count = 0

		for i = 1, 3 do
			if rewardList[i] then
				count = count + 1

				MaterialMgr.setCellByCfg(rewardList[i], self._rewardCells[i])
			end
		end

		self._curRewardCount = count
	end
end

function AnnualBoxView:_updateReturnRewards()
	local isInvited = AnnualBoxController.instance:isInviteFriend()
	local isGeted = AnnualBoxController.instance:isGetedReturnReward()

	goutil.setActive(self._btnCanGet.gameObject, isInvited and not isGeted)
	goutil.setActive(self._maskGeted, isGeted)

	if isInvited and not isGeted then
		self:_loadEffect()
	else
		self:_clearEffect()
	end
end

function AnnualBoxView:_clearReturnRewards()
	for i = 1, 3 do
		MaterialMgr.resetAll(self._rewardCells[i])
	end

	self:_clearEffect()
end

function AnnualBoxView:_loadEffect()
	self:_clearEffect()

	self._uiEffects = {}

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	for i = 1, self._curRewardCount do
		local uiEffect = UIEffectManager.instance:playEffect(self, effPath, self._rewardCells[i].transform, 0, 0, true, false, nil, function(target, eff)
			if not goutil.isNil(self._rectTrans) then
				eff:setClipping(self._rectTrans)
			end
		end)

		uiEffect:setParent(self._rewardCells[i].transform)
		uiEffect:setLocalPos(0, 0, 0)
		uiEffect:setScale(1)
		table.insert(self._uiEffects, uiEffect)
	end
end

function AnnualBoxView:_clearEffect()
	if self._uiEffects then
		for i, v in ipairs(self._uiEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._uiEffects = nil
	end
end

function AnnualBoxView:_updataViewRightShow(index, isHelp)
	self._annualBoxInfo = AnnualBoxController.instance:getAnnualBoxInfo()
	self._idInputTxt.text = "角色专属ID：" .. self._annualBoxInfo.userCode
	self._upCountTxt.text = string.format("邀请次数：%s/%s", self._annualBoxInfo.invitePro, self._actCfg.inviteLimit)
	self._downCountTxt.text = string.format("帮助次数：%s/%s", self._annualBoxInfo.helpPro, self._actCfg.helpLimit)

	if checknumber(index) <= 0 then
		self:_updateUpCell()
		self:_updateDownCell()

		return
	end

	if isHelp then
		self:_updateDownCell()
	else
		self:_updateUpCell()
	end
end

function AnnualBoxView:_updateUpCell()
	self._upItemList = self._upItemList or {}
	self._upEffsList = self._upEffsList or {}

	if self._upCurDatas then
		if not #self._upCurDatas then
			local count = 0

			if self._annualBoxInfo then
				if not self._annualBoxInfo.invitePrizes then
					local info = {}

					if self._annualBoxInfo then
						if not self._annualBoxInfo.invitePro then
							local haveCount = 0
							local pro = 0
							local width = count < 4 and 756 or 136 + (count - 1) * 206

							GameUtil.setWidth(self._upContent, width)
							GameUtil.setWidth(self._upProBar.gameObject, width)

							if count > 0 then
								local once = 1 / count
								local isFirst = true

								for i = 1, count do
									if self._upItemList[i] == nil or self._upItemList[i].itemGo == nil then
										local go = UnityEngine.GameObject.Instantiate(self._itemCell, self._upCellTran)

										GameUtil.SetActive(go, true)

										self._upItemList[i] = {}
										self._upItemList[i].itemGo = go
										self._upItemList[i].goodsGo = goutil.findChild(go, "goodsGo")
										self._upItemList[i].receivedGo = goutil.findChild(go, "receivedGo")
										self._upItemList[i].countTxt = goutil.findChildTextComponent(go, "countTxt")
										self._upItemList[i].clickGo = goutil.findChild(go, "clickGo")
									else
										GameUtil.SetActive(self._upItemList[i].itemGo, true)
										MaterialMgr.resetAll(self._upItemList[i].goodsGo)
										GameUtil.asBtn(self._upItemList[i].clickGo):RemoveClickListener()
									end

									local cfg = self._upCurDatas[i]
									local proxy = MaterialMgr.setCellByCfg(cfg.prize, self._upItemList[i].goodsGo)

									proxy.binder:setBgActive(false)

									self._upItemList[i].countTxt.text = tostring(cfg.progress)

									local value = table.indexof(info, cfg.prizeId)

									if value then
										GameUtil.SetActive(self._upItemList[i].clickGo, false)
										GameUtil.SetActive(self._upItemList[i].receivedGo, true)

										pro = pro + once

										if self._upEffsList[i] then
											UIEffectManager.instance:stopEffect(self._upEffsList[i])

											self._upEffsList[i] = nil
										end
									else
										GameUtil.SetActive(self._upItemList[i].receivedGo, false)

										if haveCount >= cfg.progress then
											pro = pro + once

											GameUtil.SetActive(self._upItemList[i].clickGo, true)
											GameUtil.asBtn(self._upItemList[i].clickGo):AddClickListener(function()
												AnnualBoxController.instance:csRequestAssembleOrderGainInvitePrizeReq(cfg.prizeId)
											end, self)

											if self._upEffsList[i] == nil then
												self._upEffsList[i] = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", self._upItemList[i].itemGo, 0, 0, true, false, nil, function(target, eff)
													eff.effGo.transform:SetParent(self._upItemList[i].itemGo.transform)
													GameUtil.setLocalPos(eff.effGo.transform, -12, -3, 0)
													GameUtil.setLocalScale(eff.effGo.transform, 0.68, 0.68, 0.68)
													eff:setClipping(self._upItemSRTran)
												end)
											end
										else
											if isFirst then
												isFirst = false

												local syc = 0

												if self._upCurDatas[i - 1] and self._upCurDatas[i - 1].progress > 0 then
													syc = self._upCurDatas[i - 1].progress
												end

												pro = pro + (haveCount - syc) * once / (self._upCurDatas[i].progress - syc)
											end

											GameUtil.SetActive(self._upItemList[i].clickGo, false)

											if self._upEffsList[i] then
												UIEffectManager.instance:stopEffect(self._upEffsList[i])

												self._upEffsList[i] = nil
											end
										end
									end
								end
							end

							for i = count + 1, #self._upItemList do
								if self._upItemList[i] and self._upItemList[i].itemGo then
									MaterialMgr.resetAll(self._upItemList[i].goodsGo)
									GameUtil.asBtn(self._upItemList[i].clickGo):RemoveClickListener()
									GameUtil.SetActive(self._upItemList[i].itemGo, false)
								end
							end

							self._upProBar.value = pro
						end
					end
				end
			end
		end
	end
end

function AnnualBoxView:_updateDownCell()
	self._downItemList = self._downItemList or {}

	if self._downCurDatas then
		if not #self._downCurDatas then
			local count = 0

			if self._annualBoxInfo then
				if not self._annualBoxInfo.helpPro then
					local haveCount = 0
					local width = count < 4 and 756 or 136 + (count - 1) * 206

					GameUtil.setWidth(self._downContent, width)
					GameUtil.setWidth(self._downProBar.gameObject, width)

					local pro = 0

					if count > 0 then
						local once = 1 / count
						local isFirst = true

						for i = 1, count do
							if self._downItemList[i] == nil or self._downItemList[i].itemGo == nil then
								local go = UnityEngine.GameObject.Instantiate(self._itemCell, self._downCellTran)

								GameUtil.SetActive(go, true)

								self._downItemList[i] = {}
								self._downItemList[i].itemGo = go
								self._downItemList[i].goodsGo = goutil.findChild(go, "goodsGo")
								self._downItemList[i].receivedGo = goutil.findChild(go, "receivedGo")
								self._downItemList[i].countTxt = goutil.findChildTextComponent(go, "countTxt")
								self._downItemList[i].clickGo = goutil.findChild(go, "clickGo")
							else
								GameUtil.SetActive(self._downItemList[i].itemGo, true)
								MaterialMgr.resetAll(self._downItemList[i].goodsGo)
								GameUtil.asBtn(self._downItemList[i].clickGo):RemoveClickListener()
							end

							GameUtil.SetActive(self._downItemList[i].clickGo, false)

							local cfg = self._downCurDatas[i]
							local proxy = MaterialMgr.setCellByCfg(cfg.prize, self._downItemList[i].goodsGo)

							if proxy then
								proxy.binder:setBgActive(false)
							end

							self._downItemList[i].countTxt.text = tostring(cfg.progress)

							if haveCount >= cfg.progress then
								GameUtil.SetActive(self._downItemList[i].receivedGo, true)

								pro = pro + once
							else
								GameUtil.SetActive(self._downItemList[i].receivedGo, false)

								if isFirst then
									isFirst = false

									local syc = 0

									if self._downCurDatas[i - 1] and self._downCurDatas[i - 1].progress > 0 then
										syc = self._downCurDatas[i - 1].progress
									end

									pro = pro + (haveCount - syc) * once / (self._downCurDatas[i].progress - syc)
								end
							end
						end
					end

					for i = count + 1, #self._downItemList do
						if self._downItemList[i] and self._downItemList[i].itemGo then
							MaterialMgr.resetAll(self._downItemList[i].goodsGo)
							GameUtil.asBtn(self._downItemList[i].clickGo):RemoveClickListener()
							GameUtil.SetActive(self._downItemList[i].itemGo, false)
						end
					end

					self._downProBar.value = pro
				end
			end
		end
	end
end

function AnnualBoxView:_onClickCanGet()
	AssembleOrderAgent.instance:sendPM_AssembleOrderGainRegressionPrizeReq()
end

function AnnualBoxView:_onClickShare()
	SurveyController.instance:reportBehavior(200929)

	if not string.nilorempty(self._actCfg.shareUrl) then
		AnnualBoxController.instance:openAnnualBoxShare(self._actCfg.shareUrl)
	end
end

return AnnualBoxView
