local GuildRequestCard = class("GuildRequestCard")

function GuildRequestCard:Ctor(arg_1_1)
	self.tf = tf(arg_1_1)
	self.nameTF = self.tf:Find("frame/request_info/name"):GetComponent(typeof(Text))
	self.levelTF = self.tf:Find("frame/request_info/level"):GetComponent(typeof(Text))
	self.dateTF = self.tf:Find("frame/request_info/date"):GetComponent(typeof(Text))
	self.msg = self.tf:Find("frame/request_content/Text"):GetComponent(typeof(Text))
	self.iconTF = self.tf:Find("frame/shipicon/icon"):GetComponent(typeof(Image))
	self.starsTF = self.tf:Find("frame/shipicon/stars")
	self.circle = self.tf:Find("frame/shipicon/frame")
	self.starTF = self.tf:Find("frame/shipicon/stars/star")
	self.rejectBtn = self.tf:Find("frame/refuse_btn")
	self.accpetBtn = self.tf:Find("frame/accpet_btn")

	return
end

function GuildRequestCard:Update(arg_2_1)
	self:Clear()

	self.requestVO = arg_2_1
	self.nameTF.text = arg_2_1.player.name
	self.levelTF.text = "Lv." .. arg_2_1.player.level
	self.dateTF.text = getOfflineTimeStamp(arg_2_1.timestamp)
	self.msg.text = arg_2_1.content

	local var_2_0 = AttireFrame.attireFrameRes(arg_2_1.player, arg_2_1.player.id == getProxy(PlayerProxy):getRawData().id, AttireConst.TYPE_ICON_FRAME, arg_2_1.player.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_2_0, var_2_0, true, function(arg_3_0)
		if IsNil(self.tf) then
			return
		end

		if self.circle then
			arg_3_0.name = var_2_0
			findTF(arg_3_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_3_0, self.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_2_0, var_2_0, arg_3_0)
		end

		return
	end)

	local var_2_1 = pg.ship_data_statistics[arg_2_1.player.icon]

	if pg.ship_data_statistics[arg_2_1.player.icon] then
		LoadSpriteAsync("qicon/" .. arg_2_1.player:getPainting(), function(arg_4_0)
			self.iconTF.sprite = arg_4_0

			return
		end)

		for iter_2_0 = self.starsTF.childCount, var_2_1.star - 1 do
			cloneTplTo(self.starTF, self.starsTF)
		end

		for iter_2_1 = 1, self.starsTF.childCount do
			setActive(self.starsTF:GetChild(iter_2_1 - 1), iter_2_1 <= var_2_1.star)
		end
	end

	return
end

function GuildRequestCard:Clear()
	if self.circle.childCount > 0 then
		local var_5_0 = self.circle:GetChild(0)

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_5_0.gameObject.name, var_5_0.gameObject.name, var_5_0.gameObject)
	end

	return
end

function GuildRequestCard:Dispose()
	self:Clear()

	return
end

return GuildRequestCard
