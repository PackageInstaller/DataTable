LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2904101/cfg_skill_view_29041011.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �'       PlayAudio,audioID = 6251,audioType=1; PlayCasterAnimation,animName=Skill01Start; PlayCasterBindEffect,effectID=290410101; PlayCasterBindEffect,effectID=290410102; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role; Wait,waitTime=300; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayCasterHUDVisible,visible=0; Wait,waitTime=500; PlayCasterTurnToPlayer; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterAnimation,animName=Skill01Trans; PlayCasterBindEffect,effectID=290410103; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role01; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29041011; Wait,waitTime=1000;  Wait,waitTime=500;         %                                                                                                                     key   %   config    %      _ENV