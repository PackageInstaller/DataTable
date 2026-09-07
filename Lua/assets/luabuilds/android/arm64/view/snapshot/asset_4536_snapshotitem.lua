local SnapshotItem = class("SnapshotItem")

SnapshotItem.NAME_COLOR = {
	"#FFFFFFFF",
	"#5A9BFFFF"
}

function SnapshotItem:Ctor(arg_1_1, arg_1_2)
	self.go = arg_1_1
	self.selected = arg_1_2
	self.tr = arg_1_1.transform
	self.btn = arg_1_1:GetComponent("Button")
	self.nameTF = findTF(self.tr, "Text")
	self.nameTxt = self.nameTF:GetComponent("Text")
	self.unselectGo = findTF(self.tr, "unselect").gameObject
	self.selectedGo = findTF(self.tr, "selected").gameObject
	self.info = nil
	self.id = -1

	self.selectedGo:SetActive(false)

	return
end

function SnapshotItem:Update(arg_2_1)
	self.info = arg_2_1
	self.id = arg_2_1.id

	self:flush()

	return
end

function SnapshotItem:UpdateSelected(arg_3_1)
	self.selected = arg_3_1

	self.unselectGo:SetActive(not self.selected)
	self.selectedGo:SetActive(self.selected)

	self.nameTxt.text = self.selected and setColorStr(self.info.name, self.NAME_COLOR[2]) or setColorStr(self.info.name, self.NAME_COLOR[1])

	return
end

function SnapshotItem:HasInfo()
	return self.info ~= nil
end

function SnapshotItem:GetID()
	return self.id
end

function SnapshotItem:flush()
	self.nameTxt.text = self.info.name

	return
end

function SnapshotItem:SetEulerAngle(arg_7_1)
	local var_7_0 = rtf(self.nameTF).eulerAngles

	rtf(self.nameTF).eulerAngles = Vector3(0, 0, arg_7_1)

	return
end

function SnapshotItem:RotateUI(arg_8_1, arg_8_2)
	LeanTween.rotateZ(go(self.nameTF), arg_8_1, arg_8_2)

	return
end

return SnapshotItem
