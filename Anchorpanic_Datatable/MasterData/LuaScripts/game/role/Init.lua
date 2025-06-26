role = {}
require('game/role/manager/RoleConst')

role.RoleLvlUpVo = require('game/role/manager/vo/RoleLvlUpVo')
role.RoleVo = require('game/role/manager/vo/RoleVo')
role.RoleBackGroundVo = require('game/role/manager/vo/RoleBackGroundVo')
role.PersonalInfoVo = require('game/role/manager/vo/PersonalInfoVo')
role.RoleManager = require('game/role/manager/RoleManager').new()

role.InfoTabView = require('game/role/view/tabView/InfoTabView')
role.ExchangeCodeTabView = require('game/role/view/tabView/ExchangeCodeTabView')
role.RolePanel = require('game/role/view/RolePanel')
role.RoleInfoView = require('game/role/view/tabView/RoleInfoView')
role.RoleInfoTipsView = require('game/role/view/RoleInfoTipsView')
role.RoleBgView = require('game/role/view/RoleBgView')

role.RoleModifyNamePanel = require('game/role/view/RoleModifyNamePanel')
role.RoleToNamePanel = require('game/role/view/RoleToNamePanel')
role.RoleModifyAutographPanel = require('game/role/view/RoleModifyAutographPanel')
role.ChangeExhibitionPanel = require("game/role/view/ChangeExhibitionPanel")
role.ChangeAvatarPanel = require("game/role/view/ChangeAvatarPanel")
role.RoleHeroSelectListItem = require("game/role/view/item/RoleHeroSelectListItem")

role.RoleSelectHeroPanel = require('game/role/view/RoleSelectHeroPanel')

role.RoleLevelUpView = require('game/role/view/RoleLevelUpView')

role.RoleSelectHeroItem = require('game/role/view/item/RoleSelectHeroItem')
role.RoleShowHeroItem = require('game/role/view/item/RoleShowHeroItem')
role.OtherRoleShowHeroItem = require('game/role/view/item/OtherRoleShowHeroItem')
role.RoleHeroShowEquipGrid = require('game/role/view/item/RoleHeroShowEquipGrid')
role.RoleGuradGroupSelectItem = require('game/role/view/item/RoleGuradGroupSelectItem')
role.RoleGuradGroupFashionItem = require('game/role/view/item/RoleGuradGroupFashionItem')

role.OtherRoleVo = require('game/role/manager/vo/OtherRoleVo')
role.MyRoleInfoPreView = require('game/role/view/MyRoleInfoPreView')
role.OtherRoleInfoView = 'game/role/view/OtherRoleInfoView'
role.OtherRoleMarkView = 'game/role/view/OtherRoleMarkView'
role.SingleHeroInfoView = 'game/role/view/SingleHeroInfoView'
role.RoleGuradGroupPanel = 'game/role/view/RoleGuradGroupPanel'
role.RoleGuradGroupSelectView = 'game/role/view/RoleGuradGroupSelectView'
role.RoleGuradGroupFashionView = 'game/role/view/RoleGuradGroupFashionView'

role.RoleController = require('game/role/controller/RoleController').new(role.RoleManager)

local module = { role.RoleController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]