local TacticsShipItem = class("TacticsShipItem", import(".DockyardShipItem"))

function TacticsShipItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.isLoaded = false

	if IsNil(arg_1_2) then
		local function var_1_0(arg_2_0)
			arg_2_0.name = "ShipCardTpl"

			setParent(arg_2_0, arg_1_1)

			arg_2_0.transform.localScale = Vector3(1.28, 1.28, 1)
			arg_2_0.transform.localPosition = Vector3(0, 251, 0)

			TacticsShipItem.super.Ctor(self, arg_2_0, arg_1_3, arg_1_4)

			self.isLoaded = true

			if self.cacheShipVO then
				self:update(self.cacheShipVO)
			end

			return
		end

		ResourceMgr.Inst:getAssetAsync("template/shipcardtpl", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
			var_1_0((Instantiate(arg_3_0)))

			return
		end), true, true)
	else
		TacticsShipItem.super.Ctor(self, arg_1_2, arg_1_3, arg_1_4)

		self.isLoaded = true
	end

	return
end

function TacticsShipItem:update(arg_4_1)
	if not self.isLoaded then
		self.cacheShipVO = arg_4_1
	else
		TacticsShipItem.super.update(self, arg_4_1)
	end

	return
end

function TacticsShipItem:UpdateExpBuff()
	return
end

return TacticsShipItem
