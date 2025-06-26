module("notice.NoticeParamVo", Class.impl())

function ctor(self)
	self:__init()
end

function __init(self)
	--类型
	self.type = nil
	--值
	self.value = nil
	--道具
	self.propsList = nil
end

function setMsgData(self, pt_hearsay_param)
	self.type = pt_hearsay_param.type
	self.value = pt_hearsay_param.value
	local propsMsgList = pt_hearsay_param.item
	self.propsList = {}
	if(propsMsgList and #propsMsgList > 0) then
		local len = #propsMsgList
		for i = 1, len do
			local pt_prop_bag = propsMsgList[i]
			local propsVo = props.PropsManager:getTypePropsVoByTid(pt_prop_bag.tid)
			propsVo:setPropsBagMsgData(nil, pt_prop_bag)
			table.insert(self.propsList, propsVo)
		end
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
