-- chunkname: @framework/helper/boxCollider2dhelper.lua

module("framework.helper.boxCollider2dhelper", package.seeall)

local boxCollider2dhelper = {}
local CSBoxC2dHelper = SLFramework.UGUI.BoxCollider2DHelper

function boxCollider2dhelper.getOffset(boxCollider2d)
	return CSBoxC2dHelper.GetOffset(boxCollider2d, 0, 0)
end

function boxCollider2dhelper.setOffset(boxCollider2d, x, y)
	return CSBoxC2dHelper.SetOffset(boxCollider2d, x, y)
end

function boxCollider2dhelper.getSize(boxCollider2d)
	return CSBoxC2dHelper.GetSize(boxCollider2d, 0, 0)
end

function boxCollider2dhelper.setSize(boxCollider2d, x, y)
	CSBoxC2dHelper.SetSize(boxCollider2d, x, y)
end

return boxCollider2dhelper
