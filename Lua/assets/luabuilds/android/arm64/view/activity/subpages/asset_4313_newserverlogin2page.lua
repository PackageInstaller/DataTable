local NewServerLogin2Page = class("NewServerLogin2Page", import("...base.BaseActivityPage"))

function NewServerLogin2Page:OnInit()
	self.bg = self._tf:Find("AD")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("scrollrect/items")
	self.itemList = UIItemList.New(self.items, self.item)

	return
end

function NewServerLogin2Page:OnDataSetting()
	self.config = pg.activity_7_day_sign[self.activity:getConfig("config_id")]
	self.Day = #self.config.front_drops

	return
end

function NewServerLogin2Page:OnFirstFlush()
	setActive(self.item, false)
	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			local var_4_0 = {
				type = self.config.front_drops[arg_4_1 + 1][1],
				id = self.config.front_drops[arg_4_1 + 1][2],
				count = self.config.front_drops[arg_4_1 + 1][3]
			}

			updateDrop(arg_4_2:Find("item"), var_4_0)
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)
			GetImageSpriteFromAtlasAsync("ui/activityuipage/newserverlogin2page_atlas", arg_4_1 + 1, arg_4_2:Find("day"), true)
		elseif arg_4_0 == UIItemList.EventUpdate then
			setActive(arg_4_2:Find("got"), arg_4_1 < self.nday)
		end

		return
	end)
	onButton(self, self.bg:Find("go_btn"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS)

		return
	end, SFX_PANEL)

	return
end

function NewServerLogin2Page:OnUpdateFlush()
	self.nday = self.activity.data1

	self.itemList:align(self.Day)
	setLocalPosition(self.items, Vector2(-185 - 106 * (self.nday - 1), 0))

	return
end

function NewServerLogin2Page:OnDestroy()
	clearImageSprite(self.bg)
	removeAllChildren(self.items)

	return
end

return NewServerLogin2Page
