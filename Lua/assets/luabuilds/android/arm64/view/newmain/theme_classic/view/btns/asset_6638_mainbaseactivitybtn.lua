local MainBaseActivityBtn = class("MainBaseActivityBtn")

MainBaseActivityBtn.UPDATED_TIP = "MainBaseActivityBtn::UPDATED_TIP"

function MainBaseActivityBtn:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.tpl = arg_1_1

	pg.DelegateInfo.New(self)

	self.event = arg_1_2
	self.hideSubImg = arg_1_4

	if arg_1_3 then
		self._tf = self.tpl
	end

	return
end

function MainBaseActivityBtn:GetLinkConfig()
	local var_2_0 = pg.activity_link_button
	local var_2_1 = _.select(pg.activity_link_button.get_id_list_by_name[self:GetEventName()] or {}, function(arg_3_0)
		if type(var_2_0[arg_3_0].time) == "table" and var_2_0[arg_3_0].time[1] and var_2_0[arg_3_0].time[1] == "default" then
			return self:InActTime(var_2_0[arg_3_0].time[2])
		else
			return pg.TimeMgr.GetInstance():inTime(var_2_0[arg_3_0].time)
		end

		return
	end)

	if #var_2_1 > 0 then
		table.sort(var_2_1, CompareFuncs({
			function(arg_4_0)
				return var_2_0[arg_4_0].order
			end
		}))

		return pg.activity_link_button[var_2_1[1]]
	end

	return
end

function MainBaseActivityBtn:InActTime(arg_5_1)
	local var_5_0 = arg_5_1 or self:GetActivityID()

	if var_5_0 then
		local var_5_1 = getProxy(ActivityProxy):getActivityById(var_5_0)

		return var_5_1 and not var_5_1:isEnd()
	end

	return false
end

function MainBaseActivityBtn:InShowTime()
	local var_6_0 = self:GetLinkConfig()

	if var_6_0 ~= nil then
		self.config = var_6_0

		return true
	else
		return false
	end

	return
end

function MainBaseActivityBtn:NewGameObject()
	return self._tf or Object.Instantiate(self.tpl, self.tpl.parent).transform
end

function MainBaseActivityBtn:Init(arg_8_1)
	self._tf = self:NewGameObject()
	self._tf.gameObject.name = self.__cname
	self.image = self._tf:Find("Image"):GetComponent(typeof(Image))
	self.subImage = self._tf:Find("sub_Image"):GetComponent(typeof(Image))
	self.tipTr = self._tf:Find("Tip"):GetComponent(typeof(Image))
	self.tipTxt = self._tf:Find("Tip/Text"):GetComponent(typeof(Text))

	setActive(self._tf, true)

	self.tipTxt.text = ""

	self:InitTipImage()
	self:UpdatePosition(arg_8_1)
	self:InitSubImage()
	self:InitImage(function()
		self:OnInit()
		self:Register()

		return
	end)

	return
end

function MainBaseActivityBtn:Register()
	onButton(self, self._tf, function()
		if self.config.type <= 0 then
			self:CustomOnClick()
		else
			self:OnClick()
		end

		return
	end, SFX_MAIN)

	return
end

function MainBaseActivityBtn:OnClick()
	MainBaseActivityBtn.Skip(self, self.config)

	return
end

function MainBaseActivityBtn:InitImage(arg_13_1)
	if not self.config.pic or self.config.pic == self.imgName then
		arg_13_1()

		return
	end

	self.imgName = self.config.pic

	LoadSpriteAtlasAsync(self:ResPath() .. "/" .. self.config.pic, "", function(arg_14_0)
		if IsNil(self.image) then
			return
		end

		self.image.sprite = arg_14_0

		self.image:SetNativeSize()
		arg_13_1()

		return
	end)

	return
end

function MainBaseActivityBtn:InitSubImage()
	if self.hideSubImg then
		setActive(self.subImage.gameObject, false)

		return
	end

	local var_15_0 = self.config.text_pic

	setActive(self.subImage.gameObject, self.config.text_pic ~= nil and var_15_0 ~= "")

	if not var_15_0 or var_15_0 == self.subImgName then
		return
	end

	self.subImgName = var_15_0

	GetImageSpriteFromAtlasAsync(self:ResPath() .. "/" .. var_15_0, "", self.subImage, true)

	return
end

function MainBaseActivityBtn:GetTipImage()
	return "tip"
end

function MainBaseActivityBtn:InitTipImage()
	local var_17_0 = self:GetTipImage()

	if not var_17_0 or var_17_0 == self.tipImageName then
		return
	end

	self.tipImageName = var_17_0

	GetImageSpriteFromAtlasAsync("LinkButton/" .. var_17_0, "", self.tipTr, true)

	return
end

function MainBaseActivityBtn:UpdatePosition(arg_18_1)
	self._tf.anchoredPosition = Vector2(self._tf.anchoredPosition.x, -150 - (arg_18_1 - 1) * (self._tf.sizeDelta.y + -20), 0)

	return
end

function MainBaseActivityBtn:Clear()
	if self._tf then
		setActive(self._tf, false)
	end

	return
end

function MainBaseActivityBtn:emit(...)
	self.event:emit(...)

	return
end

function MainBaseActivityBtn:Dispose()
	pg.DelegateInfo.Dispose(self)

	if self._tf then
		Destroy(self._tf.gameObject)

		self._tf = nil
	end

	return
end

function MainBaseActivityBtn:Skip(arg_22_1)
	if arg_22_1.type == GAMEUI_BANNER_1 then
		Application.OpenURL(arg_22_1.param)
	elseif arg_22_1.type == GAMEUI_BANNER_2 then
		self:emit(NewMainMediator.SKIP_SCENE, arg_22_1.param)
	elseif arg_22_1.type == GAMEUI_BANNER_3 then
		self:emit(NewMainMediator.SKIP_ACTIVITY, tonumber(arg_22_1.param))
	elseif arg_22_1.type == GAMEUI_BANNER_4 then
		self:emit(NewMainMediator.SKIP_SHOP, arg_22_1.param)
	elseif arg_22_1.type == GAMEUI_BANNER_5 then
		-- block empty
	elseif arg_22_1.type == GAMEUI_BANNER_6 then
		self:emit(NewMainMediator.GO_SCENE, SCENE.SELTECHNOLOGY)
	elseif arg_22_1.type == GAMEUI_BANNER_7 then
		self:emit(NewMainMediator.GO_MINI_GAME, arg_22_1.param[1])
	elseif arg_22_1.type == GAMEUI_BANNER_8 then
		if getProxy(GuildProxy):getRawData() then
			self:emit(NewMainMediator.GO_SCENE, SCENE.GUILD)
		else
			self:emit(NewMainMediator.GO_SCENE, SCENE.NEWGUILD)
		end
	elseif arg_22_1.type == GAMEUI_BANNER_14 then
		self:emit(NewMainMediator.OPEN_KINK_BUTTON_LAYER, Context.New({
			mediator = _G[arg_22_1.param.mediator],
			viewComponent = _G[arg_22_1.param.view]
		}))
	elseif arg_22_1.type == GAMEUI_BANNER_15 then
		self:emit(NewMainMediator.SKIP_INS)
	elseif arg_22_1.type == GAMEUI_BANNER_16 then
		if type(arg_22_1.param) == "table" then
			self.IsPlayeds = pg.NewStoryMgr.GetInstance():IsPlayed(arg_22_1.param[2])

			if not self.IsPlayeds then
				pg.NewStoryMgr.GetInstance():Play(arg_22_1.param[2], function()
					self:emit(NewMainMediator.SKIP_CORE_ACTIVITY, arg_22_1.param[1])

					return
				end)
			else
				self:emit(NewMainMediator.SKIP_CORE_ACTIVITY, arg_22_1.param[1])
			end
		else
			self:emit(NewMainMediator.SKIP_CORE_ACTIVITY, arg_22_1.param)
		end
	end

	return
end

function MainBaseActivityBtn:ResPath()
	return "LinkButton"
end

function MainBaseActivityBtn:GetActivityID()
	assert(false, "策划配置default类型 必须重写这个方法")

	return
end

function MainBaseActivityBtn:CustomOnClick()
	assert(false, "策划配置type = 0 这个按钮必须自己定义跳转行为")

	return
end

function MainBaseActivityBtn:GetEventName()
	assert(false, "overwrite me !!!")

	return
end

function MainBaseActivityBtn:OnInit()
	return
end

return MainBaseActivityBtn
