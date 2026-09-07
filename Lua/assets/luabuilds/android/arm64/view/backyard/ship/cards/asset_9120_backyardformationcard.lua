local BackYardFormationCard = class("BackYardFormationCard", import("view.ship.FormationCard"))

function BackYardFormationCard:Ctor(arg_1_1)
	BackYardFormationCard.super.Ctor(self, arg_1_1)

	self.propsTr1 = self.detailTF:Find("info1")
	self.nameTr = self.detailTF:Find("name_mask")
	self.startTr = self.content:Find("front/stars")

	return
end

function BackYardFormationCard:updateProps(arg_2_1)
	for iter_2_0 = 0, 4 do
		local var_2_0 = self.propsTr:GetChild(iter_2_0)

		if iter_2_0 < #arg_2_1 then
			var_2_0.gameObject:SetActive(true)

			var_2_0:GetChild(0):GetComponent("Text").text = arg_2_1[iter_2_0 + 1][1]
			var_2_0:GetChild(1):GetComponent("Text").text = arg_2_1[iter_2_0 + 1][2]
		else
			var_2_0.gameObject:SetActive(false)
		end
	end

	setAnchoredPosition(self.nameTr, {
		y = 270
	})
	setAnchoredPosition(self.shipState, {
		y = 32
	})
	setAnchoredPosition(self.startTr, {
		y = -14
	})
	setAnchoredPosition(self.proposeMark, {
		y = 3.2
	})

	return
end

function BackYardFormationCard:updateProps1(arg_3_1)
	for iter_3_0 = 0, 2 do
		local var_3_0 = self.propsTr1:GetChild(iter_3_0)

		if iter_3_0 < #arg_3_1 then
			var_3_0.gameObject:SetActive(true)

			var_3_0:GetChild(0):GetComponent("Text").text = arg_3_1[iter_3_0 + 1][1]
			var_3_0:GetChild(1):GetComponent("Text").text = arg_3_1[iter_3_0 + 1][2]
		else
			var_3_0.gameObject:SetActive(false)
		end
	end

	setAnchoredPosition(self.nameTr, {
		y = 174
	})
	setAnchoredPosition(self.shipState, {
		y = -64
	})
	setAnchoredPosition(self.startTr, {
		y = -110
	})
	setAnchoredPosition(self.proposeMark, {
		y = -92.8
	})

	return
end

return BackYardFormationCard
