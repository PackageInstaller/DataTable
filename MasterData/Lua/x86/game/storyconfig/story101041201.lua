return {
	Play104121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104121001
		arg_1_1.duration_ = 4.53

		local var_1_0 = {
			ja = 4.53266666666667,
			ko = 4.06666666666667,
			zh = 3.29966666666667,
			en = 3.76666666666667
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_4 = "B04f"

			if arg_1_1.bgs_.B04f == nil then
				local var_4_5 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_4)
				var_4_5.name = var_4_4
				var_4_5.transform.parent = arg_1_1.stage_.transform
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_4] = var_4_5
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_6 = arg_1_1.bgs_.B04f:GetComponent("SpriteRenderer")

				if var_4_6 then
					arg_1_1.var_.alphaOldValueB04f = var_4_6.color.a
					arg_1_1.var_.alphaMatValueB04f = var_4_6
				end

				arg_1_1.var_.alphaOldValueB04f = 0
			end

			local var_4_7 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_7 then
				if arg_1_1.var_.alphaMatValueB04f then
					arg_1_1.var_.alphaMatValueB04f.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB04f, 1, (arg_1_1.time_ - 0) / var_4_7)
					arg_1_1.var_.alphaMatValueB04f.color = arg_1_1.var_.alphaMatValueB04f.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_7 and arg_1_1.time_ < 0 + var_4_7 + arg_4_0 and arg_1_1.var_.alphaMatValueB04f then
				arg_1_1.var_.alphaMatValueB04f.color.a = 1
				arg_1_1.var_.alphaMatValueB04f.color = arg_1_1.var_.alphaMatValueB04f.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_8 = arg_1_1.bgs_.B04f

				arg_1_1.bgs_.B04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_9 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_9 and var_4_9.sprite then
					local var_4_10 = 2 * (var_4_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_8.transform.localScale = Vector3.New(var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B04f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_11 + 1.66666666666667 and arg_1_1.time_ < var_4_11 + 1.66666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_12 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_13 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_13.name = var_4_12
				var_4_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_12] = var_4_13

				local var_4_14 = var_4_13:GetComponentInChildren(typeof(CharacterEffect))

				var_4_14.enabled = true

				local var_4_15 = GameObjectTools.GetOrAddComponent(var_4_13, typeof(DynamicBoneHelper))

				if var_4_15 then
					var_4_15:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_14.transform, false)

				arg_1_1.var_[var_4_12 .. "Animator"] = var_4_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_12 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_12 .. "LipSync"] = var_4_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 1.66666666666667
			local var_4_17 = 0.175

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(104121001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 7 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 7)

				if (7 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 7)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121001", "story_v_out_104121.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_104121", "104121001", "story_v_out_104121.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_104121", "104121001", "story_v_out_104121.awb")

						arg_1_1:RecordAudio("104121001", var_4_24)
						arg_1_1:RecordAudio("104121001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104121", "104121001", "story_v_out_104121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104121", "104121001", "story_v_out_104121.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104121002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104121002
		arg_8_1.duration_ = 3.43

		local var_8_0 = {
			ja = 3.433,
			ko = 2.366,
			zh = 2.333,
			en = 1.666
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play104121003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1019ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1019ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1019ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1019ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_11_3 = 0
			local var_11_4 = 0.2

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_3 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_5 = arg_8_1:GetWordFromCfg(104121002)
				local var_11_6 = arg_8_1:FormatText(var_11_5.content)

				arg_8_1.text_.text = var_11_6

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_8 = 8 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_6) / 8)

				if (8 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_6) / 8)) > 0 and var_11_4 < var_11_8 then
					arg_8_1.talkMaxDuration = var_11_8

					if var_11_8 + var_11_3 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_3
					end
				end

				arg_8_1.text_.text = var_11_6
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121002", "story_v_out_104121.awb") ~= 0 then
					local var_11_9 = manager.audio:GetVoiceLength("story_v_out_104121", "104121002", "story_v_out_104121.awb") / 1000

					if var_11_9 + var_11_3 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_9 + var_11_3
					end

					if var_11_5.prefab_name ~= "" and arg_8_1.actors_[var_11_5.prefab_name] ~= nil then
						local var_11_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_5.prefab_name].transform, "story_v_out_104121", "104121002", "story_v_out_104121.awb")

						arg_8_1:RecordAudio("104121002", var_11_10)
						arg_8_1:RecordAudio("104121002", var_11_10)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104121", "104121002", "story_v_out_104121.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104121", "104121002", "story_v_out_104121.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_11 = math.max(var_11_4, arg_8_1.talkMaxDuration)

			if var_11_3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_3 + var_11_11 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_3) / var_11_11

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_3 + var_11_11 and arg_8_1.time_ < var_11_3 + var_11_11 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play104121003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104121003
		arg_12_1.duration_ = 3.37

		local var_12_0 = {
			ja = 3.366,
			ko = 2.866,
			zh = 2.5,
			en = 2.366
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play104121004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1011ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1011ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1011ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1011ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_15_3 = 0
			local var_15_4 = 0.175

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_3 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_5 = arg_12_1:GetWordFromCfg(104121003)
				local var_15_6 = arg_12_1:FormatText(var_15_5.content)

				arg_12_1.text_.text = var_15_6

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_8 = 7 <= 0 and var_15_4 or var_15_4 * (utf8.len(var_15_6) / 7)

				if (7 <= 0 and var_15_4 or var_15_4 * (utf8.len(var_15_6) / 7)) > 0 and var_15_4 < var_15_8 then
					arg_12_1.talkMaxDuration = var_15_8

					if var_15_8 + var_15_3 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_3
					end
				end

				arg_12_1.text_.text = var_15_6
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121003", "story_v_out_104121.awb") ~= 0 then
					local var_15_9 = manager.audio:GetVoiceLength("story_v_out_104121", "104121003", "story_v_out_104121.awb") / 1000

					if var_15_9 + var_15_3 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_3
					end

					if var_15_5.prefab_name ~= "" and arg_12_1.actors_[var_15_5.prefab_name] ~= nil then
						local var_15_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_5.prefab_name].transform, "story_v_out_104121", "104121003", "story_v_out_104121.awb")

						arg_12_1:RecordAudio("104121003", var_15_10)
						arg_12_1:RecordAudio("104121003", var_15_10)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104121", "104121003", "story_v_out_104121.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104121", "104121003", "story_v_out_104121.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_11 = math.max(var_15_4, arg_12_1.talkMaxDuration)

			if var_15_3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_3 + var_15_11 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_3) / var_15_11

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_3 + var_15_11 and arg_12_1.time_ < var_15_3 + var_15_11 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play104121004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104121004
		arg_16_1.duration_ = 5.5

		local var_16_0 = {
			ja = 4.233,
			ko = 3.3,
			zh = 3.666,
			en = 5.5
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play104121005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1036ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1036ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1036ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1036ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1036ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1036ui_story == nil then
				arg_16_1.var_.characterEffect1036ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1036ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1036ui_story then
				arg_16_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["1036ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1036ui_story = var_19_6.localPosition
			end

			local var_19_7 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				var_19_6.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_16_1.time_ - 0) / var_19_7)
				var_19_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_6.position).x, (manager.ui.mainCamera.transform.position - var_19_6.position).y, (manager.ui.mainCamera.transform.position - var_19_6.position).z)
				var_19_6.localEulerAngles.z = 0
				var_19_6.localEulerAngles.x = 0
				var_19_6.localEulerAngles = var_19_6.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				var_19_6.localPosition = Vector3.New(0, -1.09, -5.78)
				var_19_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_6.position).x, (manager.ui.mainCamera.transform.position - var_19_6.position).y, (manager.ui.mainCamera.transform.position - var_19_6.position).z)
				var_19_6.localEulerAngles.z = 0
				var_19_6.localEulerAngles.x = 0
				var_19_6.localEulerAngles = var_19_6.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action6_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_19_8 = 0
			local var_19_9 = 0.325

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(104121004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 13 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 13)

				if (13 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 13)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121004", "story_v_out_104121.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_104121", "104121004", "story_v_out_104121.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_out_104121", "104121004", "story_v_out_104121.awb")

						arg_16_1:RecordAudio("104121004", var_19_15)
						arg_16_1:RecordAudio("104121004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104121", "104121004", "story_v_out_104121.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104121", "104121004", "story_v_out_104121.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104121005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104121005
		arg_20_1.duration_ = 5.33

		local var_20_0 = {
			ja = 3.9,
			ko = 5.333,
			zh = 4.4,
			en = 4.833
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play104121006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_23_0 = 0
			local var_23_1 = 0.375

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(104121005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 15 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 15)

				if (15 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 15)) > 0 and var_23_1 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121005", "story_v_out_104121.awb") ~= 0 then
					local var_23_6 = manager.audio:GetVoiceLength("story_v_out_104121", "104121005", "story_v_out_104121.awb") / 1000

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end

					if var_23_2.prefab_name ~= "" and arg_20_1.actors_[var_23_2.prefab_name] ~= nil then
						local var_23_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_2.prefab_name].transform, "story_v_out_104121", "104121005", "story_v_out_104121.awb")

						arg_20_1:RecordAudio("104121005", var_23_7)
						arg_20_1:RecordAudio("104121005", var_23_7)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104121", "104121005", "story_v_out_104121.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104121", "104121005", "story_v_out_104121.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play104121006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104121006
		arg_24_1.duration_ = 8.63

		local var_24_0 = {
			ja = 6.266,
			ko = 8.633,
			zh = 5.4,
			en = 6.4
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play104121007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["10001_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10001_tpose"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_24_1.stage_.transform)

				var_27_0.name = "10001_tpose"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["10001_tpose"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["10001_tpose" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["10001_tpose" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["10001_tpose" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["10001_tpose"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect10001_tpose == nil then
				arg_24_1.var_.characterEffect10001_tpose = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect10001_tpose and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect10001_tpose then
				arg_24_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_27_6 = arg_24_1.actors_["1036ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_6) and arg_24_1.var_.characterEffect1036ui_story == nil then
				arg_24_1.var_.characterEffect1036ui_story = var_27_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 and not isNil(var_27_6) then
				if arg_24_1.var_.characterEffect1036ui_story and not isNil(var_27_6) then
					arg_24_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_7)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 and not isNil(var_27_6) and arg_24_1.var_.characterEffect1036ui_story then
				arg_24_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_27_8 = arg_24_1.actors_["1036ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1036ui_story = var_27_8.localPosition
			end

			local var_27_9 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_9)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0, 100, 0)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			local var_27_10 = arg_24_1.actors_["10001_tpose"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10001_tpose = var_27_10.localPosition

				local var_27_11 = GameObjectTools.GetOrAddComponent(var_27_10.gameObject, typeof(DynamicBoneHelper))

				if var_27_11 then
					var_27_11:EnableDynamicBone(false)
				end
			end

			local var_27_12 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_12 then
				var_27_10.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10001_tpose, Vector3.New(0, -1.23, -5.8), (arg_24_1.time_ - 0) / var_27_12)
				var_27_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_10.position).x, (manager.ui.mainCamera.transform.position - var_27_10.position).y, (manager.ui.mainCamera.transform.position - var_27_10.position).z)
				var_27_10.localEulerAngles.z = 0
				var_27_10.localEulerAngles.x = 0
				var_27_10.localEulerAngles = var_27_10.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_12 and arg_24_1.time_ < 0 + var_27_12 + arg_27_0 then
				var_27_10.localPosition = Vector3.New(0, -1.23, -5.8)
				var_27_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_10.position).x, (manager.ui.mainCamera.transform.position - var_27_10.position).y, (manager.ui.mainCamera.transform.position - var_27_10.position).z)
				var_27_10.localEulerAngles.z = 0
				var_27_10.localEulerAngles.x = 0
				var_27_10.localEulerAngles = var_27_10.localEulerAngles

				local var_27_13 = GameObjectTools.GetOrAddComponent(var_27_10.gameObject, typeof(DynamicBoneHelper))

				if var_27_13 then
					var_27_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_27_14 = 0
			local var_27_15 = 0.425

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_16 = arg_24_1:GetWordFromCfg(104121006)
				local var_27_17 = arg_24_1:FormatText(var_27_16.content)

				arg_24_1.text_.text = var_27_17

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_19 = 16 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 16)

				if (16 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 16)) > 0 and var_27_15 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_14
					end
				end

				arg_24_1.text_.text = var_27_17
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121006", "story_v_out_104121.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_104121", "104121006", "story_v_out_104121.awb") / 1000

					if var_27_20 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_14
					end

					if var_27_16.prefab_name ~= "" and arg_24_1.actors_[var_27_16.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_16.prefab_name].transform, "story_v_out_104121", "104121006", "story_v_out_104121.awb")

						arg_24_1:RecordAudio("104121006", var_27_21)
						arg_24_1:RecordAudio("104121006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104121", "104121006", "story_v_out_104121.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104121", "104121006", "story_v_out_104121.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_15, arg_24_1.talkMaxDuration)

			if var_27_14 <= arg_24_1.time_ and arg_24_1.time_ < var_27_14 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_14) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_14 + var_27_22 and arg_24_1.time_ < var_27_14 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play104121007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104121007
		arg_28_1.duration_ = 6.13

		local var_28_0 = {
			ja = 3.266,
			ko = 3.833,
			zh = 4.266,
			en = 6.133
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play104121008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = arg_28_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) then
				if arg_28_1.var_.characterEffect1019ui_story and not isNil(arg_28_1.actors_["1019ui_story"]) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["10001_tpose"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect10001_tpose == nil then
				arg_28_1.var_.characterEffect10001_tpose = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect10001_tpose and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_28_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect10001_tpose then
				arg_28_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_28_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_31_4 = arg_28_1.actors_["10001_tpose"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos10001_tpose = var_31_4.localPosition

				local var_31_5 = GameObjectTools.GetOrAddComponent(var_31_4.gameObject, typeof(DynamicBoneHelper))

				if var_31_5 then
					var_31_5:EnableDynamicBone(false)
				end
			end

			local var_31_6 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_6 then
				var_31_4.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_6)
				var_31_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_4.position).x, (manager.ui.mainCamera.transform.position - var_31_4.position).y, (manager.ui.mainCamera.transform.position - var_31_4.position).z)
				var_31_4.localEulerAngles.z = 0
				var_31_4.localEulerAngles.x = 0
				var_31_4.localEulerAngles = var_31_4.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_6 and arg_28_1.time_ < 0 + var_31_6 + arg_31_0 then
				var_31_4.localPosition = Vector3.New(0, 100, 0)
				var_31_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_4.position).x, (manager.ui.mainCamera.transform.position - var_31_4.position).y, (manager.ui.mainCamera.transform.position - var_31_4.position).z)
				var_31_4.localEulerAngles.z = 0
				var_31_4.localEulerAngles.x = 0
				var_31_4.localEulerAngles = var_31_4.localEulerAngles

				local var_31_7 = GameObjectTools.GetOrAddComponent(var_31_4.gameObject, typeof(DynamicBoneHelper))

				if var_31_7 then
					var_31_7:EnableDynamicBone(true)
				end
			end

			local var_31_8 = arg_28_1.actors_["1019ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_8.localPosition
			end

			local var_31_9 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_9 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_28_1.time_ - 0) / var_31_9)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_9 and arg_28_1.time_ < 0 + var_31_9 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_31_10 = 0
			local var_31_11 = 0.4

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(104121007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 16 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 16)

				if (16 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 16)) > 0 and var_31_11 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121007", "story_v_out_104121.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_104121", "104121007", "story_v_out_104121.awb") / 1000

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_104121", "104121007", "story_v_out_104121.awb")

						arg_28_1:RecordAudio("104121007", var_31_17)
						arg_28_1:RecordAudio("104121007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104121", "104121007", "story_v_out_104121.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104121", "104121007", "story_v_out_104121.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_18 and arg_28_1.time_ < var_31_10 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play104121008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104121008
		arg_32_1.duration_ = 11.6

		local var_32_0 = {
			ja = 11.6,
			ko = 9.3,
			zh = 6.7,
			en = 8.533
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play104121009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10001_tpose"]) and arg_32_1.var_.characterEffect10001_tpose == nil then
				arg_32_1.var_.characterEffect10001_tpose = arg_32_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10001_tpose"]) then
				if arg_32_1.var_.characterEffect10001_tpose and not isNil(arg_32_1.actors_["10001_tpose"]) then
					arg_32_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10001_tpose"]) and arg_32_1.var_.characterEffect10001_tpose then
				arg_32_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["1019ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1019ui_story then
				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_35_4 = arg_32_1.actors_["1019ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_4.localPosition
			end

			local var_35_5 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_5 then
				var_35_4.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_32_1.time_ - 0) / var_35_5)
				var_35_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_4.position).x, (manager.ui.mainCamera.transform.position - var_35_4.position).y, (manager.ui.mainCamera.transform.position - var_35_4.position).z)
				var_35_4.localEulerAngles.z = 0
				var_35_4.localEulerAngles.x = 0
				var_35_4.localEulerAngles = var_35_4.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_5 and arg_32_1.time_ < 0 + var_35_5 + arg_35_0 then
				var_35_4.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_35_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_4.position).x, (manager.ui.mainCamera.transform.position - var_35_4.position).y, (manager.ui.mainCamera.transform.position - var_35_4.position).z)
				var_35_4.localEulerAngles.z = 0
				var_35_4.localEulerAngles.x = 0
				var_35_4.localEulerAngles = var_35_4.localEulerAngles
			end

			local var_35_6 = arg_32_1.actors_["1019ui_story"].transform

			if 0.033 < arg_32_1.time_ and arg_32_1.time_ <= 0.033 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_6.localPosition
			end

			local var_35_7 = 0.5

			if 0.033 <= arg_32_1.time_ and arg_32_1.time_ < 0.033 + var_35_7 then
				var_35_6.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_32_1.time_ - 0.033) / var_35_7)
				var_35_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_6.position).x, (manager.ui.mainCamera.transform.position - var_35_6.position).y, (manager.ui.mainCamera.transform.position - var_35_6.position).z)
				var_35_6.localEulerAngles.z = 0
				var_35_6.localEulerAngles.x = 0
				var_35_6.localEulerAngles = var_35_6.localEulerAngles
			end

			if arg_32_1.time_ >= 0.033 + var_35_7 and arg_32_1.time_ < 0.033 + var_35_7 + arg_35_0 then
				var_35_6.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_35_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_6.position).x, (manager.ui.mainCamera.transform.position - var_35_6.position).y, (manager.ui.mainCamera.transform.position - var_35_6.position).z)
				var_35_6.localEulerAngles.z = 0
				var_35_6.localEulerAngles.x = 0
				var_35_6.localEulerAngles = var_35_6.localEulerAngles
			end

			local var_35_8 = arg_32_1.actors_["10001_tpose"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10001_tpose = var_35_8.localPosition

				local var_35_9 = GameObjectTools.GetOrAddComponent(var_35_8.gameObject, typeof(DynamicBoneHelper))

				if var_35_9 then
					var_35_9:EnableDynamicBone(false)
				end
			end

			local var_35_10 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_10 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10001_tpose, Vector3.New(0.7, -1.23, -5.8), (arg_32_1.time_ - 0) / var_35_10)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_10 and arg_32_1.time_ < 0 + var_35_10 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0.7, -1.23, -5.8)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles

				local var_35_11 = GameObjectTools.GetOrAddComponent(var_35_8.gameObject, typeof(DynamicBoneHelper))

				if var_35_11 then
					var_35_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_35_12 = 0
			local var_35_13 = 0.9

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(104121008)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 35 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 35)

				if (35 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 35)) > 0 and var_35_13 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121008", "story_v_out_104121.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_104121", "104121008", "story_v_out_104121.awb") / 1000

					if var_35_18 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_12
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_104121", "104121008", "story_v_out_104121.awb")

						arg_32_1:RecordAudio("104121008", var_35_19)
						arg_32_1:RecordAudio("104121008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104121", "104121008", "story_v_out_104121.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104121", "104121008", "story_v_out_104121.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_20 and arg_32_1.time_ < var_35_12 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play104121009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104121009
		arg_36_1.duration_ = 2.7

		local var_36_0 = {
			ja = 1.999999999999,
			ko = 2.7,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play104121010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1036ui_story"]) and arg_36_1.var_.characterEffect1036ui_story == nil then
				arg_36_1.var_.characterEffect1036ui_story = arg_36_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1036ui_story"]) then
				if arg_36_1.var_.characterEffect1036ui_story and not isNil(arg_36_1.actors_["1036ui_story"]) then
					arg_36_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1036ui_story"]) and arg_36_1.var_.characterEffect1036ui_story then
				arg_36_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["10001_tpose"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect10001_tpose == nil then
				arg_36_1.var_.characterEffect10001_tpose = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect10001_tpose and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_36_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect10001_tpose then
				arg_36_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_36_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_39_4 = arg_36_1.actors_["1019ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_4.localPosition
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_4.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_5)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_4.localPosition = Vector3.New(0, 100, 0)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			local var_39_6 = arg_36_1.actors_["1036ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1036ui_story = var_39_6.localPosition
			end

			local var_39_7 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1036ui_story, Vector3.New(-0.7, -1.09, -5.78), (arg_36_1.time_ - 0) / var_39_7)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(-0.7, -1.09, -5.78)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_39_8 = 0
			local var_39_9 = 0.15

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:GetWordFromCfg(104121009)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_13 = 6 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 6)

				if (6 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 6)) > 0 and var_39_9 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121009", "story_v_out_104121.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_104121", "104121009", "story_v_out_104121.awb") / 1000

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end

					if var_39_10.prefab_name ~= "" and arg_36_1.actors_[var_39_10.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_10.prefab_name].transform, "story_v_out_104121", "104121009", "story_v_out_104121.awb")

						arg_36_1:RecordAudio("104121009", var_39_15)
						arg_36_1:RecordAudio("104121009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104121", "104121009", "story_v_out_104121.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104121", "104121009", "story_v_out_104121.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_16 and arg_36_1.time_ < var_39_8 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play104121010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104121010
		arg_40_1.duration_ = 11.73

		local var_40_0 = {
			ja = 11.6,
			ko = 11.133,
			zh = 11.733,
			en = 11.466
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play104121011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10001_tpose"]) and arg_40_1.var_.characterEffect10001_tpose == nil then
				arg_40_1.var_.characterEffect10001_tpose = arg_40_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10001_tpose"]) then
				if arg_40_1.var_.characterEffect10001_tpose and not isNil(arg_40_1.actors_["10001_tpose"]) then
					arg_40_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10001_tpose"]) and arg_40_1.var_.characterEffect10001_tpose then
				arg_40_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1036ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1036ui_story == nil then
				arg_40_1.var_.characterEffect1036ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1036ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1036ui_story then
				arg_40_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action454")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_43_4 = 0
			local var_43_5 = 1.525

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(104121010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 61 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 61)

				if (61 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 61)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121010", "story_v_out_104121.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_104121", "104121010", "story_v_out_104121.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_104121", "104121010", "story_v_out_104121.awb")

						arg_40_1:RecordAudio("104121010", var_43_11)
						arg_40_1:RecordAudio("104121010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104121", "104121010", "story_v_out_104121.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104121", "104121010", "story_v_out_104121.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play104121011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104121011
		arg_44_1.duration_ = 4.9

		local var_44_0 = {
			ja = 4.9,
			ko = 4,
			zh = 3.1,
			en = 2.966
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play104121012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = arg_44_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(arg_44_1.actors_["1084ui_story"]) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["10001_tpose"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect10001_tpose == nil then
				arg_44_1.var_.characterEffect10001_tpose = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect10001_tpose and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_44_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect10001_tpose then
				arg_44_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_44_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_47_4 = arg_44_1.actors_["10001_tpose"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos10001_tpose = var_47_4.localPosition

				local var_47_5 = GameObjectTools.GetOrAddComponent(var_47_4.gameObject, typeof(DynamicBoneHelper))

				if var_47_5 then
					var_47_5:EnableDynamicBone(false)
				end
			end

			local var_47_6 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_6 then
				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_6)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_6 and arg_44_1.time_ < 0 + var_47_6 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0, 100, 0)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles

				local var_47_7 = GameObjectTools.GetOrAddComponent(var_47_4.gameObject, typeof(DynamicBoneHelper))

				if var_47_7 then
					var_47_7:EnableDynamicBone(true)
				end
			end

			local var_47_8 = arg_44_1.actors_["1036ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1036ui_story = var_47_8.localPosition
			end

			local var_47_9 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_9 then
				var_47_8.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_9)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_9 and arg_44_1.time_ < 0 + var_47_9 + arg_47_0 then
				var_47_8.localPosition = Vector3.New(0, 100, 0)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			local var_47_10 = arg_44_1.actors_["1084ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_10.localPosition
			end

			local var_47_11 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_11 then
				var_47_10.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_44_1.time_ - 0) / var_47_11)
				var_47_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_10.position).x, (manager.ui.mainCamera.transform.position - var_47_10.position).y, (manager.ui.mainCamera.transform.position - var_47_10.position).z)
				var_47_10.localEulerAngles.z = 0
				var_47_10.localEulerAngles.x = 0
				var_47_10.localEulerAngles = var_47_10.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_11 and arg_44_1.time_ < 0 + var_47_11 + arg_47_0 then
				var_47_10.localPosition = Vector3.New(0, -0.97, -6)
				var_47_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_10.position).x, (manager.ui.mainCamera.transform.position - var_47_10.position).y, (manager.ui.mainCamera.transform.position - var_47_10.position).z)
				var_47_10.localEulerAngles.z = 0
				var_47_10.localEulerAngles.x = 0
				var_47_10.localEulerAngles = var_47_10.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_47_12 = 0
			local var_47_13 = 0.45

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:GetWordFromCfg(104121011)
				local var_47_15 = arg_44_1:FormatText(var_47_14.content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 18 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 18)

				if (18 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 18)) > 0 and var_47_13 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17

					if var_47_17 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121011", "story_v_out_104121.awb") ~= 0 then
					local var_47_18 = manager.audio:GetVoiceLength("story_v_out_104121", "104121011", "story_v_out_104121.awb") / 1000

					if var_47_18 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_12
					end

					if var_47_14.prefab_name ~= "" and arg_44_1.actors_[var_47_14.prefab_name] ~= nil then
						local var_47_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_14.prefab_name].transform, "story_v_out_104121", "104121011", "story_v_out_104121.awb")

						arg_44_1:RecordAudio("104121011", var_47_19)
						arg_44_1:RecordAudio("104121011", var_47_19)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104121", "104121011", "story_v_out_104121.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104121", "104121011", "story_v_out_104121.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_20 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_20 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_20

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_20 and arg_44_1.time_ < var_47_12 + var_47_20 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play104121012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104121012
		arg_48_1.duration_ = 15.27

		local var_48_0 = {
			ja = 15.266,
			ko = 11.533,
			zh = 11.633,
			en = 15.1
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play104121013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10001_tpose"]) and arg_48_1.var_.characterEffect10001_tpose == nil then
				arg_48_1.var_.characterEffect10001_tpose = arg_48_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10001_tpose"]) then
				if arg_48_1.var_.characterEffect10001_tpose and not isNil(arg_48_1.actors_["10001_tpose"]) then
					arg_48_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10001_tpose"]) and arg_48_1.var_.characterEffect10001_tpose then
				arg_48_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1084ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_51_4 = arg_48_1.actors_["1084ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_4.localPosition
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_5)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(0, 100, 0)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			local var_51_6 = arg_48_1.actors_["10001_tpose"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10001_tpose = var_51_6.localPosition

				local var_51_7 = GameObjectTools.GetOrAddComponent(var_51_6.gameObject, typeof(DynamicBoneHelper))

				if var_51_7 then
					var_51_7:EnableDynamicBone(false)
				end
			end

			local var_51_8 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_8 then
				var_51_6.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10001_tpose, Vector3.New(-0.7, -1.23, -5.8), (arg_48_1.time_ - 0) / var_51_8)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_8 and arg_48_1.time_ < 0 + var_51_8 + arg_51_0 then
				var_51_6.localPosition = Vector3.New(-0.7, -1.23, -5.8)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles

				local var_51_9 = GameObjectTools.GetOrAddComponent(var_51_6.gameObject, typeof(DynamicBoneHelper))

				if var_51_9 then
					var_51_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_51_10 = 0
			local var_51_11 = 1.525

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_12 = arg_48_1:GetWordFromCfg(104121012)
				local var_51_13 = arg_48_1:FormatText(var_51_12.content)

				arg_48_1.text_.text = var_51_13

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 61 <= 0 and var_51_11 or var_51_11 * (utf8.len(var_51_13) / 61)

				if (61 <= 0 and var_51_11 or var_51_11 * (utf8.len(var_51_13) / 61)) > 0 and var_51_11 < var_51_15 then
					arg_48_1.talkMaxDuration = var_51_15

					if var_51_15 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_15 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_13
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121012", "story_v_out_104121.awb") ~= 0 then
					local var_51_16 = manager.audio:GetVoiceLength("story_v_out_104121", "104121012", "story_v_out_104121.awb") / 1000

					if var_51_16 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_16 + var_51_10
					end

					if var_51_12.prefab_name ~= "" and arg_48_1.actors_[var_51_12.prefab_name] ~= nil then
						local var_51_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_12.prefab_name].transform, "story_v_out_104121", "104121012", "story_v_out_104121.awb")

						arg_48_1:RecordAudio("104121012", var_51_17)
						arg_48_1:RecordAudio("104121012", var_51_17)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104121", "104121012", "story_v_out_104121.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104121", "104121012", "story_v_out_104121.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_18 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_18 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_18

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_18 and arg_48_1.time_ < var_51_10 + var_51_18 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play104121013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104121013
		arg_52_1.duration_ = 4.6

		local var_52_0 = {
			ja = 4.6,
			ko = 2.866,
			zh = 2.5,
			en = 3.433
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play104121014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1036ui_story"]) and arg_52_1.var_.characterEffect1036ui_story == nil then
				arg_52_1.var_.characterEffect1036ui_story = arg_52_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1036ui_story"]) then
				if arg_52_1.var_.characterEffect1036ui_story and not isNil(arg_52_1.actors_["1036ui_story"]) then
					arg_52_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1036ui_story"]) and arg_52_1.var_.characterEffect1036ui_story then
				arg_52_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["10001_tpose"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect10001_tpose == nil then
				arg_52_1.var_.characterEffect10001_tpose = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect10001_tpose and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_52_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect10001_tpose then
				arg_52_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_52_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_55_4 = arg_52_1.actors_["1036ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1036ui_story = var_55_4.localPosition
			end

			local var_55_5 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_5 then
				var_55_4.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1036ui_story, Vector3.New(0.7, -1.09, -5.78), (arg_52_1.time_ - 0) / var_55_5)
				var_55_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_4.position).x, (manager.ui.mainCamera.transform.position - var_55_4.position).y, (manager.ui.mainCamera.transform.position - var_55_4.position).z)
				var_55_4.localEulerAngles.z = 0
				var_55_4.localEulerAngles.x = 0
				var_55_4.localEulerAngles = var_55_4.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_5 and arg_52_1.time_ < 0 + var_55_5 + arg_55_0 then
				var_55_4.localPosition = Vector3.New(0.7, -1.09, -5.78)
				var_55_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_4.position).x, (manager.ui.mainCamera.transform.position - var_55_4.position).y, (manager.ui.mainCamera.transform.position - var_55_4.position).z)
				var_55_4.localEulerAngles.z = 0
				var_55_4.localEulerAngles.x = 0
				var_55_4.localEulerAngles = var_55_4.localEulerAngles
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_55_6 = 0
			local var_55_7 = 0.225

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_8 = arg_52_1:GetWordFromCfg(104121013)
				local var_55_9 = arg_52_1:FormatText(var_55_8.content)

				arg_52_1.text_.text = var_55_9

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 9 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_9) / 9)

				if (9 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_9) / 9)) > 0 and var_55_7 < var_55_11 then
					arg_52_1.talkMaxDuration = var_55_11

					if var_55_11 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_9
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121013", "story_v_out_104121.awb") ~= 0 then
					local var_55_12 = manager.audio:GetVoiceLength("story_v_out_104121", "104121013", "story_v_out_104121.awb") / 1000

					if var_55_12 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_6
					end

					if var_55_8.prefab_name ~= "" and arg_52_1.actors_[var_55_8.prefab_name] ~= nil then
						local var_55_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_8.prefab_name].transform, "story_v_out_104121", "104121013", "story_v_out_104121.awb")

						arg_52_1:RecordAudio("104121013", var_55_13)
						arg_52_1:RecordAudio("104121013", var_55_13)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104121", "104121013", "story_v_out_104121.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104121", "104121013", "story_v_out_104121.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play104121014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104121014
		arg_56_1.duration_ = 6.23

		local var_56_0 = {
			ja = 5,
			ko = 3.433,
			zh = 6.233,
			en = 4.9
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104121015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1036ui_story"]) and arg_56_1.var_.characterEffect1036ui_story == nil then
				arg_56_1.var_.characterEffect1036ui_story = arg_56_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1036ui_story"]) then
				if arg_56_1.var_.characterEffect1036ui_story and not isNil(arg_56_1.actors_["1036ui_story"]) then
					arg_56_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1036ui_story"]) and arg_56_1.var_.characterEffect1036ui_story then
				arg_56_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_59_1 = arg_56_1.actors_["1036ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1036ui_story = var_59_1.localPosition
			end

			local var_59_2 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 then
				var_59_1.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_2)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 then
				var_59_1.localPosition = Vector3.New(0, 100, 0)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			local var_59_3 = arg_56_1.actors_["10001_tpose"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10001_tpose = var_59_3.localPosition

				local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_3.gameObject, typeof(DynamicBoneHelper))

				if var_59_4 then
					var_59_4:EnableDynamicBone(false)
				end
			end

			local var_59_5 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 then
				var_59_3.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_5)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 then
				var_59_3.localPosition = Vector3.New(0, 100, 0)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles

				local var_59_6 = GameObjectTools.GetOrAddComponent(var_59_3.gameObject, typeof(DynamicBoneHelper))

				if var_59_6 then
					var_59_6:EnableDynamicBone(true)
				end
			end

			local var_59_7 = 0
			local var_59_8 = 0.575

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(104121014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_12 = 23 <= 0 and var_59_8 or var_59_8 * (utf8.len(var_59_10) / 23)

				if (23 <= 0 and var_59_8 or var_59_8 * (utf8.len(var_59_10) / 23)) > 0 and var_59_8 < var_59_12 then
					arg_56_1.talkMaxDuration = var_59_12

					if var_59_12 + var_59_7 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_7
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121014", "story_v_out_104121.awb") ~= 0 then
					local var_59_13 = manager.audio:GetVoiceLength("story_v_out_104121", "104121014", "story_v_out_104121.awb") / 1000

					if var_59_13 + var_59_7 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_7
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_104121", "104121014", "story_v_out_104121.awb")

						arg_56_1:RecordAudio("104121014", var_59_14)
						arg_56_1:RecordAudio("104121014", var_59_14)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_104121", "104121014", "story_v_out_104121.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_104121", "104121014", "story_v_out_104121.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_15 = math.max(var_59_8, arg_56_1.talkMaxDuration)

			if var_59_7 <= arg_56_1.time_ and arg_56_1.time_ < var_59_7 + var_59_15 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_7) / var_59_15

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_7 + var_59_15 and arg_56_1.time_ < var_59_7 + var_59_15 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play104121015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 104121015
		arg_60_1.duration_ = 4.03

		local var_60_0 = {
			ja = 4.033,
			ko = 2.7,
			zh = 3.033,
			en = 2.5
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play104121016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1011ui_story"]) and arg_60_1.var_.characterEffect1011ui_story == nil then
				arg_60_1.var_.characterEffect1011ui_story = arg_60_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1011ui_story"]) then
				if arg_60_1.var_.characterEffect1011ui_story and not isNil(arg_60_1.actors_["1011ui_story"]) then
					arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1011ui_story"]) and arg_60_1.var_.characterEffect1011ui_story then
				arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1011ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1011ui_story = var_63_2.localPosition
			end

			local var_63_3 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 then
				var_63_2.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_60_1.time_ - 0) / var_63_3)
				var_63_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_2.position).x, (manager.ui.mainCamera.transform.position - var_63_2.position).y, (manager.ui.mainCamera.transform.position - var_63_2.position).z)
				var_63_2.localEulerAngles.z = 0
				var_63_2.localEulerAngles.x = 0
				var_63_2.localEulerAngles = var_63_2.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 then
				var_63_2.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_63_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_2.position).x, (manager.ui.mainCamera.transform.position - var_63_2.position).y, (manager.ui.mainCamera.transform.position - var_63_2.position).z)
				var_63_2.localEulerAngles.z = 0
				var_63_2.localEulerAngles.x = 0
				var_63_2.localEulerAngles = var_63_2.localEulerAngles
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_63_4 = 0
			local var_63_5 = 0.275

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(104121015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 11 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 11)

				if (11 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 11)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121015", "story_v_out_104121.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_104121", "104121015", "story_v_out_104121.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_104121", "104121015", "story_v_out_104121.awb")

						arg_60_1:RecordAudio("104121015", var_63_11)
						arg_60_1:RecordAudio("104121015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_104121", "104121015", "story_v_out_104121.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_104121", "104121015", "story_v_out_104121.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play104121016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 104121016
		arg_64_1.duration_ = 6.13

		local var_64_0 = {
			ja = 6.133,
			ko = 3.133,
			zh = 4.1,
			en = 5.566
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play104121017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = arg_64_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) then
				if arg_64_1.var_.characterEffect1084ui_story and not isNil(arg_64_1.actors_["1084ui_story"]) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["1011ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1011ui_story == nil then
				arg_64_1.var_.characterEffect1011ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect1011ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1011ui_story then
				arg_64_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_67_4 = arg_64_1.actors_["1084ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_4.localPosition
			end

			local var_67_5 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_5 then
				var_67_4.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_64_1.time_ - 0) / var_67_5)
				var_67_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_4.position).x, (manager.ui.mainCamera.transform.position - var_67_4.position).y, (manager.ui.mainCamera.transform.position - var_67_4.position).z)
				var_67_4.localEulerAngles.z = 0
				var_67_4.localEulerAngles.x = 0
				var_67_4.localEulerAngles = var_67_4.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_5 and arg_64_1.time_ < 0 + var_67_5 + arg_67_0 then
				var_67_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_67_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_4.position).x, (manager.ui.mainCamera.transform.position - var_67_4.position).y, (manager.ui.mainCamera.transform.position - var_67_4.position).z)
				var_67_4.localEulerAngles.z = 0
				var_67_4.localEulerAngles.x = 0
				var_67_4.localEulerAngles = var_67_4.localEulerAngles
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_67_6 = 0
			local var_67_7 = 0.575

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_8 = arg_64_1:GetWordFromCfg(104121016)
				local var_67_9 = arg_64_1:FormatText(var_67_8.content)

				arg_64_1.text_.text = var_67_9

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 23 <= 0 and var_67_7 or var_67_7 * (utf8.len(var_67_9) / 23)

				if (23 <= 0 and var_67_7 or var_67_7 * (utf8.len(var_67_9) / 23)) > 0 and var_67_7 < var_67_11 then
					arg_64_1.talkMaxDuration = var_67_11

					if var_67_11 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_11 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_9
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121016", "story_v_out_104121.awb") ~= 0 then
					local var_67_12 = manager.audio:GetVoiceLength("story_v_out_104121", "104121016", "story_v_out_104121.awb") / 1000

					if var_67_12 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_12 + var_67_6
					end

					if var_67_8.prefab_name ~= "" and arg_64_1.actors_[var_67_8.prefab_name] ~= nil then
						local var_67_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_8.prefab_name].transform, "story_v_out_104121", "104121016", "story_v_out_104121.awb")

						arg_64_1:RecordAudio("104121016", var_67_13)
						arg_64_1:RecordAudio("104121016", var_67_13)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_104121", "104121016", "story_v_out_104121.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_104121", "104121016", "story_v_out_104121.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_14 and arg_64_1.time_ < var_67_6 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play104121017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 104121017
		arg_68_1.duration_ = 13.1

		local var_68_0 = {
			ja = 13.1,
			ko = 11.9,
			zh = 12.366,
			en = 12.1
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play104121018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = arg_68_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) then
				if arg_68_1.var_.characterEffect1084ui_story and not isNil(arg_68_1.actors_["1084ui_story"]) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_71_1 = arg_68_1.actors_["1084ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_1.localPosition
			end

			local var_71_2 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_2 then
				var_71_1.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_2)
				var_71_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_1.position).x, (manager.ui.mainCamera.transform.position - var_71_1.position).y, (manager.ui.mainCamera.transform.position - var_71_1.position).z)
				var_71_1.localEulerAngles.z = 0
				var_71_1.localEulerAngles.x = 0
				var_71_1.localEulerAngles = var_71_1.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_2 and arg_68_1.time_ < 0 + var_71_2 + arg_71_0 then
				var_71_1.localPosition = Vector3.New(0, 100, 0)
				var_71_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_1.position).x, (manager.ui.mainCamera.transform.position - var_71_1.position).y, (manager.ui.mainCamera.transform.position - var_71_1.position).z)
				var_71_1.localEulerAngles.z = 0
				var_71_1.localEulerAngles.x = 0
				var_71_1.localEulerAngles = var_71_1.localEulerAngles
			end

			local var_71_3 = arg_68_1.actors_["1011ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1011ui_story = var_71_3.localPosition
			end

			local var_71_4 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				var_71_3.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_4)
				var_71_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_3.position).x, (manager.ui.mainCamera.transform.position - var_71_3.position).y, (manager.ui.mainCamera.transform.position - var_71_3.position).z)
				var_71_3.localEulerAngles.z = 0
				var_71_3.localEulerAngles.x = 0
				var_71_3.localEulerAngles = var_71_3.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				var_71_3.localPosition = Vector3.New(0, 100, 0)
				var_71_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_3.position).x, (manager.ui.mainCamera.transform.position - var_71_3.position).y, (manager.ui.mainCamera.transform.position - var_71_3.position).z)
				var_71_3.localEulerAngles.z = 0
				var_71_3.localEulerAngles.x = 0
				var_71_3.localEulerAngles = var_71_3.localEulerAngles
			end

			local var_71_5 = 0
			local var_71_6 = 1.175

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_7 = arg_68_1:GetWordFromCfg(104121017)
				local var_71_8 = arg_68_1:FormatText(var_71_7.content)

				arg_68_1.text_.text = var_71_8

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_10 = 47 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_8) / 47)

				if (47 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_8) / 47)) > 0 and var_71_6 < var_71_10 then
					arg_68_1.talkMaxDuration = var_71_10

					if var_71_10 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_5
					end
				end

				arg_68_1.text_.text = var_71_8
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121017", "story_v_out_104121.awb") ~= 0 then
					local var_71_11 = manager.audio:GetVoiceLength("story_v_out_104121", "104121017", "story_v_out_104121.awb") / 1000

					if var_71_11 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_11 + var_71_5
					end

					if var_71_7.prefab_name ~= "" and arg_68_1.actors_[var_71_7.prefab_name] ~= nil then
						local var_71_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_7.prefab_name].transform, "story_v_out_104121", "104121017", "story_v_out_104121.awb")

						arg_68_1:RecordAudio("104121017", var_71_12)
						arg_68_1:RecordAudio("104121017", var_71_12)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_104121", "104121017", "story_v_out_104121.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_104121", "104121017", "story_v_out_104121.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_13 = math.max(var_71_6, arg_68_1.talkMaxDuration)

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_13 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_5) / var_71_13

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_5 + var_71_13 and arg_68_1.time_ < var_71_5 + var_71_13 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play104121018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 104121018
		arg_72_1.duration_ = 7

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play104121019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_0 = 2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				local var_75_1 = Color.New(0, 0, 0)

				var_75_1.a = Mathf.Lerp(1, 0, (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.mask_.color = var_75_1
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				local var_75_2 = Color.New(0, 0, 0)

				arg_72_1.mask_.enabled = false
				var_75_2.a = 0
				arg_72_1.mask_.color = var_75_2
			end

			local var_75_3 = "STblack"

			if arg_72_1.bgs_.STblack == nil then
				local var_75_4 = Object.Instantiate(arg_72_1.paintGo_)

				var_75_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_75_3)
				var_75_4.name = var_75_3
				var_75_4.transform.parent = arg_72_1.stage_.transform
				var_75_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.bgs_[var_75_3] = var_75_4
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				local var_75_5 = arg_72_1.bgs_.STblack

				arg_72_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_75_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_6 = var_75_5:GetComponent("SpriteRenderer")

				if var_75_6 and var_75_6.sprite then
					local var_75_7 = 2 * (var_75_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_75_5.transform.localScale = Vector3.New(var_75_7 / var_75_6.sprite.bounds.size.y < var_75_7 * manager.ui.mainCameraCom_.aspect / var_75_6.sprite.bounds.size.x and var_75_7 * manager.ui.mainCameraCom_.aspect / var_75_6.sprite.bounds.size.x or var_75_7 / var_75_6.sprite.bounds.size.y, var_75_7 / var_75_6.sprite.bounds.size.y < var_75_7 * manager.ui.mainCameraCom_.aspect / var_75_6.sprite.bounds.size.x and var_75_7 * manager.ui.mainCameraCom_.aspect / var_75_6.sprite.bounds.size.x or var_75_7 / var_75_6.sprite.bounds.size.y, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "STblack" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_8 = arg_72_1.actors_["1084ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_8.localPosition
			end

			local var_75_9 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_9 then
				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_9)
				var_75_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_8.position).x, (manager.ui.mainCamera.transform.position - var_75_8.position).y, (manager.ui.mainCamera.transform.position - var_75_8.position).z)
				var_75_8.localEulerAngles.z = 0
				var_75_8.localEulerAngles.x = 0
				var_75_8.localEulerAngles = var_75_8.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_9 and arg_72_1.time_ < 0 + var_75_9 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(0, 100, 0)
				var_75_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_8.position).x, (manager.ui.mainCamera.transform.position - var_75_8.position).y, (manager.ui.mainCamera.transform.position - var_75_8.position).z)
				var_75_8.localEulerAngles.z = 0
				var_75_8.localEulerAngles.x = 0
				var_75_8.localEulerAngles = var_75_8.localEulerAngles
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_10 = 2
			local var_75_11 = 0.675

			if 2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_12 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_12:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_13 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(104121018).content)

				arg_72_1.text_.text = var_75_13

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_15 = 27 <= 0 and var_75_11 or var_75_11 * (utf8.len(var_75_13) / 27)

				if (27 <= 0 and var_75_11 or var_75_11 * (utf8.len(var_75_13) / 27)) > 0 and var_75_11 < var_75_15 then
					arg_72_1.talkMaxDuration = var_75_15
					var_75_10 = var_75_10 + 0.3

					if var_75_15 + var_75_10 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_10
					end
				end

				arg_72_1.text_.text = var_75_13
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = var_75_10 + 0.3
			local var_75_17 = math.max(var_75_11, arg_72_1.talkMaxDuration)

			if var_75_10 + 0.3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_17 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_16) / var_75_17

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_16 + var_75_17 and arg_72_1.time_ < var_75_16 + var_75_17 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play104121019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104121019
		arg_78_1.duration_ = 4.02

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play104121020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_0 = 2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				local var_81_1 = Color.New(0, 0, 0)

				var_81_1.a = Mathf.Lerp(1, 0, (arg_78_1.time_ - 0) / var_81_0)
				arg_78_1.mask_.color = var_81_1
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				local var_81_2 = Color.New(0, 0, 0)

				arg_78_1.mask_.enabled = false
				var_81_2.a = 0
				arg_78_1.mask_.color = var_81_2
			end

			local var_81_3 = "S0409"

			if arg_78_1.bgs_.S0409 == nil then
				local var_81_4 = Object.Instantiate(arg_78_1.paintGo_)

				var_81_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_81_3)
				var_81_4.name = var_81_3
				var_81_4.transform.parent = arg_78_1.stage_.transform
				var_81_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.bgs_[var_81_3] = var_81_4
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				local var_81_5 = arg_78_1.bgs_.S0409

				arg_78_1.bgs_.S0409.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_81_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_6 = var_81_5:GetComponent("SpriteRenderer")

				if var_81_6 and var_81_6.sprite then
					local var_81_7 = 2 * (var_81_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_81_5.transform.localScale = Vector3.New(var_81_7 / var_81_6.sprite.bounds.size.y < var_81_7 * manager.ui.mainCameraCom_.aspect / var_81_6.sprite.bounds.size.x and var_81_7 * manager.ui.mainCameraCom_.aspect / var_81_6.sprite.bounds.size.x or var_81_7 / var_81_6.sprite.bounds.size.y, var_81_7 / var_81_6.sprite.bounds.size.y < var_81_7 * manager.ui.mainCameraCom_.aspect / var_81_6.sprite.bounds.size.x and var_81_7 * manager.ui.mainCameraCom_.aspect / var_81_6.sprite.bounds.size.x or var_81_7 / var_81_6.sprite.bounds.size.y, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "S0409" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_8 = arg_78_1.bgs_.S0409.transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPosS0409 = var_81_8.localPosition
			end

			local var_81_9 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_9 then
				var_81_8.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPosS0409, Vector3.New(0, 1, 7), (arg_78_1.time_ - 0) / var_81_9)
			end

			if arg_78_1.time_ >= 0 + var_81_9 and arg_78_1.time_ < 0 + var_81_9 + arg_81_0 then
				var_81_8.localPosition = Vector3.New(0, 1, 7)
			end

			local var_81_10 = arg_78_1.bgs_.S0409.transform

			if 0.0166666666666667 < arg_78_1.time_ and arg_78_1.time_ <= 0.0166666666666667 + arg_81_0 then
				arg_78_1.var_.moveOldPosS0409 = var_81_10.localPosition
			end

			local var_81_11 = 4

			if 0.0166666666666667 <= arg_78_1.time_ and arg_78_1.time_ < 0.0166666666666667 + var_81_11 then
				var_81_10.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPosS0409, Vector3.New(0, 1, 5), (arg_78_1.time_ - 0.0166666666666667) / var_81_11)
			end

			if arg_78_1.time_ >= 0.0166666666666667 + var_81_11 and arg_78_1.time_ < 0.0166666666666667 + var_81_11 + arg_81_0 then
				var_81_10.localPosition = Vector3.New(0, 1, 5)
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_12 = 2
			local var_81_13 = 0.1

			if 2 < arg_78_1.time_ and arg_78_1.time_ <= var_81_12 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_14 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_14:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_15 = arg_78_1:GetWordFromCfg(104121019)
				local var_81_16 = arg_78_1:FormatText(var_81_15.content)

				arg_78_1.text_.text = var_81_16

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_18 = 4 <= 0 and var_81_13 or var_81_13 * (utf8.len(var_81_16) / 4)

				if (4 <= 0 and var_81_13 or var_81_13 * (utf8.len(var_81_16) / 4)) > 0 and var_81_13 < var_81_18 then
					arg_78_1.talkMaxDuration = var_81_18
					var_81_12 = var_81_12 + 0.3

					if var_81_18 + var_81_12 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_18 + var_81_12
					end
				end

				arg_78_1.text_.text = var_81_16
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121019", "story_v_out_104121.awb") ~= 0 then
					local var_81_19 = manager.audio:GetVoiceLength("story_v_out_104121", "104121019", "story_v_out_104121.awb") / 1000

					if var_81_19 + var_81_12 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_19 + var_81_12
					end

					if var_81_15.prefab_name ~= "" and arg_78_1.actors_[var_81_15.prefab_name] ~= nil then
						local var_81_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_15.prefab_name].transform, "story_v_out_104121", "104121019", "story_v_out_104121.awb")

						arg_78_1:RecordAudio("104121019", var_81_20)
						arg_78_1:RecordAudio("104121019", var_81_20)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_104121", "104121019", "story_v_out_104121.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_104121", "104121019", "story_v_out_104121.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_21 = var_81_12 + 0.3
			local var_81_22 = math.max(var_81_13, arg_78_1.talkMaxDuration)

			if var_81_12 + 0.3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_21 + var_81_22 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_21) / var_81_22

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_21 + var_81_22 and arg_78_1.time_ < var_81_21 + var_81_22 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0409",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0409",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play104121020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 104121020
		arg_84_1.duration_ = 4.8

		local var_84_0 = {
			ja = 4.366,
			ko = 4.2,
			zh = 4.8,
			en = 4.133
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
			arg_84_1.auto_ = false
		end

		function arg_84_1.playNext_(arg_86_0)
			arg_84_1.onStoryFinished_()
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_0 = 2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				local var_87_1 = Color.New(1, 1, 1)

				var_87_1.a = Mathf.Lerp(1, 0, (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.mask_.color = var_87_1
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				local var_87_2 = Color.New(1, 1, 1)

				arg_84_1.mask_.enabled = false
				var_87_2.a = 0
				arg_84_1.mask_.color = var_87_2
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				local var_87_3 = arg_84_1.bgs_.S0409

				arg_84_1.bgs_.S0409.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_87_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_4 = var_87_3:GetComponent("SpriteRenderer")

				if var_87_4 and var_87_4.sprite then
					local var_87_5 = 2 * (var_87_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_87_3.transform.localScale = Vector3.New(var_87_5 / var_87_4.sprite.bounds.size.y < var_87_5 * manager.ui.mainCameraCom_.aspect / var_87_4.sprite.bounds.size.x and var_87_5 * manager.ui.mainCameraCom_.aspect / var_87_4.sprite.bounds.size.x or var_87_5 / var_87_4.sprite.bounds.size.y, var_87_5 / var_87_4.sprite.bounds.size.y < var_87_5 * manager.ui.mainCameraCom_.aspect / var_87_4.sprite.bounds.size.x and var_87_5 * manager.ui.mainCameraCom_.aspect / var_87_4.sprite.bounds.size.x or var_87_5 / var_87_4.sprite.bounds.size.y, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "S0409" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_6 = manager.ui.mainCamera.transform

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= 2 + arg_87_0 then
				arg_84_1.var_.shakeOldPos = var_87_6.localPosition
			end

			local var_87_7 = 0.666666666666667

			if 2 <= arg_84_1.time_ and arg_84_1.time_ < 2 + var_87_7 then
				local var_87_8, var_87_9 = math.modf((arg_84_1.time_ - 2) / 0.066)

				var_87_6.localPosition = Vector3.New(var_87_9 * 0.13, var_87_9 * 0.13, var_87_9 * 0.13) + arg_84_1.var_.shakeOldPos
			end

			if arg_84_1.time_ >= 2 + var_87_7 and arg_84_1.time_ < 2 + var_87_7 + arg_87_0 then
				var_87_6.localPosition = arg_84_1.var_.shakeOldPos
			end

			local var_87_10 = arg_84_1.bgs_.S0409.transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPosS0409 = var_87_10.localPosition
			end

			local var_87_11 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_11 then
				var_87_10.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPosS0409, Vector3.New(0, 1, 10), (arg_84_1.time_ - 0) / var_87_11)
			end

			if arg_84_1.time_ >= 0 + var_87_11 and arg_84_1.time_ < 0 + var_87_11 + arg_87_0 then
				var_87_10.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_12 = 2
			local var_87_13 = 0.25

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_14 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_14:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_15 = arg_84_1:GetWordFromCfg(104121020)
				local var_87_16 = arg_84_1:FormatText(var_87_15.content)

				arg_84_1.text_.text = var_87_16

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_18 = 10 <= 0 and var_87_13 or var_87_13 * (utf8.len(var_87_16) / 10)

				if (10 <= 0 and var_87_13 or var_87_13 * (utf8.len(var_87_16) / 10)) > 0 and var_87_13 < var_87_18 then
					arg_84_1.talkMaxDuration = var_87_18
					var_87_12 = var_87_12 + 0.3

					if var_87_18 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_18 + var_87_12
					end
				end

				arg_84_1.text_.text = var_87_16
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121020", "story_v_out_104121.awb") ~= 0 then
					local var_87_19 = manager.audio:GetVoiceLength("story_v_out_104121", "104121020", "story_v_out_104121.awb") / 1000

					if var_87_19 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_19 + var_87_12
					end

					if var_87_15.prefab_name ~= "" and arg_84_1.actors_[var_87_15.prefab_name] ~= nil then
						local var_87_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_15.prefab_name].transform, "story_v_out_104121", "104121020", "story_v_out_104121.awb")

						arg_84_1:RecordAudio("104121020", var_87_20)
						arg_84_1:RecordAudio("104121020", var_87_20)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_104121", "104121020", "story_v_out_104121.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_104121", "104121020", "story_v_out_104121.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_21 = var_87_12 + 0.3
			local var_87_22 = math.max(var_87_13, arg_84_1.talkMaxDuration)

			if var_87_12 + 0.3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_21 + var_87_22 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_21) / var_87_22

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_21 + var_87_22 and arg_84_1.time_ < var_87_21 + var_87_22 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0409",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/S0409"
	},
	voices = {
		"story_v_out_104121.awb"
	}
}
