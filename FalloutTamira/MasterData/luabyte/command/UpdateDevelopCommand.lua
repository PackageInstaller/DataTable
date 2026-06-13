local UpdateDevelopCommand = BaseClass("UpdateDevelopCommand", BaseCommand)
local M = UpdateDevelopCommand

function M:Execute(heroIds)
    for i=0, heroIds.Count-1 do
        DevelopMgr:GetInstance():AddNewHeroId(heroIds[i])
    end
end

return UpdateDevelopCommand
