-- chunkname: @IQIGame\\UI\\TransformUI\\TransformUITransContent.lua

local TransformUICompoundContentClass = require("IQIGame.UI.TransformUI.TransformUICompoundContent")
local TransformUITransContent = class(nil, TransformUICompoundContentClass)

function TransformUITransContent.New(go, mainView)
	local o = Clone(TransformUITransContent)

	o:Initialize(go, mainView)

	return o
end

return TransformUITransContent
