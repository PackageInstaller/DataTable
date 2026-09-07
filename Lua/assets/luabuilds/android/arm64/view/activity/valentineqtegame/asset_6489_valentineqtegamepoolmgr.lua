local ValentineQteGamePoolMgr = class("ValentineQteGamePoolMgr")

function ValentineQteGamePoolMgr:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.tpl = arg_1_1
	self.initCnt = arg_1_2
	self.maxCnt = arg_1_3
	self.items = {}

	setActive(self.tpl, false)
	self:Init()

	return
end

function ValentineQteGamePoolMgr:Init()
	for iter_2_0 = 1, self.initCnt do
		table.insert(self.items, (self:NewItem()))
	end

	return
end

function ValentineQteGamePoolMgr:NewItem()
	local var_3_0 = Instantiate(self.tpl)

	SetParent(var_3_0, self.tpl.transform.parent)

	return var_3_0
end

function ValentineQteGamePoolMgr:Dequeue()
	local var_4_0 = #self.items > 0 and table.remove(self.items, 1) or self:NewItem()

	setActive(var_4_0, true)

	return var_4_0
end

function ValentineQteGamePoolMgr:Enqueue(arg_5_1)
	if #self.items >= self.maxCnt then
		self:DestroyItem(arg_5_1)
	else
		setActive(arg_5_1, false)
		SetParent(arg_5_1, self.tpl.transform.parent)
		table.insert(self.items, arg_5_1.gameObject)
	end

	return
end

function ValentineQteGamePoolMgr:DestroyItem(arg_6_1)
	Object.Destroy(go(arg_6_1))

	return
end

function ValentineQteGamePoolMgr:Destroy()
	for iter_7_0, iter_7_1 in ipairs(self.items) do
		self:DestroyItem(iter_7_1)
	end

	self.items = nil

	return
end

return ValentineQteGamePoolMgr
