local AiTree = require("utils.ai_tree")
local Util = require("utils.util")
local AI = Util.create_class()

function AI:_init(robot, tree)
  self.robot = robot
  self.tree = assert(AiTree[tree], "AI tree not found! " .. tree)()
  self.tree_name = tree
end

function AI:get_robot()
  return self.robot
end

function AI:get_tree()
  return self.tree
end

function AI:get_tree_name()
  return self.tree_name
end

function AI:update(now)
  self.tree(self, now)
end

return AI
