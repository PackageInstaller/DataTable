return {
	Play106111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106111001
		arg_1_1.duration_ = 6.57

		local var_1_0 = {
			ja = 4.49966666666667,
			ko = 6.56666666666667,
			zh = 5.63266666666667,
			en = 4.99966666666667
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
				arg_1_0:Play106111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C02b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C02b")
				var_4_0.name = "C02b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C02b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C02b

				arg_1_1.bgs_.C02b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C02b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.C02b:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueC02b = var_4_4.color.a
					arg_1_1.var_.alphaMatValueC02b = var_4_4
				end

				arg_1_1.var_.alphaOldValueC02b = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueC02b then
					arg_1_1.var_.alphaMatValueC02b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueC02b, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueC02b.color = arg_1_1.var_.alphaMatValueC02b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueC02b then
				arg_1_1.var_.alphaMatValueC02b.color.a = 1
				arg_1_1.var_.alphaMatValueC02b.color = arg_1_1.var_.alphaMatValueC02b.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_8 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_9 + 1.76666666666667 and arg_1_1.time_ < var_4_9 + 1.76666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_10 = 1.76666666666667
			local var_4_11 = 0.225

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[79].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2033")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_13 = arg_1_1:GetWordFromCfg(106111001)
				local var_4_14 = arg_1_1:FormatText(var_4_13.content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 9 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_14) / 9)

				if (9 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_14) / 9)) > 0 and var_4_11 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_10 = var_4_10 + 0.3

					if var_4_16 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111001", "story_v_out_106111.awb") ~= 0 then
					local var_4_17 = manager.audio:GetVoiceLength("story_v_out_106111", "106111001", "story_v_out_106111.awb") / 1000

					if var_4_17 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_10
					end

					if var_4_13.prefab_name ~= "" and arg_1_1.actors_[var_4_13.prefab_name] ~= nil then
						local var_4_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_13.prefab_name].transform, "story_v_out_106111", "106111001", "story_v_out_106111.awb")

						arg_1_1:RecordAudio("106111001", var_4_18)
						arg_1_1:RecordAudio("106111001", var_4_18)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_106111", "106111001", "story_v_out_106111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_106111", "106111001", "story_v_out_106111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_10 + 0.3
			local var_4_20 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play106111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106111002
		arg_8_1.duration_ = 6.93

		local var_8_0 = {
			ja = 4.033,
			ko = 6.933,
			zh = 6,
			en = 6.466
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
				arg_8_0:Play106111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1093ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1093ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1093ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1093ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1093ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1093ui_story == nil then
				arg_8_1.var_.characterEffect1093ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1093ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1093ui_story then
				arg_8_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_11_6 = "2033_tpose"

			if arg_8_1.actors_["2033_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2033_tpose"))) then
				local var_11_7 = Object.Instantiate(Asset.Load("Char/" .. "2033_tpose"), arg_8_1.stage_.transform)

				var_11_7.name = var_11_6
				var_11_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_[var_11_6] = var_11_7

				local var_11_8 = var_11_7:GetComponentInChildren(typeof(CharacterEffect))

				var_11_8.enabled = true

				local var_11_9 = GameObjectTools.GetOrAddComponent(var_11_7, typeof(DynamicBoneHelper))

				if var_11_9 then
					var_11_9:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_8.transform, false)

				arg_8_1.var_[var_11_6 .. "Animator"] = var_11_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_[var_11_6 .. "Animator"].applyRootMotion = true
				arg_8_1.var_[var_11_6 .. "LipSync"] = var_11_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_10 = arg_8_1.actors_["2033_tpose"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos2033_tpose = var_11_10.localPosition

				local var_11_11 = GameObjectTools.GetOrAddComponent(var_11_10.gameObject, typeof(DynamicBoneHelper))

				if var_11_11 then
					var_11_11:EnableDynamicBone(false)
				end
			end

			local var_11_12 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_12 then
				var_11_10.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2033_tpose, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_12)
				var_11_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_10.position).x, (manager.ui.mainCamera.transform.position - var_11_10.position).y, (manager.ui.mainCamera.transform.position - var_11_10.position).z)
				var_11_10.localEulerAngles.z = 0
				var_11_10.localEulerAngles.x = 0
				var_11_10.localEulerAngles = var_11_10.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_12 and arg_8_1.time_ < 0 + var_11_12 + arg_11_0 then
				var_11_10.localPosition = Vector3.New(0, 100, 0)
				var_11_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_10.position).x, (manager.ui.mainCamera.transform.position - var_11_10.position).y, (manager.ui.mainCamera.transform.position - var_11_10.position).z)
				var_11_10.localEulerAngles.z = 0
				var_11_10.localEulerAngles.x = 0
				var_11_10.localEulerAngles = var_11_10.localEulerAngles

				local var_11_13 = GameObjectTools.GetOrAddComponent(var_11_10.gameObject, typeof(DynamicBoneHelper))

				if var_11_13 then
					var_11_13:EnableDynamicBone(true)
				end
			end

			local var_11_14 = arg_8_1.actors_["1093ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1093ui_story = var_11_14.localPosition

				arg_8_1:ShowWeapon(arg_8_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_11_15 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_15 then
				var_11_14.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_8_1.time_ - 0) / var_11_15)
				var_11_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_14.position).x, (manager.ui.mainCamera.transform.position - var_11_14.position).y, (manager.ui.mainCamera.transform.position - var_11_14.position).z)
				var_11_14.localEulerAngles.z = 0
				var_11_14.localEulerAngles.x = 0
				var_11_14.localEulerAngles = var_11_14.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_15 and arg_8_1.time_ < 0 + var_11_15 + arg_11_0 then
				var_11_14.localPosition = Vector3.New(0, -1.11, -5.88)
				var_11_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_14.position).x, (manager.ui.mainCamera.transform.position - var_11_14.position).y, (manager.ui.mainCamera.transform.position - var_11_14.position).z)
				var_11_14.localEulerAngles.z = 0
				var_11_14.localEulerAngles.x = 0
				var_11_14.localEulerAngles = var_11_14.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_11_16 = 0
			local var_11_17 = 0.65

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_18 = arg_8_1:GetWordFromCfg(106111002)
				local var_11_19 = arg_8_1:FormatText(var_11_18.content)

				arg_8_1.text_.text = var_11_19

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_21 = 26 <= 0 and var_11_17 or var_11_17 * (utf8.len(var_11_19) / 26)

				if (26 <= 0 and var_11_17 or var_11_17 * (utf8.len(var_11_19) / 26)) > 0 and var_11_17 < var_11_21 then
					arg_8_1.talkMaxDuration = var_11_21

					if var_11_21 + var_11_16 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_21 + var_11_16
					end
				end

				arg_8_1.text_.text = var_11_19
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111002", "story_v_out_106111.awb") ~= 0 then
					local var_11_22 = manager.audio:GetVoiceLength("story_v_out_106111", "106111002", "story_v_out_106111.awb") / 1000

					if var_11_22 + var_11_16 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_22 + var_11_16
					end

					if var_11_18.prefab_name ~= "" and arg_8_1.actors_[var_11_18.prefab_name] ~= nil then
						local var_11_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_18.prefab_name].transform, "story_v_out_106111", "106111002", "story_v_out_106111.awb")

						arg_8_1:RecordAudio("106111002", var_11_23)
						arg_8_1:RecordAudio("106111002", var_11_23)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_106111", "106111002", "story_v_out_106111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_106111", "106111002", "story_v_out_106111.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_24 = math.max(var_11_17, arg_8_1.talkMaxDuration)

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_24 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_16) / var_11_24

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_16 + var_11_24 and arg_8_1.time_ < var_11_16 + var_11_24 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2033_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play106111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106111003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play106111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1093ui_story"]) and arg_12_1.var_.characterEffect1093ui_story == nil then
				arg_12_1.var_.characterEffect1093ui_story = arg_12_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1093ui_story"]) then
				if arg_12_1.var_.characterEffect1093ui_story and not isNil(arg_12_1.actors_["1093ui_story"]) then
					arg_12_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1093ui_story"]) and arg_12_1.var_.characterEffect1093ui_story then
				arg_12_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_6", "se_story_6_draw_sword", "")
			end

			local var_15_2 = 0
			local var_15_3 = 0.625

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(106111003).content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 25 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 25)

				if (25 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 25)) > 0 and var_15_3 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_7 and arg_12_1.time_ < var_15_2 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play106111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106111004
		arg_16_1.duration_ = 8.1

		local var_16_0 = {
			ja = 5.233,
			ko = 6.233,
			zh = 7.6,
			en = 8.1
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
				arg_16_0:Play106111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1093ui_story"]) and arg_16_1.var_.characterEffect1093ui_story == nil then
				arg_16_1.var_.characterEffect1093ui_story = arg_16_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1093ui_story"]) then
				if arg_16_1.var_.characterEffect1093ui_story and not isNil(arg_16_1.actors_["1093ui_story"]) then
					arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1093ui_story"]) and arg_16_1.var_.characterEffect1093ui_story then
				arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action494")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_19_2 = 0
			local var_19_3 = 0.775

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:GetWordFromCfg(106111004)
				local var_19_5 = arg_16_1:FormatText(var_19_4.content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 31 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 31)

				if (31 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 31)) > 0 and var_19_3 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111004", "story_v_out_106111.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_106111", "106111004", "story_v_out_106111.awb") / 1000

					if var_19_8 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_2
					end

					if var_19_4.prefab_name ~= "" and arg_16_1.actors_[var_19_4.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_4.prefab_name].transform, "story_v_out_106111", "106111004", "story_v_out_106111.awb")

						arg_16_1:RecordAudio("106111004", var_19_9)
						arg_16_1:RecordAudio("106111004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_106111", "106111004", "story_v_out_106111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_106111", "106111004", "story_v_out_106111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_10 and arg_16_1.time_ < var_19_2 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play106111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106111005
		arg_20_1.duration_ = 12.37

		local var_20_0 = {
			ja = 12.366,
			ko = 8.3,
			zh = 7.6,
			en = 7.5
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
				arg_20_0:Play106111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.975

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:GetWordFromCfg(106111005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 39 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 39)

				if (39 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 39)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111005", "story_v_out_106111.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_106111", "106111005", "story_v_out_106111.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_106111", "106111005", "story_v_out_106111.awb")

						arg_20_1:RecordAudio("106111005", var_23_6)
						arg_20_1:RecordAudio("106111005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106111", "106111005", "story_v_out_106111.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106111", "106111005", "story_v_out_106111.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play106111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106111006
		arg_24_1.duration_ = 6.63

		local var_24_0 = {
			ja = 6.633,
			ko = 4.433,
			zh = 5.6,
			en = 5.833
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
				arg_24_0:Play106111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1093ui_story"]) and arg_24_1.var_.characterEffect1093ui_story == nil then
				arg_24_1.var_.characterEffect1093ui_story = arg_24_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1093ui_story"]) then
				if arg_24_1.var_.characterEffect1093ui_story and not isNil(arg_24_1.actors_["1093ui_story"]) then
					arg_24_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1093ui_story"]) and arg_24_1.var_.characterEffect1093ui_story then
				arg_24_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.55

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(106111006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 19 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 19)

				if (19 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 19)) > 0 and var_27_2 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111006", "story_v_out_106111.awb") ~= 0 then
					local var_27_7 = manager.audio:GetVoiceLength("story_v_out_106111", "106111006", "story_v_out_106111.awb") / 1000

					if var_27_7 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_1
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_106111", "106111006", "story_v_out_106111.awb")

						arg_24_1:RecordAudio("106111006", var_27_8)
						arg_24_1:RecordAudio("106111006", var_27_8)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_106111", "106111006", "story_v_out_106111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_106111", "106111006", "story_v_out_106111.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_9 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_9 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_9

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_9 and arg_24_1.time_ < var_27_1 + var_27_9 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play106111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106111007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play106111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1093ui_story"]) and arg_28_1.var_.characterEffect1093ui_story == nil then
				arg_28_1.var_.characterEffect1093ui_story = arg_28_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1093ui_story"]) then
				if arg_28_1.var_.characterEffect1093ui_story and not isNil(arg_28_1.actors_["1093ui_story"]) then
					arg_28_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1093ui_story"]) and arg_28_1.var_.characterEffect1093ui_story then
				arg_28_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action442")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_31_2 = 0
			local var_31_3 = 0.075

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_4 = arg_28_1:GetWordFromCfg(106111007)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 3 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 3)

				if (3 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 3)) > 0 and var_31_3 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111007", "story_v_out_106111.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_106111", "106111007", "story_v_out_106111.awb") / 1000

					if var_31_8 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_2
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_out_106111", "106111007", "story_v_out_106111.awb")

						arg_28_1:RecordAudio("106111007", var_31_9)
						arg_28_1:RecordAudio("106111007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_106111", "106111007", "story_v_out_106111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_106111", "106111007", "story_v_out_106111.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_10 and arg_28_1.time_ < var_31_2 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play106111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106111008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play106111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1093ui_story"]) and arg_32_1.var_.characterEffect1093ui_story == nil then
				arg_32_1.var_.characterEffect1093ui_story = arg_32_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1093ui_story"]) then
				if arg_32_1.var_.characterEffect1093ui_story and not isNil(arg_32_1.actors_["1093ui_story"]) then
					arg_32_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1093ui_story"]) and arg_32_1.var_.characterEffect1093ui_story then
				arg_32_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_35_1 = arg_32_1.actors_["1093ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1093ui_story = var_35_1.localPosition

				arg_32_1:ShowWeapon(arg_32_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_35_2 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 then
				var_35_1.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_2)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 then
				var_35_1.localPosition = Vector3.New(0, 100, 0)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "se_story_6", "se_story_6_darts", "")
			end

			local var_35_4 = 0
			local var_35_5 = 0.925

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(106111008).content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_8 = 37 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_6) / 37)

				if (37 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_6) / 37)) > 0 and var_35_5 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_9 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_9 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_9

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_9 and arg_32_1.time_ < var_35_4 + var_35_9 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play106111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106111009
		arg_36_1.duration_ = 5

		local var_36_0 = {
			ja = 5,
			ko = 4.3,
			zh = 3.833,
			en = 3.533
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
				arg_36_0:Play106111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1093ui_story"]) and arg_36_1.var_.characterEffect1093ui_story == nil then
				arg_36_1.var_.characterEffect1093ui_story = arg_36_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1093ui_story"]) then
				if arg_36_1.var_.characterEffect1093ui_story and not isNil(arg_36_1.actors_["1093ui_story"]) then
					arg_36_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1093ui_story"]) and arg_36_1.var_.characterEffect1093ui_story then
				arg_36_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1093ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1093ui_story = var_39_2.localPosition

				arg_36_1:ShowWeapon(arg_36_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_39_3 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 then
				var_39_2.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_36_1.time_ - 0) / var_39_3)
				var_39_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_2.position).x, (manager.ui.mainCamera.transform.position - var_39_2.position).y, (manager.ui.mainCamera.transform.position - var_39_2.position).z)
				var_39_2.localEulerAngles.z = 0
				var_39_2.localEulerAngles.x = 0
				var_39_2.localEulerAngles = var_39_2.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 then
				var_39_2.localPosition = Vector3.New(0, -1.11, -5.88)
				var_39_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_2.position).x, (manager.ui.mainCamera.transform.position - var_39_2.position).y, (manager.ui.mainCamera.transform.position - var_39_2.position).z)
				var_39_2.localEulerAngles.z = 0
				var_39_2.localEulerAngles.x = 0
				var_39_2.localEulerAngles = var_39_2.localEulerAngles
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_39_4 = 0
			local var_39_5 = 0.475

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(106111009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 19 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 19)

				if (19 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 19)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111009", "story_v_out_106111.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_106111", "106111009", "story_v_out_106111.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_106111", "106111009", "story_v_out_106111.awb")

						arg_36_1:RecordAudio("106111009", var_39_11)
						arg_36_1:RecordAudio("106111009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_106111", "106111009", "story_v_out_106111.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_106111", "106111009", "story_v_out_106111.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play106111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106111010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play106111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1093ui_story"]) and arg_40_1.var_.characterEffect1093ui_story == nil then
				arg_40_1.var_.characterEffect1093ui_story = arg_40_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1093ui_story"]) then
				if arg_40_1.var_.characterEffect1093ui_story and not isNil(arg_40_1.actors_["1093ui_story"]) then
					arg_40_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1093ui_story"]) and arg_40_1.var_.characterEffect1093ui_story then
				arg_40_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_43_1 = arg_40_1.actors_["1093ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1093ui_story = var_43_1.localPosition

				arg_40_1:ShowWeapon(arg_40_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_43_2 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_2 then
				var_43_1.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_2)
				var_43_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_1.position).x, (manager.ui.mainCamera.transform.position - var_43_1.position).y, (manager.ui.mainCamera.transform.position - var_43_1.position).z)
				var_43_1.localEulerAngles.z = 0
				var_43_1.localEulerAngles.x = 0
				var_43_1.localEulerAngles = var_43_1.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_2 and arg_40_1.time_ < 0 + var_43_2 + arg_43_0 then
				var_43_1.localPosition = Vector3.New(0, 100, 0)
				var_43_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_1.position).x, (manager.ui.mainCamera.transform.position - var_43_1.position).y, (manager.ui.mainCamera.transform.position - var_43_1.position).z)
				var_43_1.localEulerAngles.z = 0
				var_43_1.localEulerAngles.x = 0
				var_43_1.localEulerAngles = var_43_1.localEulerAngles
			end

			local var_43_3 = 0
			local var_43_4 = 0.85

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_5 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(106111010).content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 34 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_5) / 34)

				if (34 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_5) / 34)) > 0 and var_43_4 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_3
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_4, arg_40_1.talkMaxDuration)

			if var_43_3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_3 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_3) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_3 + var_43_8 and arg_40_1.time_ < var_43_3 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play106111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 106111011
		arg_44_1.duration_ = 10.9

		local var_44_0 = {
			ja = 9.866,
			ko = 9.933,
			zh = 10.9,
			en = 9.966
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
				arg_44_0:Play106111012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 1.466 < arg_44_1.time_ and arg_44_1.time_ <= 1.466 + arg_47_0 then
				arg_44_1.var_.moveOldPosC02b = arg_44_1.bgs_.C02b.transform.localPosition
			end

			local var_47_0 = 0.001

			if 1.466 <= arg_44_1.time_ and arg_44_1.time_ < 1.466 + var_47_0 then
				arg_44_1.bgs_.C02b.transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPosC02b, Vector3.New(0, -100, 10), (arg_44_1.time_ - 1.466) / var_47_0)
			end

			if arg_44_1.time_ >= 1.466 + var_47_0 and arg_44_1.time_ < 1.466 + var_47_0 + arg_47_0 then
				arg_44_1.bgs_.C02b.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_47_1 = "S0608"

			if arg_44_1.bgs_.S0608 == nil then
				local var_47_2 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_1)
				var_47_2.name = var_47_1
				var_47_2.transform.parent = arg_44_1.stage_.transform
				var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_1] = var_47_2
			end

			if 1.5 < arg_44_1.time_ and arg_44_1.time_ <= 1.5 + arg_47_0 then
				local var_47_3 = arg_44_1.bgs_.S0608

				arg_44_1.bgs_.S0608.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_47_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_4 = var_47_3:GetComponent("SpriteRenderer")

				if var_47_4 and var_47_4.sprite then
					local var_47_5 = 2 * (var_47_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_47_3.transform.localScale = Vector3.New(var_47_5 / var_47_4.sprite.bounds.size.y < var_47_5 * manager.ui.mainCameraCom_.aspect / var_47_4.sprite.bounds.size.x and var_47_5 * manager.ui.mainCameraCom_.aspect / var_47_4.sprite.bounds.size.x or var_47_5 / var_47_4.sprite.bounds.size.y, var_47_5 / var_47_4.sprite.bounds.size.y < var_47_5 * manager.ui.mainCameraCom_.aspect / var_47_4.sprite.bounds.size.x and var_47_5 * manager.ui.mainCameraCom_.aspect / var_47_4.sprite.bounds.size.x or var_47_5 / var_47_4.sprite.bounds.size.y, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "S0608" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				local var_47_6 = arg_44_1.bgs_.C02b:GetComponent("SpriteRenderer")

				if var_47_6 then
					arg_44_1.var_.alphaOldValueC02b = var_47_6.color.a
					arg_44_1.var_.alphaMatValueC02b = var_47_6
				end

				arg_44_1.var_.alphaOldValueC02b = 1
			end

			local var_47_7 = 1.5

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				if arg_44_1.var_.alphaMatValueC02b then
					arg_44_1.var_.alphaMatValueC02b.color.a = Mathf.Lerp(arg_44_1.var_.alphaOldValueC02b, 0, (arg_44_1.time_ - 0) / var_47_7)
					arg_44_1.var_.alphaMatValueC02b.color = arg_44_1.var_.alphaMatValueC02b.color
				end
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 and arg_44_1.var_.alphaMatValueC02b then
				arg_44_1.var_.alphaMatValueC02b.color.a = 0
				arg_44_1.var_.alphaMatValueC02b.color = arg_44_1.var_.alphaMatValueC02b.color
			end

			if 1.5 < arg_44_1.time_ and arg_44_1.time_ <= 1.5 + arg_47_0 then
				local var_47_8 = arg_44_1.bgs_.S0608:GetComponent("SpriteRenderer")

				if var_47_8 then
					arg_44_1.var_.alphaOldValueS0608 = var_47_8.color.a
					arg_44_1.var_.alphaMatValueS0608 = var_47_8
				end

				arg_44_1.var_.alphaOldValueS0608 = 0
			end

			local var_47_9 = 1.5

			if 1.5 <= arg_44_1.time_ and arg_44_1.time_ < 1.5 + var_47_9 then
				if arg_44_1.var_.alphaMatValueS0608 then
					arg_44_1.var_.alphaMatValueS0608.color.a = Mathf.Lerp(arg_44_1.var_.alphaOldValueS0608, 1, (arg_44_1.time_ - 1.5) / var_47_9)
					arg_44_1.var_.alphaMatValueS0608.color = arg_44_1.var_.alphaMatValueS0608.color
				end
			end

			if arg_44_1.time_ >= 1.5 + var_47_9 and arg_44_1.time_ < 1.5 + var_47_9 + arg_47_0 and arg_44_1.var_.alphaMatValueS0608 then
				arg_44_1.var_.alphaMatValueS0608.color.a = 1
				arg_44_1.var_.alphaMatValueS0608.color = arg_44_1.var_.alphaMatValueS0608.color
			end

			local var_47_10 = 0

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			if arg_44_1.time_ >= var_47_10 + 3 and arg_44_1.time_ < var_47_10 + 3 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_11 = 3
			local var_47_12 = 0.575

			if 3 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_13 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_13:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:GetWordFromCfg(106111011)
				local var_47_15 = arg_44_1:FormatText(var_47_14.content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 22 <= 0 and var_47_12 or var_47_12 * (utf8.len(var_47_15) / 22)

				if (22 <= 0 and var_47_12 or var_47_12 * (utf8.len(var_47_15) / 22)) > 0 and var_47_12 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17
					var_47_11 = var_47_11 + 0.3

					if var_47_17 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_11
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111011", "story_v_out_106111.awb") ~= 0 then
					local var_47_18 = manager.audio:GetVoiceLength("story_v_out_106111", "106111011", "story_v_out_106111.awb") / 1000

					if var_47_18 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_11
					end

					if var_47_14.prefab_name ~= "" and arg_44_1.actors_[var_47_14.prefab_name] ~= nil then
						local var_47_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_14.prefab_name].transform, "story_v_out_106111", "106111011", "story_v_out_106111.awb")

						arg_44_1:RecordAudio("106111011", var_47_19)
						arg_44_1:RecordAudio("106111011", var_47_19)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_106111", "106111011", "story_v_out_106111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_106111", "106111011", "story_v_out_106111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_20 = var_47_11 + 0.3
			local var_47_21 = math.max(var_47_12, arg_44_1.talkMaxDuration)

			if var_47_11 + 0.3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_20 + var_47_21 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_20) / var_47_21

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_20 + var_47_21 and arg_44_1.time_ < var_47_20 + var_47_21 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "C02b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.466,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play106111012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 106111012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play106111013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:AudioAction("play", "effect", "se_story_6", "se_story_6_black_fog", "")
			end

			local var_53_1 = 0
			local var_53_2 = 1.025

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_3 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(106111012).content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 41 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 41)

				if (41 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 41)) > 0 and var_53_2 < var_53_5 then
					arg_50_1.talkMaxDuration = var_53_5

					if var_53_5 + var_53_1 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + var_53_1
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_6 = math.max(var_53_2, arg_50_1.talkMaxDuration)

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_6 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_1) / var_53_6

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_1 + var_53_6 and arg_50_1.time_ < var_53_1 + var_53_6 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play106111013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 106111013
		arg_54_1.duration_ = 6.6

		local var_54_0 = {
			ja = 6.6,
			ko = 3.5,
			zh = 3.766,
			en = 5.9
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play106111014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.475

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:GetWordFromCfg(106111013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 19 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 19)

				if (19 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 19)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111013", "story_v_out_106111.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_106111", "106111013", "story_v_out_106111.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_106111", "106111013", "story_v_out_106111.awb")

						arg_54_1:RecordAudio("106111013", var_57_6)
						arg_54_1:RecordAudio("106111013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_106111", "106111013", "story_v_out_106111.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_106111", "106111013", "story_v_out_106111.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play106111014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 106111014
		arg_58_1.duration_ = 8.63

		local var_58_0 = {
			ja = 8.633,
			ko = 6.866,
			zh = 6.2,
			en = 5.4
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play106111015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.65

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_1 = arg_58_1:GetWordFromCfg(106111014)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 24 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 24)

				if (24 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 24)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111014", "story_v_out_106111.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_106111", "106111014", "story_v_out_106111.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_106111", "106111014", "story_v_out_106111.awb")

						arg_58_1:RecordAudio("106111014", var_61_6)
						arg_58_1:RecordAudio("106111014", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_106111", "106111014", "story_v_out_106111.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_106111", "106111014", "story_v_out_106111.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play106111015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 106111015
		arg_62_1.duration_ = 4.7

		local var_62_0 = {
			ja = 2.966,
			ko = 3.233,
			zh = 4.7,
			en = 3.233
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play106111016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.35

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:GetWordFromCfg(106111015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 14 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 14)

				if (14 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 14)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111015", "story_v_out_106111.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_106111", "106111015", "story_v_out_106111.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_106111", "106111015", "story_v_out_106111.awb")

						arg_62_1:RecordAudio("106111015", var_65_6)
						arg_62_1:RecordAudio("106111015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_106111", "106111015", "story_v_out_106111.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_106111", "106111015", "story_v_out_106111.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play106111016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 106111016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play106111017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.6

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(106111016).content)

				arg_66_1.text_.text = var_69_1

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_3 = 24 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 24)

				if (24 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 24)) > 0 and var_69_0 < var_69_3 then
					arg_66_1.talkMaxDuration = var_69_3

					if var_69_3 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_3 + 0
					end
				end

				arg_66_1.text_.text = var_69_1
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_4 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_4

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play106111017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 106111017
		arg_70_1.duration_ = 12.2

		local var_70_0 = {
			ja = 12.2,
			ko = 9.9,
			zh = 10,
			en = 7.766
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play106111018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.actors_["4014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4014_tpose"))) then
				local var_73_0 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_70_1.stage_.transform)

				var_73_0.name = "4014_tpose"
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["4014_tpose"] = var_73_0

				local var_73_1 = var_73_0:GetComponentInChildren(typeof(CharacterEffect))

				var_73_1.enabled = true

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end

				arg_70_1:ShowWeapon(var_73_1.transform, false)

				arg_70_1.var_["4014_tpose" .. "Animator"] = var_73_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_70_1.var_["4014_tpose" .. "Animator"].applyRootMotion = true
				arg_70_1.var_["4014_tpose" .. "LipSync"] = var_73_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_73_3 = arg_70_1.actors_["4014_tpose"]

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect4014_tpose == nil then
				arg_70_1.var_.characterEffect4014_tpose = var_73_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_4 = 0.1

			if 2 <= arg_70_1.time_ and arg_70_1.time_ < 2 + var_73_4 and not isNil(var_73_3) then
				if arg_70_1.var_.characterEffect4014_tpose and not isNil(var_73_3) then
					arg_70_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 2 + var_73_4 and arg_70_1.time_ < 2 + var_73_4 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect4014_tpose then
				arg_70_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_73_6 = arg_70_1.bgs_.S0608.transform

			if 1.5 < arg_70_1.time_ and arg_70_1.time_ <= 1.5 + arg_73_0 then
				arg_70_1.var_.moveOldPosS0608 = var_73_6.localPosition
			end

			local var_73_7 = 0.001

			if 1.5 <= arg_70_1.time_ and arg_70_1.time_ < 1.5 + var_73_7 then
				var_73_6.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPosS0608, Vector3.New(0, -100, 10), (arg_70_1.time_ - 1.5) / var_73_7)
			end

			if arg_70_1.time_ >= 1.5 + var_73_7 and arg_70_1.time_ < 1.5 + var_73_7 + arg_73_0 then
				var_73_6.localPosition = Vector3.New(0, -100, 10)
			end

			if 1.5 < arg_70_1.time_ and arg_70_1.time_ <= 1.5 + arg_73_0 then
				local var_73_8 = arg_70_1.bgs_.C02b

				arg_70_1.bgs_.C02b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_73_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_9 = var_73_8:GetComponent("SpriteRenderer")

				if var_73_9 and var_73_9.sprite then
					local var_73_10 = 2 * (var_73_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_73_8.transform.localScale = Vector3.New(var_73_10 / var_73_9.sprite.bounds.size.y < var_73_10 * manager.ui.mainCameraCom_.aspect / var_73_9.sprite.bounds.size.x and var_73_10 * manager.ui.mainCameraCom_.aspect / var_73_9.sprite.bounds.size.x or var_73_10 / var_73_9.sprite.bounds.size.y, var_73_10 / var_73_9.sprite.bounds.size.y < var_73_10 * manager.ui.mainCameraCom_.aspect / var_73_9.sprite.bounds.size.x and var_73_10 * manager.ui.mainCameraCom_.aspect / var_73_9.sprite.bounds.size.x or var_73_10 / var_73_9.sprite.bounds.size.y, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "C02b" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_11 = arg_70_1.actors_["4014_tpose"].transform

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 then
				arg_70_1.var_.moveOldPos4014_tpose = var_73_11.localPosition

				local var_73_12 = GameObjectTools.GetOrAddComponent(var_73_11.gameObject, typeof(DynamicBoneHelper))

				if var_73_12 then
					var_73_12:EnableDynamicBone(false)
				end
			end

			local var_73_13 = 0.001

			if 2 <= arg_70_1.time_ and arg_70_1.time_ < 2 + var_73_13 then
				var_73_11.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_70_1.time_ - 2) / var_73_13)
				var_73_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_11.position).x, (manager.ui.mainCamera.transform.position - var_73_11.position).y, (manager.ui.mainCamera.transform.position - var_73_11.position).z)
				var_73_11.localEulerAngles.z = 0
				var_73_11.localEulerAngles.x = 0
				var_73_11.localEulerAngles = var_73_11.localEulerAngles
			end

			if arg_70_1.time_ >= 2 + var_73_13 and arg_70_1.time_ < 2 + var_73_13 + arg_73_0 then
				var_73_11.localPosition = Vector3.New(0, -1.95, -4.2)
				var_73_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_11.position).x, (manager.ui.mainCamera.transform.position - var_73_11.position).y, (manager.ui.mainCamera.transform.position - var_73_11.position).z)
				var_73_11.localEulerAngles.z = 0
				var_73_11.localEulerAngles.x = 0
				var_73_11.localEulerAngles = var_73_11.localEulerAngles

				local var_73_14 = GameObjectTools.GetOrAddComponent(var_73_11.gameObject, typeof(DynamicBoneHelper))

				if var_73_14 then
					var_73_14:EnableDynamicBone(true)
				end
			end

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 then
				arg_70_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			if 1.5 < arg_70_1.time_ and arg_70_1.time_ <= 1.5 + arg_73_0 then
				local var_73_15 = arg_70_1.bgs_.C02b:GetComponent("SpriteRenderer")

				if var_73_15 then
					arg_70_1.var_.alphaOldValueC02b = var_73_15.color.a
					arg_70_1.var_.alphaMatValueC02b = var_73_15
				end

				arg_70_1.var_.alphaOldValueC02b = 0
			end

			local var_73_16 = 1.5

			if 1.5 <= arg_70_1.time_ and arg_70_1.time_ < 1.5 + var_73_16 then
				if arg_70_1.var_.alphaMatValueC02b then
					arg_70_1.var_.alphaMatValueC02b.color.a = Mathf.Lerp(arg_70_1.var_.alphaOldValueC02b, 1, (arg_70_1.time_ - 1.5) / var_73_16)
					arg_70_1.var_.alphaMatValueC02b.color = arg_70_1.var_.alphaMatValueC02b.color
				end
			end

			if arg_70_1.time_ >= 1.5 + var_73_16 and arg_70_1.time_ < 1.5 + var_73_16 + arg_73_0 and arg_70_1.var_.alphaMatValueC02b then
				arg_70_1.var_.alphaMatValueC02b.color.a = 1
				arg_70_1.var_.alphaMatValueC02b.color = arg_70_1.var_.alphaMatValueC02b.color
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				local var_73_17 = arg_70_1.bgs_.S0608:GetComponent("SpriteRenderer")

				if var_73_17 then
					arg_70_1.var_.alphaOldValueS0608 = var_73_17.color.a
					arg_70_1.var_.alphaMatValueS0608 = var_73_17
				end

				arg_70_1.var_.alphaOldValueS0608 = 1
			end

			local var_73_18 = 1.5

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_18 then
				if arg_70_1.var_.alphaMatValueS0608 then
					arg_70_1.var_.alphaMatValueS0608.color.a = Mathf.Lerp(arg_70_1.var_.alphaOldValueS0608, 0, (arg_70_1.time_ - 0) / var_73_18)
					arg_70_1.var_.alphaMatValueS0608.color = arg_70_1.var_.alphaMatValueS0608.color
				end
			end

			if arg_70_1.time_ >= 0 + var_73_18 and arg_70_1.time_ < 0 + var_73_18 + arg_73_0 and arg_70_1.var_.alphaMatValueS0608 then
				arg_70_1.var_.alphaMatValueS0608.color.a = 0
				arg_70_1.var_.alphaMatValueS0608.color = arg_70_1.var_.alphaMatValueS0608.color
			end

			local var_73_19 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_19 + arg_73_0 then
				arg_70_1.allBtn_.enabled = false
			end

			if arg_70_1.time_ >= var_73_19 + 2 and arg_70_1.time_ < var_73_19 + 2 + arg_73_0 then
				arg_70_1.allBtn_.enabled = true
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_20 = 2
			local var_73_21 = 0.675

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_20 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_22 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_22:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_23 = arg_70_1:GetWordFromCfg(106111017)
				local var_73_24 = arg_70_1:FormatText(var_73_23.content)

				arg_70_1.text_.text = var_73_24

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_26 = 27 <= 0 and var_73_21 or var_73_21 * (utf8.len(var_73_24) / 27)

				if (27 <= 0 and var_73_21 or var_73_21 * (utf8.len(var_73_24) / 27)) > 0 and var_73_21 < var_73_26 then
					arg_70_1.talkMaxDuration = var_73_26
					var_73_20 = var_73_20 + 0.3

					if var_73_26 + var_73_20 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_26 + var_73_20
					end
				end

				arg_70_1.text_.text = var_73_24
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111017", "story_v_out_106111.awb") ~= 0 then
					local var_73_27 = manager.audio:GetVoiceLength("story_v_out_106111", "106111017", "story_v_out_106111.awb") / 1000

					if var_73_27 + var_73_20 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_27 + var_73_20
					end

					if var_73_23.prefab_name ~= "" and arg_70_1.actors_[var_73_23.prefab_name] ~= nil then
						local var_73_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_23.prefab_name].transform, "story_v_out_106111", "106111017", "story_v_out_106111.awb")

						arg_70_1:RecordAudio("106111017", var_73_28)
						arg_70_1:RecordAudio("106111017", var_73_28)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_106111", "106111017", "story_v_out_106111.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_106111", "106111017", "story_v_out_106111.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_29 = var_73_20 + 0.3
			local var_73_30 = math.max(var_73_21, arg_70_1.talkMaxDuration)

			if var_73_20 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_29 + var_73_30 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_29) / var_73_30

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_29 + var_73_30 and arg_70_1.time_ < var_73_29 + var_73_30 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0608",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play106111018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 106111018
		arg_76_1.duration_ = 9.23

		local var_76_0 = {
			ja = 9.233,
			ko = 6.1,
			zh = 7.666,
			en = 6.5
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play106111019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.725

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(106111018)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 29 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 29)

				if (29 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 29)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111018", "story_v_out_106111.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_106111", "106111018", "story_v_out_106111.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_106111", "106111018", "story_v_out_106111.awb")

						arg_76_1:RecordAudio("106111018", var_79_6)
						arg_76_1:RecordAudio("106111018", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_106111", "106111018", "story_v_out_106111.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_106111", "106111018", "story_v_out_106111.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play106111019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 106111019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
			arg_80_1.auto_ = false
		end

		function arg_80_1.playNext_(arg_82_0)
			arg_80_1.onStoryFinished_()
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["4014_tpose"]) and arg_80_1.var_.characterEffect4014_tpose == nil then
				arg_80_1.var_.characterEffect4014_tpose = arg_80_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["4014_tpose"]) then
				if arg_80_1.var_.characterEffect4014_tpose and not isNil(arg_80_1.actors_["4014_tpose"]) then
					arg_80_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_80_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["4014_tpose"]) and arg_80_1.var_.characterEffect4014_tpose then
				arg_80_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_80_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_83_1 = arg_80_1.actors_["4014_tpose"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos4014_tpose = var_83_1.localPosition

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_1.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end
			end

			local var_83_3 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 then
				var_83_1.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_3)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 then
				var_83_1.localPosition = Vector3.New(0, 100, 0)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles

				local var_83_4 = GameObjectTools.GetOrAddComponent(var_83_1.gameObject, typeof(DynamicBoneHelper))

				if var_83_4 then
					var_83_4:EnableDynamicBone(true)
				end
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_6", "se_story_6_summon_monster", "")
			end

			local var_83_6 = 0
			local var_83_7 = 1.425

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_8 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(106111019).content)

				arg_80_1.text_.text = var_83_8

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 57 <= 0 and var_83_7 or var_83_7 * (utf8.len(var_83_8) / 57)

				if (57 <= 0 and var_83_7 or var_83_7 * (utf8.len(var_83_8) / 57)) > 0 and var_83_7 < var_83_10 then
					arg_80_1.talkMaxDuration = var_83_10

					if var_83_10 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_8
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_11 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_11 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_11

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_11 and arg_80_1.time_ < var_83_6 + var_83_11 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C02b",
		"TextureConfig/Background/S0608"
	},
	voices = {
		"story_v_out_106111.awb"
	}
}
