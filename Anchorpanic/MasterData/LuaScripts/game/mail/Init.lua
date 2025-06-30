mail = {}
mail.MailConst = require('game/mail/manager/MailConst')
mail.MailVo = require('game/mail/manager/vo/MailVo')
mail.MailManager = require('game/mail/manager/MailManager').new()

mail.MailView = 'game/mail/view/MailView'
mail.MailItem = require('game/mail/view/item/MailItem')

mail.MailCollectionView = "game/mail/view/MailCollectionView"
mail.MailCollectionItem = require('game/mail/view/item/MailCollectionItem')

local _c = require('game/mail/controller/MailController').new(mail.MailManager)
local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
