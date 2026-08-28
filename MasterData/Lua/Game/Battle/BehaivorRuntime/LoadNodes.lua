import 'Game.Battle.BehaivorRuntime.b3'
import 'Game.Battle.BehaivorRuntime.Core.Action'
import 'Game.Battle.BehaivorRuntime.Core.BaseNode'
import 'Game.Battle.BehaivorRuntime.Core.BehaviorTree'
import 'Game.Battle.BehaivorRuntime.Core.Blackboard'
import 'Game.Battle.BehaivorRuntime.Core.Composite'
import 'Game.Battle.BehaivorRuntime.Core.Condition'
import 'Game.Battle.BehaivorRuntime.Core.Decorator'
import 'Game.Battle.BehaivorRuntime.Core.Decorator'
import 'Game.Battle.BehaivorRuntime.Core.Tick'

import 'Game.Battle.BehaivorRuntime.Conditions.CallLuaCondition'

import 'Game.Battle.BehaivorRuntime.Actions.Error'
import 'Game.Battle.BehaivorRuntime.Actions.Failer'
import 'Game.Battle.BehaivorRuntime.Actions.Runner'
import 'Game.Battle.BehaivorRuntime.Actions.Succeeder'
import 'Game.Battle.BehaivorRuntime.Actions.Wait'
import 'Game.Battle.BehaivorRuntime.Actions.CallLuaAction'

import 'Game.Battle.BehaivorRuntime.Composites.MemPriority'
import 'Game.Battle.BehaivorRuntime.Composites.MemSequence'
import 'Game.Battle.BehaivorRuntime.Composites.Priority'
import 'Game.Battle.BehaivorRuntime.Composites.Sequence'
import 'Game.Battle.BehaivorRuntime.Composites.Selector'
import 'Game.Battle.BehaivorRuntime.Composites.PriorityRandomSelector'


import 'Game.Battle.BehaivorRuntime.Decorators.Inverter'
import 'Game.Battle.BehaivorRuntime.Decorators.Limiter'
import 'Game.Battle.BehaivorRuntime.Decorators.MaxTime'
import 'Game.Battle.BehaivorRuntime.Decorators.Repeater'
import 'Game.Battle.BehaivorRuntime.Decorators.RepeatUntilFailure'
import 'Game.Battle.BehaivorRuntime.Decorators.RepeatUntilSuccess'

-- local action = b3.Action.New()
-- print(action.category)

-- local baseNode = b3.BaseNode.New()
-- print(baseNode.id)
-- print(baseNode.name)
-- print(baseNode.title)
-- print(baseNode.description)
-- print(baseNode.parameters)
-- print(baseNode.properties)

-- local behaviorTree = b3.BehaviorTree.New()
-- print(behaviorTree.id)
-- print(behaviorTree.title)
-- print(behaviorTree.description)
-- print(behaviorTree.properties)
-- print(behaviorTree.root)
-- print(behaviorTree.debug)

-- local blackBoard = b3.Blackboard.New()
-- print(blackBoard._baseMemory)
-- print(blackBoard._treeMemory)

-- local composite = b3.Composite.New()
-- print(composite.children)

-- local condition = b3.Condition.New()

-- local decorator = b3.Decorator.New()
-- print(decorator.child)

-- local tick = b3.Tick.New()
-- print(tick.tree)
-- print(tick.debug)
-- print(tick.target)
-- print(tick.blackboard)
-- print(tick._openNodes)
-- print(tick._nodeCount)

-- local error = b3.Error.New()
-- print(error.name)

-- local failer = b3.Failer.New()
-- print(failer.name)

-- local runner = b3.Runner.New()
-- print(runner.name)

-- local succeeder = b3.Succeeder.New()
-- print(succeeder.name)

-- local wait = b3.Wait.New()
-- print(wait.name)
-- print(wait.id)
-- print(wait.title)
-- print(wait.description)

-- local memPriority = b3.MemPriority.New()
-- print(memPriority.name)

-- local memSequence = b3.MemSequence.New()
-- print(memSequence.name)

-- local priority = b3.Priority.New()
-- print(priority.name)

-- local sequence = b3.Sequence.New()
-- print(sequence.name)
-- print(sequence.id)
-- print(sequence.title)

-- local inverter = b3.Inverter.New()
-- print(inverter.name)
-- print(inverter.id)
-- print(inverter.title)

-- local maxTime = b3.MaxTime.New()
-- print(maxTime.name)
-- print(maxTime.id)

-- local repeater = b3.Repeater.New()
-- print(repeater.name)
-- print(repeater.id)

-- local repeatUntilFailure = b3.RepeatUntilFailure.New()
-- print(repeatUntilFailure.name)
-- print(repeatUntilFailure.id)

-- local repeatUntilSuccess = b3.RepeatUntilSuccess.New()
-- print(repeatUntilSuccess.name)
-- print(repeatUntilSuccess.id)


-- local behaviorJson = {
-- 	id ='7c63023d-de92-4400-8ebc-1d60d73dea30',
-- 	title = 'A behavior tree',
-- 	description = '',
-- 	root = 'bd9162f8-92ce-47f5-8ba8-021685e8c4b0',
-- 	properties = {},
-- 	nodes = {
-- 	['bd9162f8-92ce-47f5-8ba8-021685e8c4b0'] = {
-- 			id = 'bd9162f8-92ce-47f5-8ba8-021685e8c4b0',
-- 			name = 'Repeater',
-- 			title = 'Repeat <maxLoop>x',
-- 			description = '',
-- 			properties = {
-- 				maxLoop = 5,
-- 			},
-- 			display = {
-- 				x = -264,
-- 				y = -84
-- 			},
-- 			child = '5b38e656-12cd-4402-88e3-c096eb6849ac'
-- 		},
-- 	['5b38e656-12cd-4402-88e3-c096eb6849ac'] = {
-- 		id = '5b38e656-12cd-4402-88e3-c096eb6849ac',
-- 		name = 'Sequence',
-- 		title = 'Sequence',
-- 		description = '',
-- 		properties = {},
-- 		display = {
-- 			x = -120,
-- 			y = -84
-- 		},
-- 		children = {
-- 			'902870e9-84ad-451d-884b-07557346ca93',
-- 			'32d0c734-b9d0-4db2-8170-7ba13df98d96'
-- 		}
-- 	},
-- 	['902870e9-84ad-451d-884b-07557346ca93'] = {
-- 	id = '902870e9-84ad-451d-884b-07557346ca93',
-- 		name = 'Failer',
-- 		title = 'Failer',
-- 		description = '',
-- 		properties = {},
-- 		display = {
-- 			x = 192,
-- 			y = -60
-- 		}
-- 	},
-- 	['32d0c734-b9d0-4db2-8170-7ba13df98d96'] = {
-- 		id = '32d0c734-b9d0-4db2-8170-7ba13df98d96',
-- 		name = 'Succeeder',
-- 		title = 'Succeeder',
-- 		description = '',
-- 		properties = {},
-- 		display = {
-- 			x = 168,
-- 			y = 24
-- 		}
-- 	}
-- },
-- 	display = {
-- 		camera_x = 960,
-- 		camera_y = 477.5,
-- 		camera_z = 1,
-- 		x = -396,
-- 		y = -84},
-- 	custom_nodes = {}
-- }

-- local jsonData = CS.CustomBehavior.BehaviacFileManager.ReadJson("Behaviac/TestLua.json")
-- local d = table.deserialize(jsonData)
-- print("------------------------------------------------")
-- behaviorTree:load(d, {})
-- print("------------------------------------------------")
-- behaviorTree:tick(nil, blackBoard)
