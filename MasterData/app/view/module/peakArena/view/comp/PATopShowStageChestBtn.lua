local PATopShowStageChestBtn = class("PATopShowStageChestBtn", require("app.fairyGUI.peakArena.UI_PATopShowStageChestBtn"))

function PATopShowStageChestBtn:ctor()
	self._userSnapshot = nil

	self:addClickListener(handler(self, self._onClickChest))
end

function PATopShowStageChestBtn:updateChest(arg_2_1)
	self._userSnapshot = arg_2_1
end

function PATopShowStageChestBtn:_onClickChest()
	if self._userSnapshot then
		g.core.network.GameNetProxy:send_C2S_PeakArena_AllianceRankAward({
			target_id = self._userSnapshot.id
		})
	end
end

return PATopShowStageChestBtn
