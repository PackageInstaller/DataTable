local DormVisitItem = class("DormVisitItem", ReduxView)

function DormVisitItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormVisitItem:Init()
	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListener()

	self.praiseController = self.controller_:GetController("praise")
	self.cardBgCon_ = self.controller_:GetController("bgType")
end

function DormVisitItem:InitUI()
	self:BindCfgUI()
end

function DormVisitItem:AddUIListener()
	self:AddBtnListener(self.visitBtn_, nil, function()
		if self.visitFunc then
			self.visitFunc(self.userID)
		end
	end)
	self.commonPortrait_:RegisteClickCallback(function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
			ForeignInfoAction:TryToCheckForeignDetailInfo(self.userID)
		else
			ForeignInfoAction:TryToCheckForeignDetailInfo(self.userID, true)
		end
	end)
end

function DormVisitItem:RegisterEnterCallBack(arg_7_1)
	if arg_7_1 then
		self.visitFunc = arg_7_1
	end
end

function DormVisitItem:RefreshUI(arg_8_1, arg_8_2)
	self.userID = arg_8_1
	self.type = arg_8_2

	local var_8_0 = DormVisitTools:GetTemplateExhibitList(self.type)[self.userID]

	if not var_8_0 then
		Debug.LogError("未获取到参观信息")

		return
	end

	local var_8_1 = ProfileDecorateItemCfg[var_8_0.info_background]

	if ProfileDecorateItemCfg[var_8_0.info_background] then
		self.cardBgCon_:SetSelectedState("image")
		self.cardBgCon_:SetSelectedState("image")

		if var_8_1.type == 1 then
			self.bg_.spriteSync = pureGetSpriteWithoutAtlas("TextureConfig/Friends/" .. var_8_1.resource .. "_s")
		elseif var_8_1.type == 2 then
			self.cardBgCon_:SetSelectedState("prefab")

			local var_8_2 = Asset.Load("Widget/System/PlayerProfileBg/profileBg_s/PPBCode_s_" .. var_8_1.resource)

			if var_8_2 then
				local var_8_3 = Object.Instantiate(var_8_2, self.cardBgPrefabRoot_)

				if var_8_3 then
					var_8_3.transform:SetParent(self.cardBgPrefabRoot_)

					var_8_3.transform.localScale = Vector3.New(1, 1, 1)
					var_8_3.transform.localPosition = Vector3.New(0, 0, 0)

					var_8_3:SetActive(true)
				end
			end
		elseif cfg.type == 3 then
			-- block empty
		end
	end

	self.commonPortrait_:RenderHead(var_8_0.icon)
	self.commonPortrait_:RenderFrame(var_8_0.iconFrame)

	self.nickName.text = var_8_0.nick
	self.likeNum.text = var_8_0.likeNum
	self.dormName.text = BackHomeCfg[var_8_0.architecture_id].type == DormConst.BACKHOME_TYPE.PublicDorm and GetTips("DORM_LOBBY_NAME") or GetTipsF("DORM_HERO_ROOM_NAME", GetI18NText(HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[BackHomeHeroSkinCfg[var_8_0.heroIDList[1]].hero_id][1]].name))
	self.chatText_.text = ""
	self.viewNum.text = math.max(var_8_0.furniture_num, 0)
	self.furnitureNum.text = var_8_0.sign

	if var_8_0.todayLikeNum then
		self.praiseController:SetSelectedState("on")
	else
		self.praiseController:SetSelectedState("off")
	end
end

function DormVisitItem:Dispose()
	self.commonPortrait_:Dispose()
	DormVisitItem.super.Dispose(self)
end

return DormVisitItem
