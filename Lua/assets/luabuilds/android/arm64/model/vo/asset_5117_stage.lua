local Stage = class("Stage", import(".BaseVO"))

Stage.SubmarinStage = 15

function Stage:Ctor(arg_1_1)
	self.configId = arg_1_1.id
	self.id = self.configId
	self.score = arg_1_1.score
	self.out_time = arg_1_1.out_time or 0

	return
end

function Stage:bindConfigTable()
	return pg.expedition_data_template
end

function Stage:isFinish()
	return self.score and self.score > 1
end

return Stage
