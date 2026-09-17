local LayerNotificationManager = class("LayerNotificationManager")
local var_0_1

function LayerNotificationManager:ctor()
	self._notificationTable = {}
	self._staticNotificationTable = {}
	self._layerNotificationTable = {}
end

function LayerNotificationManager:getInstance()
	var_0_1 = var_0_1 or self.new()

	return var_0_1
end

function LayerNotificationManager:registerNotification(arg_3_1, arg_3_2)
	self._notificationTable[arg_3_1] = self._notificationTable[arg_3_1] or {}
	self._notificationTable[arg_3_1][arg_3_2.manager] = self._notificationTable[arg_3_1][arg_3_2.manager] or arg_3_2
end

function LayerNotificationManager:registerStaticNotification(arg_4_1, arg_4_2)
	self._staticNotificationTable[arg_4_1] = self._staticNotificationTable[arg_4_1] or {}
	self._staticNotificationTable[arg_4_1][arg_4_2.manager] = self._staticNotificationTable[arg_4_1][arg_4_2.manager] or arg_4_2
end

function LayerNotificationManager:registerLayerNotification(arg_5_1, arg_5_2)
	self._layerNotificationTable[arg_5_1] = self._layerNotificationTable[arg_5_1] or {}
	self._layerNotificationTable[arg_5_1][arg_5_2.layer] = self._layerNotificationTable[arg_5_1][arg_5_2.layer] or arg_5_2
end

function LayerNotificationManager:removeNotification(arg_6_1)
	if self._notificationTable[arg_6_1] then
		self._notificationTable[arg_6_1] = nil
	end
end

function LayerNotificationManager:removeManagerNotification(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(self._notificationTable) do
		iter_7_1[arg_7_1] = nil
	end
end

function LayerNotificationManager:removeLayerNotification(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self._layerNotificationTable) do
		iter_8_1[arg_8_1] = nil
	end
end

function LayerNotificationManager:sendNotification(arg_9_1, arg_9_2)
	if self._notificationTable[arg_9_1] then
		for iter_9_0, iter_9_1 in pairs(self._notificationTable[arg_9_1]) do
			if iter_9_1.callBack then
				iter_9_1.callBack(arg_9_2)
			end
		end
	end

	if self._staticNotificationTable[arg_9_1] then
		for iter_9_2, iter_9_3 in pairs(self._staticNotificationTable[arg_9_1]) do
			if iter_9_3.callBack then
				iter_9_3.callBack(arg_9_2)
			end
		end
	end

	if self._layerNotificationTable[arg_9_1] then
		for iter_9_4, iter_9_5 in pairs(self._layerNotificationTable[arg_9_1]) do
			if iter_9_5.callBack then
				iter_9_5.callBack(arg_9_2)
			end
		end
	end
end

return LayerNotificationManager
