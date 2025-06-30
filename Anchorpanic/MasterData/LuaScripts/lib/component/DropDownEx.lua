module('lib.component.DropDownEx', Class.impl())

function bandDropDown(self,dropDown)
	self.mDropDown = dropDown
	self.value = self.mDropDown.value + 1
end

--添加事监听
function addValueChangedListener(self,notify_callfun)
	self:removeAllListeners()
	
	local notify = function (value)
		if not self.isNoNotify then
			notify_callfun(value)
		end

		self.isNoNotify = false
		self.value = value + 1
	end
	self.mDropDown.onValueChanged:AddListener(notify)
end

--设置value 不回调事件
function setValueWithNoNotify(self,val)
	--相同值不会回调，所以不需要设置不回调
	if self.mDropDown.value ~= val - 1 then
		self.isNoNotify = true
	end
	self.mDropDown.value = val - 1
end
--设置value 回调事件
function setValueWithOutNotify(self,val)
	self.isNoNotify = false
	self.mDropDown.value = val - 1
end
--移除所有事件
function removeAllListeners(self)
	self.mDropDown.onValueChanged:RemoveAllListeners()
end
--添加下拉选项
function AddOptions(self,options)
	self.mDropDown:ClearOptions()
    for j = 1, #options do
        gs.UGUIUtil.AddOptionsLua(self.mDropDown, options[j])
    end

    self:setValueWithNoNotify(-1)
end

--添加单个下拉label
function AddOption(self,str)
	gs.UGUIUtil.AddOptionsLua(self.mDropDown, str)
end

return _M