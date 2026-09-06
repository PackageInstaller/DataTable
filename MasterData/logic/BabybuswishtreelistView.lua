-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/BabybuswishtreelistView.lua

module("logic.extensions.babybus.view.BabybuswishtreelistView", package.seeall)

local BabybuswishtreelistView = class("BabybuswishtreelistView", WishTreeListView)

function BabybuswishtreelistView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell, goCell.data)
	local type, id, num = MaterialMgr.getMatParams(data.prize)
	local btnCell = cell.go:GetComponent(goutil.Type_UIButton)
	local materialName = MaterialMgr.getMaterialsName(type, id)

	MaterialMgr.setCell(type, id, cell.item)
	GameUtil.SetActive(cell.select, self._curSelect == data.prizeId)
	GameUtil.SetActive(cell.selected, data.selected)

	btnCell.enabled = not data.selected
	cell.txtCount.text = "x" .. num
	cell.txtName.text = materialName

	if not data.selected then
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickPrize, self, data.prizeId))
	end

	local offsetY = goCell.data % 2 == 0 and -28 or 0

	Framework.TransformUtil.SetAnchoredPos(cell.content.transform, 0, offsetY)
end

function BabybuswishtreelistView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.select = goutil.findChild(cell.go, "content/imgSelect")
	cell.selected = goutil.findChild(cell.go, "content/imgSelected")
	cell.item = goutil.findChild(cell.go, "content/item")
	cell.txtName = goutil.findChildTextComponent(cell.go, "content/name/txtName")
	cell.txtCount = goutil.findChildTextComponent(cell.go, "content/txtCount")
	cell.content = goutil.findChild(cell.go, "content")

	MaterialMgr.resetAll(cell)
	GameUtil.rmClickHandler(cell.go)

	return cell
end

function BabybuswishtreelistView:_onVoteScrollValueChanged(tableview)
	return
end

return BabybuswishtreelistView
