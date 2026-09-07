local CombatUIStyle = class("CombatUIStyle", import(".AttireFrame"))

function CombatUIStyle:GetIcon()
	return "CombatUIStyle/" .. self
end

function CombatUIStyle:bindConfigTable()
	return pg.item_data_battleui
end

function CombatUIStyle:getType()
	return AttireConst.TYPE_COMBAT_UI_STYLE
end

function CombatUIStyle:getDropType()
	return DROP_TYPE_COMBAT_UI_STYLE
end

function CombatUIStyle:getPrefabName()
	return self:getConfig("id")
end

function CombatUIStyle:getIcon()
	return CombatUIStyle.GetIcon(self:getPrefabName())
end

function CombatUIStyle:updateData()
	return
end

function CombatUIStyle:isOwned()
	return self:bindConfigTable()[self.id].is_unlock == 0 or self.owned
end

function CombatUIStyle:isNew()
	return self.new == true
end

function CombatUIStyle:setNew()
	self.new = true

	return
end

function CombatUIStyle:setUnlock()
	self.owned = true

	if self.lock then
		self.lock = false

		self:setNew()
	end

	return
end

function CombatUIStyle:setLock()
	self.lock = true

	return
end

return CombatUIStyle
