braceletBuild = {}

require("game/braceletBuild/manager/BraceletBuildConst")

------------------------------suc------------------------------

braceletBuild.BraceletRefineSucPanel = require("game/braceletBuild/view/success/BraceletRefineSucPanel")
braceletBuild.BraceletStrengthenSucPanel = require("game/braceletBuild/view/success/BraceletStrengthenSucPanel")

braceletBuild.BraceletEmpowerTipsPanel = require("game/braceletBuild/view/BraceletEmpowerTipsPanel")
braceletBuild.BraceletEmpowerSurePanel = require("game/braceletBuild/view/BraceletEmpowerSurePanel")
braceletBuild.BraceletEmpowerUpPanel = require("game/braceletBuild/view/BraceletEmpowerUpPanel")

braceletBuild.BraceletStrengthenShowltem = require("game/braceletBuild/view/item/BraceletStrengthenShowltem")

braceletBuild.BraceletRefineTab = require("game/braceletBuild/view/tab/BraceletRefineTab")
braceletBuild.BraceletEmpowerTab = require("game/braceletBuild/view/tab/BraceletEmpowerTab")
braceletBuild.BraceletStrengthenTab = require("game/braceletBuild/view/tab/BraceletStrengthenTab")
braceletBuild.BraceletBuildPanel = require("game/braceletBuild/view/BraceletBuildPanel")

braceletBuild.BraceletMaterialItem = require("game/braceletBuild/view/item/BraceletMaterialItem")
braceletBuild.BraceletMaterialPanel = require("game/braceletBuild/view/BraceletMaterialPanel")
braceletBuild.BraceletRemakeMaterialItem = require("game/braceletBuild/view/item/BraceletRemakeMaterialItem")

braceletBuild.BraceletRefineUpView = require("game/braceletBuild/view/BraceletRefineUpView")

braceletBuild.BraceletRefineConfigVo = require("game/braceletBuild/manager/vo/BraceletRefineConfigVo")

braceletBuild.BraceletBuildManager = require("game/braceletBuild/manager/BraceletBuildManager").new()
braceletBuild.BraceletsBuildController = require("game/braceletBuild/controller/BraceletBuildController").new(braceletBuild.BraceletBuildManager)

local _model = {braceletBuild.BraceletsBuildController}
return _model
