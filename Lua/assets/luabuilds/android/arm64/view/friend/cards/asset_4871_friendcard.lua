local FriendCard = class("FriendCard")

function FriendCard:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.go = arg_1_1
	self.tf = tf(arg_1_1)
	self.nameTF = self.tf:Find("frame/request_info/name_bg/Text"):GetComponent(typeof(Text))
	self.iconTF = self.tf:Find("icon/icon_bg/icon"):GetComponent(typeof(Image))
	self.circle = self.tf:Find("icon/icon_bg/frame")
	self.starList = UIItemList.New(self.tf:Find("icon/icon_bg/stars"), self.tf:Find("icon/icon_bg/stars/star"))
	self.manifestoTF = self.tf:Find("frame/request_content/Text"):GetComponent(typeof(Text))
	self.resumeBtn = self.tf:Find("resume_btn")

	return
end

function FriendCard:update(arg_2_1)
	self:clear()

	self.friendVO = arg_2_1
	self.nameTF.text = arg_2_1.name

	local var_2_1 = Ship.New({
		configId = arg_2_1.icon
	})

	LoadSpriteAsync("qicon/" .. var_2_1:getPrefab(), function(arg_3_0)
		self.iconTF.sprite = arg_3_0

		return
	end)

	local var_2_2 = AttireFrame.attireFrameRes(arg_2_1, arg_2_1.id == getProxy(PlayerProxy):getRawData().id, AttireConst.TYPE_ICON_FRAME, arg_2_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_2_2, var_2_2, true, function(arg_4_0)
		if IsNil(self.tf) then
			return
		end

		if self.circle then
			arg_4_0.name = var_2_2
			findTF(arg_4_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_4_0, self.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_2_2, var_2_2, arg_4_0)
		end

		return
	end)
	self.starList:align((var_2_1:getStar()))

	return
end

function FriendCard:clear()
	if self.circle.childCount > 0 then
		local var_5_0 = self.circle:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_5_0.name, var_5_0.name, var_5_0)
	end

	return
end

function FriendCard:dispose()
	pg.DelegateInfo.Dispose(self)
	self:clear()

	return
end

return FriendCard
