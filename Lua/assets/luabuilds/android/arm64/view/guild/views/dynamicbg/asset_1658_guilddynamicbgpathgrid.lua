local GuildDynamicBgPathGrid = class("GuildDynamicBgPathGrid")

function GuildDynamicBgPathGrid:Ctor(arg_1_1)
	self.canWalk = arg_1_1.canWalk
	self.position = arg_1_1.position
	self.sizeDelta = arg_1_1.sizeDelta
	self.startPosOffset = arg_1_1.startPosOffset
	self.lockCnt = 0
	self.localPosition = self.startPosOffset + Vector3(self.position.x * self.sizeDelta.x, self.position.y * self.sizeDelta.y, 0)
	self.centerPosition = Vector3(self.localPosition.x + self.sizeDelta.x / 2, self.localPosition.y + self.sizeDelta.y / 2)

	return
end

function GuildDynamicBgPathGrid:GetPosition()
	return self.position
end

function GuildDynamicBgPathGrid:GetLocalPosition()
	return self.localPosition
end

function GuildDynamicBgPathGrid:GetCenterPosition()
	return self.centerPosition
end

function GuildDynamicBgPathGrid:CanWalk()
	return self.canWalk and not self:IsLock()
end

function GuildDynamicBgPathGrid:Lock()
	self.lockCnt = self.lockCnt + 1

	return
end

function GuildDynamicBgPathGrid:Unlock()
	if self.lockCnt > 0 then
		self.lockCnt = self.lockCnt - 1
	end

	return
end

function GuildDynamicBgPathGrid:UnlockAll()
	self.lockCnt = 0

	return
end

function GuildDynamicBgPathGrid:IsLock()
	return self.lockCnt > 0
end

function GuildDynamicBgPathGrid:GetAroundGrids()
	return {
		Vector2(self.position.x, self.position.y + 1),
		Vector2(self.position.x, self.position.y - 1),
		Vector2(self.position.x + 1, self.position.y),
		(Vector2(self.position.x - 1, self.position.y))
	}
end

return GuildDynamicBgPathGrid
