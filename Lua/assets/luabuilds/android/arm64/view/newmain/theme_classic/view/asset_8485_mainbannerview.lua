local MainBannerView = class("MainBannerView", import("...base.MainBaseView"))

function MainBannerView:Ctor(arg_1_1, arg_1_2)
	MainBannerView.super.Ctor(self, arg_1_1, arg_1_2)

	self.scrollSnap = BannerScrollRect.New(findTF(arg_1_1, "mask/content"), findTF(arg_1_1, "dots"))
	self.downloadmgr = BulletinBoardMgr.Inst
	self.rawImages = {}

	return
end

function MainBannerView:Init()
	local var_2_0 = getProxy(ActivityProxy):getBannerDisplays()

	self:UpdateItems(var_2_0)

	self.banners = var_2_0

	return
end

function MainBannerView:Refresh()
	if #self.banners ~= #getProxy(ActivityProxy):getBannerDisplays() then
		self:Clear()
		self:Init()
	else
		self.scrollSnap:Resume()
	end

	return
end

function MainBannerView:UpdateItems(arg_4_1)
	for iter_4_0 = 0, #arg_4_1 - 1 do
		local var_4_0 = arg_4_1[iter_4_0 + 1]
		local var_4_1 = self.scrollSnap:AddChild()

		self:UpdateItemImage(arg_4_1[iter_4_0 + 1], var_4_1)
		setActive(findTF(var_4_1, "red"), var_4_0.type == 3 and tonumber(var_4_0.param) == nil and getProxy(ActivityProxy):readyToAchieveByType(ActivityConst.ACTIVITY_TYPE_LEVELAWARD))
		onButton(self, var_4_1, function()
			self:Tracking(var_4_0.id)
			MainBaseActivityBtn.Skip(self, var_4_0)

			return
		end, SFX_MAIN)
	end

	self.scrollSnap:SetUp()

	return
end

function MainBannerView:GetItemPicPath(arg_6_1)
	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		local var_6_0 = pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()
		local var_6_1 = arg_6_1.pic_hx or {}

		if #var_6_1 <= 0 then
			return arg_6_1.pic
		end

		local var_6_2 = _.detect(var_6_1, function(arg_7_0)
			return arg_7_0[1] == var_6_0
		end)

		if not var_6_2 then
			return arg_6_1.pic
		end

		do return var_6_2[2] or arg_6_1.pic end
		return
	end

	return arg_6_1.pic
end

function MainBannerView:UpdateItemImage(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2:Find("texture")
	local var_8_1 = arg_8_2:Find("image")
	local var_8_2 = self:GetItemPicPath(arg_8_1)
	local var_8_3 = StringStartsWith(var_8_2, "https://") or StringStartsWith(var_8_2, "http://")

	setActive(var_8_0, var_8_3)
	setActive(var_8_1, not var_8_3)

	if var_8_3 then
		self.downloadmgr:GetTexture("main_banner", "1", var_8_2, UnityEngine.Events.UnityAction_UnityEngine_Texture(function(arg_9_0)
			if self.exited or IsNil(var_8_0) then
				return
			end

			local var_9_0 = var_8_0:GetComponent(typeof(RawImage))

			var_9_0.texture = arg_9_0

			table.insert(self.rawImages, var_9_0)

			return
		end))
	else
		LoadImageSpriteAsync("activitybanner/" .. var_8_2, var_8_1)
	end

	return
end

function MainBannerView:Tracking(arg_10_1)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildTouchBanner(arg_10_1))

	return
end

function MainBannerView:GetDirection()
	return Vector2(1, 0)
end

function MainBannerView:Disable()
	self.scrollSnap:Pause()

	return
end

function MainBannerView:Clear()
	self.scrollSnap:Reset()

	return
end

function MainBannerView:Dispose()
	MainBannerView.super.Dispose(self)

	for iter_14_0, iter_14_1 in ipairs(self.rawImages) do
		iter_14_1.texture = nil
	end

	self.rawImages = nil

	self:Clear()
	self.scrollSnap:Dispose()

	self.scrollSnap = nil
	self.exited = true
	self.downloadmgr = nil

	return
end

return MainBannerView
