LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1130/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1601721/cfg_skill_view_3201721.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �B �� � �B� +A�K��� �� � A�  �B  �B � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               } PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID =1601721,waitTime =2000; ��       PlayAudio,audioID = 2542,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =160172107; Wait,waitTime=1300; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=300; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterAnimation,animName = AtkUlt1; PlayCasterBindEffect,effectID =160172108; �      � DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=0; PlayGridEffectByRandom,effectID=160172110,intervalTime=100,randomCount=3; � DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=100; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV