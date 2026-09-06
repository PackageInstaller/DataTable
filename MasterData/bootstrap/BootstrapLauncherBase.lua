-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/bootstrap/BootstrapLauncherBase.lua

module("bootstrap.BootstrapLauncherBase", package.seeall)

local BootstrapLauncherBase = class("BootstrapLauncherBase")

function BootstrapLauncherBase:ctor()
	return
end

function BootstrapLauncherBase:startHotUpdate()
	self:onHotupdateDone()
end

local canUse64Path = Framework.OSDef.RunOS == Framework.OSDef.Android and checknumber(BootstrapUtil.getGameVersionCode()) >= 210

if canUse64Path then
	if Framework.OSDef.is64Cpu then
		local var_0_0 = Framework.FileUtils.LuaBundleRootDir_64

		if not Framework.FileUtils.LuaBundleRootDir_64 then
			var_0_0 = Framework.FileUtils.LuaBundleRootDir_32

			if not Framework.FileUtils.LuaBundleRootDir_32 then
				local forCpuDir = Framework.FileUtils.LuaBundleRootDir

				function BootstrapLauncherBase:loadLuaBundles()
					forcePrint(LogTag.BOOTSTRAP, "BootstrapLauncherBase loadLuaBundles", tostring(canUse64Path), forCpuDir)

					self._luaBundles = {
						forCpuDir .. "/framework",
						forCpuDir .. "/frameworkext",
						forCpuDir .. "/logic"
					}
					self._luaBundlesCount = #self._luaBundles
					self._luaBundlesLoaded = 0
					self._luaBundlesSucc = 0

					for i = 1, self._luaBundlesCount do
						getres(self._luaBundles[i], self._onLuaBundleLoaded, self, nil, true)
					end
				end

				function BootstrapLauncherBase:_onLuaBundleLoaded(res)
					forcePrint(LogTag.BOOTSTRAP, "BootstrapLauncherBase _onLuaBundleLoaded", res.ResPath, res.IsSuccess)

					if res.IsSuccess then
						self._luaBundlesSucc = self._luaBundlesSucc + 1

						local abName = string.sub(res.ResPath, string.len(forCpuDir .. "/") + 1)

						res:Retain()
						rescache:AddLuaBundle(abName, res.assetBundle)
						res:Retain()
					end

					self._luaBundlesLoaded = self._luaBundlesLoaded + 1

					if self._luaBundlesLoaded >= self._luaBundlesCount and self._luaBundlesSucc == self._luaBundlesLoaded then
						self:onLuaBundlesDone()
					end
				end

				function BootstrapLauncherBase:importFrameworkLua()
					usingnow("framework.import_framework")
				end

				function BootstrapLauncherBase:importLogicLua()
					usingnow("logic.setting.import_frameworkext")
					usingnow("logic.setting.modulepath_logic")
					usingnow("logic.setting.import_logic")
					usingnow("logic.setting.import_proto")
					usingnow("logic.LogicLauncher", "LogicLauncher")
				end

				function BootstrapLauncherBase:getHotUpdateAppCode()
					return "appCode"
				end

				function BootstrapLauncherBase:onHotupdateDone()
					forcePrint(LogTag.BOOTSTRAP, "BootstrapLauncherBase onHotupdateDone")

					if rescache.isLuaBundle then
						self:loadLuaBundles()
					else
						self:onLuaBundlesDone()
					end
				end

				function BootstrapLauncherBase:onLuaBundlesDone()
					forcePrint(LogTag.BOOTSTRAP, "BootstrapLauncherBase onLuaBundlesDone")
					self:importFrameworkLua(true)
					self:importLogicLua()
				end

				function BootstrapLauncherBase:start()
					forcePrint(LogTag.BOOTSTRAP, "BootstrapLauncherBase start")

					if rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
						self:onLuaBundlesDone()
					elseif rescache.resLoadMode == Framework.ResourceLoadMode.AssetBundle then
						forcePrint(LogTag.BOOTSTRAP, "BootstrapLauncherBase startHotUpdate")
						self:startHotUpdate()
					else
						self:onHotupdateDone()
					end
				end

				return BootstrapLauncherBase
			end
		end
	end
end
