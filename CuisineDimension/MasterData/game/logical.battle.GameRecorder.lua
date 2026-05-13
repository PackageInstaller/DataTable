local GameRecorder = class("GameRecorder")

function GameRecorder:ctor(params)
  params = params or {}
  self.random_gens = {}
  for index, name in ipairs(BattleSeedIndies) do
    self.random_gens[name] = random.new()
  end
end

function GameRecorder:setBattle(battle)
  self.battle = battle
end

function GameRecorder:initRandomSeeds(seeds)
  seeds = seeds or {}
  for name, random_gen in pairs(self.random_gens) do
    random_gen:seed(seeds[name] or os.time())
  end
end

return GameRecorder
