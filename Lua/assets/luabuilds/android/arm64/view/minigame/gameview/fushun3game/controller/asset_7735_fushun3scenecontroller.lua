local Fushun3SceneController = class("Fushun3SceneController")

function Fushun3SceneController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._sceneTf = arg_1_2
	self._followTf = arg_1_3
	self._sceneBackTf = arg_1_1
	self._backGrouds = {}

	for iter_1_0 = 1, #Fushun3GameConst.backgroud_data do
		table.insert(self._backGrouds, {
			tf = findTF(self._sceneBackTf, Fushun3GameConst.backgroud_data[iter_1_0].name),
			data = Fushun3GameConst.backgroud_data[iter_1_0]
		})
	end

	return
end

function Fushun3SceneController:start()
	self._sceneTf.anchoredPosition = Vector2(0, 0)

	for iter_2_0 = 1, #self._backGrouds do
		self._backGrouds[iter_2_0].tf.anchoredPosition = Vector2(0, 0)
	end

	return
end

function Fushun3SceneController:step()
	local var_3_0 = self._sceneTf.anchoredPosition
	local var_3_1 = 0

	if self._followTf.anchoredPosition.x + self._sceneTf.anchoredPosition.x > 350 then
		var_3_1 = (self._followTf.anchoredPosition.x + self._sceneTf.anchoredPosition.x - Fushun3GameConst.follow_bound_mid) * Fushun3GameConst.follow_spring * -1
	elseif self._followTf.anchoredPosition.x + self._sceneTf.anchoredPosition.x < 250 then
		var_3_1 = math.abs(self._followTf.anchoredPosition.x + self._sceneTf.anchoredPosition.x - Fushun3GameConst.follow_bound_mid) * Fushun3GameConst.follow_spring
	end

	if var_3_1 ~= 0 then
		if math.abs(var_3_1) < 1 then
			var_3_1 = 1 * math.sign(var_3_1)
		end

		var_3_0.x = var_3_0.x + var_3_1
		self._sceneTf.anchoredPosition = var_3_0

		for iter_3_0 = 1, #self._backGrouds do
			self._backGrouds[iter_3_0].tf.anchoredPosition.x = var_3_0.x * self._backGrouds[iter_3_0].data.rate
			self._backGrouds[iter_3_0].tf.anchoredPosition.y = var_3_0.y * self._backGrouds[iter_3_0].data.rate
			self._backGrouds[iter_3_0].tf.anchoredPosition = self._backGrouds[iter_3_0].tf.anchoredPosition
		end
	end

	return
end

function Fushun3SceneController:dispose()
	return
end

return Fushun3SceneController
