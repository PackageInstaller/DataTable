LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2909901/cfg_skill_view_29099013.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       PlayCasterAnimation,animName = Skill03; PlayCasterBindEffect,effectID=290990109; PlayCasterMaterialAnim,animName=eff_2909901_skill03_out; Wait,waitTime=1000; PlayAudio,audioID=29099017,audioType=1; Wait,waitTime=400; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterTurnToPlayer; PlayCasterMaterialAnim,animName=eff_2909901_skill03_in; PlayCasterBindEffect,effectID=290990110; �      w DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=291010104,turnToTarget=1,deathClear=0; �      � DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=1000;         0                                                                                                                                                      key   0   config+   0      _ENV