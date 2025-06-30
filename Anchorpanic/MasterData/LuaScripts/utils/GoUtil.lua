module("GoUtil", Class.impl())

function GetChildHash(go)
	local resultGos = {}
	local resultTrans = {}
	local coms = gs.GoUtil.GetComsInChildren(go)
	-- local coms = go.GetComponentsInChildren(go,ty.Transform, true)
	local len = coms.Length-1
	for i=0,len do
		local trans = coms[i]
		resultGos[trans.name] = trans.gameObject
		resultTrans[trans.name] = trans
	end
	return resultGos, resultTrans
end

return _M