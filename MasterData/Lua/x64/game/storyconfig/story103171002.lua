return {
	Play317102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317102001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K09f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09f")
				var_4_0.name = "K09f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K09f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K09f

				arg_1_1.bgs_.K09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K09f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 1.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317102001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 72 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 72)

				if (72 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 72)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play317102002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317102002
		arg_9_1.duration_ = 2.63

		local var_9_0 = {
			zh = 2.433,
			ja = 2.633
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317102003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1093ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1093ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1093ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1093ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1093ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1093ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1093ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1093ui_story == nil then
				arg_9_1.var_.characterEffect1093ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1093ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1093ui_story then
				arg_9_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = "1015ui_story"

			if arg_9_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_12_9 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_9_1.stage_.transform)

				var_12_9.name = var_12_8
				var_12_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_[var_12_8] = var_12_9

				local var_12_10 = var_12_9:GetComponentInChildren(typeof(CharacterEffect))

				var_12_10.enabled = true

				local var_12_11 = GameObjectTools.GetOrAddComponent(var_12_9, typeof(DynamicBoneHelper))

				if var_12_11 then
					var_12_11:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_10.transform, false)

				arg_9_1.var_[var_12_8 .. "Animator"] = var_12_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_[var_12_8 .. "Animator"].applyRootMotion = true
				arg_9_1.var_[var_12_8 .. "LipSync"] = var_12_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_12 = arg_9_1.actors_["1015ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1015ui_story = var_12_12.localPosition
			end

			local var_12_13 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_13 then
				var_12_12.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_9_1.time_ - 0) / var_12_13)
				var_12_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_12.position).x, (manager.ui.mainCamera.transform.position - var_12_12.position).y, (manager.ui.mainCamera.transform.position - var_12_12.position).z)
				var_12_12.localEulerAngles.z = 0
				var_12_12.localEulerAngles.x = 0
				var_12_12.localEulerAngles = var_12_12.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_13 and arg_9_1.time_ < 0 + var_12_13 + arg_12_0 then
				var_12_12.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_12_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_12.position).x, (manager.ui.mainCamera.transform.position - var_12_12.position).y, (manager.ui.mainCamera.transform.position - var_12_12.position).z)
				var_12_12.localEulerAngles.z = 0
				var_12_12.localEulerAngles.x = 0
				var_12_12.localEulerAngles = var_12_12.localEulerAngles
			end

			local var_12_14 = arg_9_1.actors_["1015ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1015ui_story == nil then
				arg_9_1.var_.characterEffect1015ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_15 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_15 and not isNil(var_12_14) then
				if arg_9_1.var_.characterEffect1015ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_15)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_15 and arg_9_1.time_ < 0 + var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1015ui_story then
				arg_9_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_12_16 = 0
			local var_12_17 = 0.275

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_18 = arg_9_1:GetWordFromCfg(317102002)
				local var_12_19 = arg_9_1:FormatText(var_12_18.content)

				arg_9_1.text_.text = var_12_19

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_21 = 11 <= 0 and var_12_17 or var_12_17 * (utf8.len(var_12_19) / 11)

				if (11 <= 0 and var_12_17 or var_12_17 * (utf8.len(var_12_19) / 11)) > 0 and var_12_17 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_16 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_16
					end
				end

				arg_9_1.text_.text = var_12_19
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102002", "story_v_out_317102.awb") ~= 0 then
					local var_12_22 = manager.audio:GetVoiceLength("story_v_out_317102", "317102002", "story_v_out_317102.awb") / 1000

					if var_12_22 + var_12_16 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_22 + var_12_16
					end

					if var_12_18.prefab_name ~= "" and arg_9_1.actors_[var_12_18.prefab_name] ~= nil then
						local var_12_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_18.prefab_name].transform, "story_v_out_317102", "317102002", "story_v_out_317102.awb")

						arg_9_1:RecordAudio("317102002", var_12_23)
						arg_9_1:RecordAudio("317102002", var_12_23)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317102", "317102002", "story_v_out_317102.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317102", "317102002", "story_v_out_317102.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_24 = math.max(var_12_17, arg_9_1.talkMaxDuration)

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_24 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_16) / var_12_24

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_16 + var_12_24 and arg_9_1.time_ < var_12_16 + var_12_24 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play317102003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317102003
		arg_13_1.duration_ = 4.3

		local var_13_0 = {
			zh = 4.033,
			ja = 4.3
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play317102004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1093ui_story = arg_13_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1093ui_story"].transform.position).z)
				arg_13_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1093ui_story"].transform.localEulerAngles = arg_13_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_13_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1093ui_story"].transform.position).z)
				arg_13_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1093ui_story"].transform.localEulerAngles = arg_13_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1093ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1093ui_story == nil then
				arg_13_1.var_.characterEffect1093ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1093ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_2)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1093ui_story then
				arg_13_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_16_3 = arg_13_1.actors_["1015ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1015ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1015ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1015ui_story == nil then
				arg_13_1.var_.characterEffect1015ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1015ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1015ui_story then
				arg_13_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.5

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(317102003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 20 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 20)

				if (20 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 20)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102003", "story_v_out_317102.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_317102", "317102003", "story_v_out_317102.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_317102", "317102003", "story_v_out_317102.awb")

						arg_13_1:RecordAudio("317102003", var_16_15)
						arg_13_1:RecordAudio("317102003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317102", "317102003", "story_v_out_317102.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317102", "317102003", "story_v_out_317102.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play317102004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317102004
		arg_17_1.duration_ = 6.5

		local var_17_0 = {
			zh = 6.166,
			ja = 6.5
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317102005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1015ui_story"]) and arg_17_1.var_.characterEffect1015ui_story == nil then
				arg_17_1.var_.characterEffect1015ui_story = arg_17_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1015ui_story"]) then
				if arg_17_1.var_.characterEffect1015ui_story and not isNil(arg_17_1.actors_["1015ui_story"]) then
					arg_17_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1015ui_story"]) and arg_17_1.var_.characterEffect1015ui_story then
				arg_17_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_20_1 = arg_17_1.actors_["1093ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1093ui_story == nil then
				arg_17_1.var_.characterEffect1093ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1093ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1093ui_story then
				arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_20_4 = 0
			local var_20_5 = 0.775

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(317102004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 31 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 31)

				if (31 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 31)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102004", "story_v_out_317102.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102004", "story_v_out_317102.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_317102", "317102004", "story_v_out_317102.awb")

						arg_17_1:RecordAudio("317102004", var_20_11)
						arg_17_1:RecordAudio("317102004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317102", "317102004", "story_v_out_317102.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317102", "317102004", "story_v_out_317102.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play317102005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317102005
		arg_21_1.duration_ = 7.67

		local var_21_0 = {
			zh = 7.666,
			ja = 3.033
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play317102006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1015ui_story"]) and arg_21_1.var_.characterEffect1015ui_story == nil then
				arg_21_1.var_.characterEffect1015ui_story = arg_21_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1015ui_story"]) then
				if arg_21_1.var_.characterEffect1015ui_story and not isNil(arg_21_1.actors_["1015ui_story"]) then
					arg_21_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1015ui_story"]) and arg_21_1.var_.characterEffect1015ui_story then
				arg_21_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_24_2 = arg_21_1.actors_["1093ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 0.875

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(317102005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 35 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 35)

				if (35 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 35)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102005", "story_v_out_317102.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102005", "story_v_out_317102.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_317102", "317102005", "story_v_out_317102.awb")

						arg_21_1:RecordAudio("317102005", var_24_11)
						arg_21_1:RecordAudio("317102005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317102", "317102005", "story_v_out_317102.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317102", "317102005", "story_v_out_317102.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play317102006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317102006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play317102007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1093ui_story = arg_25_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).z)
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles = arg_25_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).z)
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles = arg_25_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1093ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1093ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1093ui_story then
				arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_28_3 = arg_25_1.actors_["1015ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1015ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, 100, 0)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["1015ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1015ui_story == nil then
				arg_25_1.var_.characterEffect1015ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect1015ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_6)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1015ui_story then
				arg_25_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_28_7 = 0
			local var_28_8 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(317102006).content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 22 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_9) / 22)

				if (22 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_9) / 22)) > 0 and var_28_8 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_12 and arg_25_1.time_ < var_28_7 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play317102007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317102007
		arg_29_1.duration_ = 3.1

		local var_29_0 = {
			zh = 2.266,
			ja = 3.1
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play317102008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1093ui_story = arg_29_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1093ui_story"].transform.position).z)
				arg_29_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1093ui_story"].transform.localEulerAngles = arg_29_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_29_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1093ui_story"].transform.position).z)
				arg_29_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1093ui_story"].transform.localEulerAngles = arg_29_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1093ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1093ui_story == nil then
				arg_29_1.var_.characterEffect1093ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1093ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1093ui_story then
				arg_29_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_32_4 = arg_29_1.actors_["1015ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1015ui_story = var_32_4.localPosition
			end

			local var_32_5 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 then
				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_29_1.time_ - 0) / var_32_5)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			local var_32_6 = arg_29_1.actors_["1015ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1015ui_story == nil then
				arg_29_1.var_.characterEffect1015ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 and not isNil(var_32_6) then
				if arg_29_1.var_.characterEffect1015ui_story and not isNil(var_32_6) then
					arg_29_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_7)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1015ui_story then
				arg_29_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_32_8 = 0
			local var_32_9 = 0.275

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(317102007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 11 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 11)

				if (11 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 11)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102007", "story_v_out_317102.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_317102", "317102007", "story_v_out_317102.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_317102", "317102007", "story_v_out_317102.awb")

						arg_29_1:RecordAudio("317102007", var_32_15)
						arg_29_1:RecordAudio("317102007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317102", "317102007", "story_v_out_317102.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317102", "317102007", "story_v_out_317102.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play317102008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317102008
		arg_33_1.duration_ = 7.37

		local var_33_0 = {
			zh = 7.366,
			ja = 6.2
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play317102009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1093ui_story"]) and arg_33_1.var_.characterEffect1093ui_story == nil then
				arg_33_1.var_.characterEffect1093ui_story = arg_33_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1093ui_story"]) then
				if arg_33_1.var_.characterEffect1093ui_story and not isNil(arg_33_1.actors_["1093ui_story"]) then
					arg_33_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1093ui_story"]) and arg_33_1.var_.characterEffect1093ui_story then
				arg_33_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_36_1 = arg_33_1.actors_["1015ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1015ui_story == nil then
				arg_33_1.var_.characterEffect1015ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1015ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1015ui_story then
				arg_33_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_36_4 = 0
			local var_36_5 = 0.9

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(317102008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 36 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 36)

				if (36 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 36)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102008", "story_v_out_317102.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102008", "story_v_out_317102.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_317102", "317102008", "story_v_out_317102.awb")

						arg_33_1:RecordAudio("317102008", var_36_11)
						arg_33_1:RecordAudio("317102008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_317102", "317102008", "story_v_out_317102.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_317102", "317102008", "story_v_out_317102.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play317102009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317102009
		arg_37_1.duration_ = 2.7

		local var_37_0 = {
			zh = 2.266,
			ja = 2.7
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play317102010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1093ui_story"]) and arg_37_1.var_.characterEffect1093ui_story == nil then
				arg_37_1.var_.characterEffect1093ui_story = arg_37_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1093ui_story"]) then
				if arg_37_1.var_.characterEffect1093ui_story and not isNil(arg_37_1.actors_["1093ui_story"]) then
					arg_37_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1093ui_story"]) and arg_37_1.var_.characterEffect1093ui_story then
				arg_37_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_40_2 = arg_37_1.actors_["1015ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1015ui_story == nil then
				arg_37_1.var_.characterEffect1015ui_story = var_40_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.characterEffect1015ui_story and not isNil(var_40_2) then
					arg_37_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_3)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1015ui_story then
				arg_37_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_40_4 = 0
			local var_40_5 = 0.275

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(317102009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 11 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 11)

				if (11 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 11)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102009", "story_v_out_317102.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102009", "story_v_out_317102.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_317102", "317102009", "story_v_out_317102.awb")

						arg_37_1:RecordAudio("317102009", var_40_11)
						arg_37_1:RecordAudio("317102009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317102", "317102009", "story_v_out_317102.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317102", "317102009", "story_v_out_317102.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play317102010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317102010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play317102011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1093ui_story"]) and arg_41_1.var_.characterEffect1093ui_story == nil then
				arg_41_1.var_.characterEffect1093ui_story = arg_41_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1093ui_story"]) then
				if arg_41_1.var_.characterEffect1093ui_story and not isNil(arg_41_1.actors_["1093ui_story"]) then
					arg_41_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1093ui_story"]) and arg_41_1.var_.characterEffect1093ui_story then
				arg_41_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.55

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(317102010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 22 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 22)

				if (22 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 22)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play317102011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317102011
		arg_45_1.duration_ = 10.9

		local var_45_0 = {
			zh = 7.866,
			ja = 10.9
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play317102012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1015ui_story"]) and arg_45_1.var_.characterEffect1015ui_story == nil then
				arg_45_1.var_.characterEffect1015ui_story = arg_45_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1015ui_story"]) then
				if arg_45_1.var_.characterEffect1015ui_story and not isNil(arg_45_1.actors_["1015ui_story"]) then
					arg_45_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1015ui_story"]) and arg_45_1.var_.characterEffect1015ui_story then
				arg_45_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_48_2 = 0
			local var_48_3 = 0.55

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(317102011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 22 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 22)

				if (22 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 22)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102011", "story_v_out_317102.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_317102", "317102011", "story_v_out_317102.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_317102", "317102011", "story_v_out_317102.awb")

						arg_45_1:RecordAudio("317102011", var_48_9)
						arg_45_1:RecordAudio("317102011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_317102", "317102011", "story_v_out_317102.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_317102", "317102011", "story_v_out_317102.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_10 and arg_45_1.time_ < var_48_2 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play317102012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317102012
		arg_49_1.duration_ = 4.9

		local var_49_0 = {
			zh = 4.9,
			ja = 2.266
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play317102013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1093ui_story = arg_49_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1093ui_story"].transform.position).z)
				arg_49_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1093ui_story"].transform.localEulerAngles = arg_49_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_49_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1093ui_story"].transform.position).z)
				arg_49_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1093ui_story"].transform.localEulerAngles = arg_49_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1093ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1093ui_story == nil then
				arg_49_1.var_.characterEffect1093ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1093ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1093ui_story then
				arg_49_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_4 = arg_49_1.actors_["1015ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1015ui_story = var_52_4.localPosition
			end

			local var_52_5 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 then
				var_52_4.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_49_1.time_ - 0) / var_52_5)
				var_52_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_4.position).x, (manager.ui.mainCamera.transform.position - var_52_4.position).y, (manager.ui.mainCamera.transform.position - var_52_4.position).z)
				var_52_4.localEulerAngles.z = 0
				var_52_4.localEulerAngles.x = 0
				var_52_4.localEulerAngles = var_52_4.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 then
				var_52_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_52_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_4.position).x, (manager.ui.mainCamera.transform.position - var_52_4.position).y, (manager.ui.mainCamera.transform.position - var_52_4.position).z)
				var_52_4.localEulerAngles.z = 0
				var_52_4.localEulerAngles.x = 0
				var_52_4.localEulerAngles = var_52_4.localEulerAngles
			end

			local var_52_6 = arg_49_1.actors_["1015ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1015ui_story == nil then
				arg_49_1.var_.characterEffect1015ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_7 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 and not isNil(var_52_6) then
				if arg_49_1.var_.characterEffect1015ui_story and not isNil(var_52_6) then
					arg_49_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_7)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1015ui_story then
				arg_49_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_52_8 = 0
			local var_52_9 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(317102012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 24 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 24)

				if (24 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 24)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102012", "story_v_out_317102.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_317102", "317102012", "story_v_out_317102.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_317102", "317102012", "story_v_out_317102.awb")

						arg_49_1:RecordAudio("317102012", var_52_15)
						arg_49_1:RecordAudio("317102012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317102", "317102012", "story_v_out_317102.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317102", "317102012", "story_v_out_317102.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play317102013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317102013
		arg_53_1.duration_ = 5.5

		local var_53_0 = {
			zh = 2.9,
			ja = 5.5
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play317102014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1093ui_story"]) and arg_53_1.var_.characterEffect1093ui_story == nil then
				arg_53_1.var_.characterEffect1093ui_story = arg_53_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1093ui_story"]) then
				if arg_53_1.var_.characterEffect1093ui_story and not isNil(arg_53_1.actors_["1093ui_story"]) then
					arg_53_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1093ui_story"]) and arg_53_1.var_.characterEffect1093ui_story then
				arg_53_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_56_1 = arg_53_1.actors_["1015ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1015ui_story == nil then
				arg_53_1.var_.characterEffect1015ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1015ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1015ui_story then
				arg_53_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_56_4 = 0
			local var_56_5 = 0.3

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(317102013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 12 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 12)

				if (12 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 12)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102013", "story_v_out_317102.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102013", "story_v_out_317102.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_317102", "317102013", "story_v_out_317102.awb")

						arg_53_1:RecordAudio("317102013", var_56_11)
						arg_53_1:RecordAudio("317102013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_317102", "317102013", "story_v_out_317102.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_317102", "317102013", "story_v_out_317102.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play317102014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317102014
		arg_57_1.duration_ = 7.57

		local var_57_0 = {
			zh = 6.366,
			ja = 7.566
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play317102015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.7

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(317102014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 28 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 28)

				if (28 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 28)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102014", "story_v_out_317102.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102014", "story_v_out_317102.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_317102", "317102014", "story_v_out_317102.awb")

						arg_57_1:RecordAudio("317102014", var_60_6)
						arg_57_1:RecordAudio("317102014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317102", "317102014", "story_v_out_317102.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317102", "317102014", "story_v_out_317102.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play317102015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317102015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play317102016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1093ui_story"]) and arg_61_1.var_.characterEffect1093ui_story == nil then
				arg_61_1.var_.characterEffect1093ui_story = arg_61_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1093ui_story"]) then
				if arg_61_1.var_.characterEffect1093ui_story and not isNil(arg_61_1.actors_["1093ui_story"]) then
					arg_61_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1093ui_story"]) and arg_61_1.var_.characterEffect1093ui_story then
				arg_61_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_64_2 = arg_61_1.actors_["1015ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1015ui_story == nil then
				arg_61_1.var_.characterEffect1015ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1015ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1015ui_story then
				arg_61_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_64_4 = 0
			local var_64_5 = 0.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(317102015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 6 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 6)

				if (6 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 6)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102015", "story_v_out_317102.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102015", "story_v_out_317102.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_317102", "317102015", "story_v_out_317102.awb")

						arg_61_1:RecordAudio("317102015", var_64_11)
						arg_61_1:RecordAudio("317102015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_317102", "317102015", "story_v_out_317102.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_317102", "317102015", "story_v_out_317102.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play317102016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317102016
		arg_65_1.duration_ = 14.2

		local var_65_0 = {
			zh = 12.5,
			ja = 14.2
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play317102017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1093ui_story"]) and arg_65_1.var_.characterEffect1093ui_story == nil then
				arg_65_1.var_.characterEffect1093ui_story = arg_65_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1093ui_story"]) then
				if arg_65_1.var_.characterEffect1093ui_story and not isNil(arg_65_1.actors_["1093ui_story"]) then
					arg_65_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1093ui_story"]) and arg_65_1.var_.characterEffect1093ui_story then
				arg_65_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_68_1 = arg_65_1.actors_["1015ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1015ui_story == nil then
				arg_65_1.var_.characterEffect1015ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1015ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1015ui_story then
				arg_65_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_68_4 = 0
			local var_68_5 = 1.425

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(317102016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 57 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 57)

				if (57 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 57)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102016", "story_v_out_317102.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102016", "story_v_out_317102.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_317102", "317102016", "story_v_out_317102.awb")

						arg_65_1:RecordAudio("317102016", var_68_11)
						arg_65_1:RecordAudio("317102016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_317102", "317102016", "story_v_out_317102.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_317102", "317102016", "story_v_out_317102.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play317102017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317102017
		arg_69_1.duration_ = 4.4

		local var_69_0 = {
			zh = 3.066,
			ja = 4.4
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play317102018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1093ui_story = arg_69_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).z)
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles = arg_69_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_69_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).z)
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles = arg_69_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1093ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1093ui_story == nil then
				arg_69_1.var_.characterEffect1093ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1093ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1093ui_story then
				arg_69_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = arg_69_1.actors_["1015ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1015ui_story = var_72_4.localPosition
			end

			local var_72_5 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 then
				var_72_4.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_69_1.time_ - 0) / var_72_5)
				var_72_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_4.position).x, (manager.ui.mainCamera.transform.position - var_72_4.position).y, (manager.ui.mainCamera.transform.position - var_72_4.position).z)
				var_72_4.localEulerAngles.z = 0
				var_72_4.localEulerAngles.x = 0
				var_72_4.localEulerAngles = var_72_4.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 then
				var_72_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_72_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_4.position).x, (manager.ui.mainCamera.transform.position - var_72_4.position).y, (manager.ui.mainCamera.transform.position - var_72_4.position).z)
				var_72_4.localEulerAngles.z = 0
				var_72_4.localEulerAngles.x = 0
				var_72_4.localEulerAngles = var_72_4.localEulerAngles
			end

			local var_72_6 = arg_69_1.actors_["1015ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect1015ui_story == nil then
				arg_69_1.var_.characterEffect1015ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_7 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 and not isNil(var_72_6) then
				if arg_69_1.var_.characterEffect1015ui_story and not isNil(var_72_6) then
					arg_69_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_7)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect1015ui_story then
				arg_69_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_72_8 = 0
			local var_72_9 = 0.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(317102017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 10 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 10)

				if (10 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 10)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102017", "story_v_out_317102.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_317102", "317102017", "story_v_out_317102.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_317102", "317102017", "story_v_out_317102.awb")

						arg_69_1:RecordAudio("317102017", var_72_15)
						arg_69_1:RecordAudio("317102017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_317102", "317102017", "story_v_out_317102.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_317102", "317102017", "story_v_out_317102.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play317102018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317102018
		arg_73_1.duration_ = 2.97

		local var_73_0 = {
			zh = 2.066,
			ja = 2.966
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play317102019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1093ui_story"]) and arg_73_1.var_.characterEffect1093ui_story == nil then
				arg_73_1.var_.characterEffect1093ui_story = arg_73_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1093ui_story"]) then
				if arg_73_1.var_.characterEffect1093ui_story and not isNil(arg_73_1.actors_["1093ui_story"]) then
					arg_73_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1093ui_story"]) and arg_73_1.var_.characterEffect1093ui_story then
				arg_73_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_76_1 = arg_73_1.actors_["1015ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1015ui_story == nil then
				arg_73_1.var_.characterEffect1015ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1015ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1015ui_story then
				arg_73_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_76_4 = 0
			local var_76_5 = 0.175

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(317102018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 7 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 7)

				if (7 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 7)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102018", "story_v_out_317102.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102018", "story_v_out_317102.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_317102", "317102018", "story_v_out_317102.awb")

						arg_73_1:RecordAudio("317102018", var_76_11)
						arg_73_1:RecordAudio("317102018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_317102", "317102018", "story_v_out_317102.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_317102", "317102018", "story_v_out_317102.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play317102019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317102019
		arg_77_1.duration_ = 18.23

		local var_77_0 = {
			zh = 18.233,
			ja = 13.4
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play317102020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 2.225

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(317102019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 89 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 89)

				if (89 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 89)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102019", "story_v_out_317102.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102019", "story_v_out_317102.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_317102", "317102019", "story_v_out_317102.awb")

						arg_77_1:RecordAudio("317102019", var_80_6)
						arg_77_1:RecordAudio("317102019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_317102", "317102019", "story_v_out_317102.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_317102", "317102019", "story_v_out_317102.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play317102020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317102020
		arg_81_1.duration_ = 6.43

		local var_81_0 = {
			zh = 5.233,
			ja = 6.433
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play317102021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1093ui_story"]) and arg_81_1.var_.characterEffect1093ui_story == nil then
				arg_81_1.var_.characterEffect1093ui_story = arg_81_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1093ui_story"]) then
				if arg_81_1.var_.characterEffect1093ui_story and not isNil(arg_81_1.actors_["1093ui_story"]) then
					arg_81_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1093ui_story"]) and arg_81_1.var_.characterEffect1093ui_story then
				arg_81_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["1015ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1015ui_story == nil then
				arg_81_1.var_.characterEffect1015ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1015ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1015ui_story then
				arg_81_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_84_4 = 0
			local var_84_5 = 0.6

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(317102020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 24 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 24)

				if (24 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 24)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102020", "story_v_out_317102.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102020", "story_v_out_317102.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_317102", "317102020", "story_v_out_317102.awb")

						arg_81_1:RecordAudio("317102020", var_84_11)
						arg_81_1:RecordAudio("317102020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_317102", "317102020", "story_v_out_317102.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_317102", "317102020", "story_v_out_317102.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play317102021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 317102021
		arg_85_1.duration_ = 15.03

		local var_85_0 = {
			zh = 14.466,
			ja = 15.033
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play317102022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1093ui_story = arg_85_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).z)
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles = arg_85_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_85_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).z)
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles = arg_85_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1093ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1093ui_story == nil then
				arg_85_1.var_.characterEffect1093ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1093ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_2)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1093ui_story then
				arg_85_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_88_3 = arg_85_1.actors_["1015ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1015ui_story = var_88_3.localPosition
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_3.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_85_1.time_ - 0) / var_88_4)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			local var_88_5 = arg_85_1.actors_["1015ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect1015ui_story == nil then
				arg_85_1.var_.characterEffect1015ui_story = var_88_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_6 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.characterEffect1015ui_story and not isNil(var_88_5) then
					arg_85_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect1015ui_story then
				arg_85_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_88_8 = 0
			local var_88_9 = 1.525

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(317102021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 61 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 61)

				if (61 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 61)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102021", "story_v_out_317102.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_317102", "317102021", "story_v_out_317102.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_317102", "317102021", "story_v_out_317102.awb")

						arg_85_1:RecordAudio("317102021", var_88_15)
						arg_85_1:RecordAudio("317102021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_317102", "317102021", "story_v_out_317102.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_317102", "317102021", "story_v_out_317102.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play317102022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 317102022
		arg_89_1.duration_ = 9.7

		local var_89_0 = {
			zh = 9.7,
			ja = 8.933
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play317102023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_0 = 0
			local var_92_1 = 1.1

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(317102022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 44 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 44)

				if (44 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 44)) > 0 and var_92_1 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102022", "story_v_out_317102.awb") ~= 0 then
					local var_92_6 = manager.audio:GetVoiceLength("story_v_out_317102", "317102022", "story_v_out_317102.awb") / 1000

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end

					if var_92_2.prefab_name ~= "" and arg_89_1.actors_[var_92_2.prefab_name] ~= nil then
						local var_92_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_2.prefab_name].transform, "story_v_out_317102", "317102022", "story_v_out_317102.awb")

						arg_89_1:RecordAudio("317102022", var_92_7)
						arg_89_1:RecordAudio("317102022", var_92_7)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_317102", "317102022", "story_v_out_317102.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_317102", "317102022", "story_v_out_317102.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play317102023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 317102023
		arg_93_1.duration_ = 13.6

		local var_93_0 = {
			zh = 13.6,
			ja = 12.3
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play317102024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.625

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(317102023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 65 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 65)

				if (65 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 65)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102023", "story_v_out_317102.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102023", "story_v_out_317102.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_317102", "317102023", "story_v_out_317102.awb")

						arg_93_1:RecordAudio("317102023", var_96_6)
						arg_93_1:RecordAudio("317102023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_317102", "317102023", "story_v_out_317102.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_317102", "317102023", "story_v_out_317102.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play317102024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 317102024
		arg_97_1.duration_ = 7.93

		local var_97_0 = {
			zh = 5.9,
			ja = 7.933
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play317102025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			local var_100_0 = arg_97_1.actors_["1093ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1093ui_story == nil then
				arg_97_1.var_.characterEffect1093ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_1 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 and not isNil(var_100_0) then
				if arg_97_1.var_.characterEffect1093ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1093ui_story then
				arg_97_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_100_3 = arg_97_1.actors_["1015ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect1015ui_story == nil then
				arg_97_1.var_.characterEffect1015ui_story = var_100_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_4 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 and not isNil(var_100_3) then
				if arg_97_1.var_.characterEffect1015ui_story and not isNil(var_100_3) then
					arg_97_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_4)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect1015ui_story then
				arg_97_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_100_5 = 0
			local var_100_6 = 0.625

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:GetWordFromCfg(317102024)
				local var_100_8 = arg_97_1:FormatText(var_100_7.content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 25 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 25)

				if (25 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 25)) > 0 and var_100_6 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102024", "story_v_out_317102.awb") ~= 0 then
					local var_100_11 = manager.audio:GetVoiceLength("story_v_out_317102", "317102024", "story_v_out_317102.awb") / 1000

					if var_100_11 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_5
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_317102", "317102024", "story_v_out_317102.awb")

						arg_97_1:RecordAudio("317102024", var_100_12)
						arg_97_1:RecordAudio("317102024", var_100_12)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_317102", "317102024", "story_v_out_317102.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_317102", "317102024", "story_v_out_317102.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_13 and arg_97_1.time_ < var_100_5 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play317102025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 317102025
		arg_101_1.duration_ = 3.07

		local var_101_0 = {
			zh = 3.066,
			ja = 2.6
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play317102026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1093ui_story = arg_101_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).z)
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles = arg_101_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_101_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).z)
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles = arg_101_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1093ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1093ui_story == nil then
				arg_101_1.var_.characterEffect1093ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1093ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_2)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1093ui_story then
				arg_101_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_104_3 = arg_101_1.actors_["1015ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1015ui_story = var_104_3.localPosition
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_3.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_101_1.time_ - 0) / var_104_4)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			local var_104_5 = arg_101_1.actors_["1015ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1015ui_story == nil then
				arg_101_1.var_.characterEffect1015ui_story = var_104_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_6 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.characterEffect1015ui_story and not isNil(var_104_5) then
					arg_101_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1015ui_story then
				arg_101_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_8 = 0
			local var_104_9 = 0.35

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(317102025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 14 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 14)

				if (14 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 14)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102025", "story_v_out_317102.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_317102", "317102025", "story_v_out_317102.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_317102", "317102025", "story_v_out_317102.awb")

						arg_101_1:RecordAudio("317102025", var_104_15)
						arg_101_1:RecordAudio("317102025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_317102", "317102025", "story_v_out_317102.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_317102", "317102025", "story_v_out_317102.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play317102026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 317102026
		arg_105_1.duration_ = 14.7

		local var_105_0 = {
			zh = 12.166,
			ja = 14.7
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play317102027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.375

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(317102026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 55 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 55)

				if (55 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 55)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102026", "story_v_out_317102.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102026", "story_v_out_317102.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_317102", "317102026", "story_v_out_317102.awb")

						arg_105_1:RecordAudio("317102026", var_108_6)
						arg_105_1:RecordAudio("317102026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_317102", "317102026", "story_v_out_317102.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_317102", "317102026", "story_v_out_317102.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play317102027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 317102027
		arg_109_1.duration_ = 17.3

		local var_109_0 = {
			zh = 17.3,
			ja = 14.6
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play317102028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.75

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(317102027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 70 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 70)

				if (70 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 70)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102027", "story_v_out_317102.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102027", "story_v_out_317102.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_317102", "317102027", "story_v_out_317102.awb")

						arg_109_1:RecordAudio("317102027", var_112_6)
						arg_109_1:RecordAudio("317102027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_317102", "317102027", "story_v_out_317102.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_317102", "317102027", "story_v_out_317102.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play317102028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 317102028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play317102029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1015ui_story"]) and arg_113_1.var_.characterEffect1015ui_story == nil then
				arg_113_1.var_.characterEffect1015ui_story = arg_113_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1015ui_story"]) then
				if arg_113_1.var_.characterEffect1015ui_story and not isNil(arg_113_1.actors_["1015ui_story"]) then
					arg_113_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1015ui_story"]) and arg_113_1.var_.characterEffect1015ui_story then
				arg_113_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.925

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(317102028).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 37 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 37)

				if (37 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 37)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play317102029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 317102029
		arg_117_1.duration_ = 5.2

		local var_117_0 = {
			zh = 3.133,
			ja = 5.2
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play317102030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1093ui_story"]) and arg_117_1.var_.characterEffect1093ui_story == nil then
				arg_117_1.var_.characterEffect1093ui_story = arg_117_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1093ui_story"]) then
				if arg_117_1.var_.characterEffect1093ui_story and not isNil(arg_117_1.actors_["1093ui_story"]) then
					arg_117_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1093ui_story"]) and arg_117_1.var_.characterEffect1093ui_story then
				arg_117_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_120_2 = 0
			local var_120_3 = 0.3

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(317102029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 12 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 12)

				if (12 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 12)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102029", "story_v_out_317102.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_317102", "317102029", "story_v_out_317102.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_317102", "317102029", "story_v_out_317102.awb")

						arg_117_1:RecordAudio("317102029", var_120_9)
						arg_117_1:RecordAudio("317102029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_317102", "317102029", "story_v_out_317102.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_317102", "317102029", "story_v_out_317102.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play317102030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 317102030
		arg_121_1.duration_ = 3.77

		local var_121_0 = {
			zh = 3.766,
			ja = 3
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play317102031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1093ui_story = arg_121_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).z)
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles = arg_121_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).z)
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles = arg_121_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1093ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1093ui_story == nil then
				arg_121_1.var_.characterEffect1093ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1093ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1093ui_story then
				arg_121_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_124_3 = arg_121_1.actors_["1015ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1015ui_story = var_124_3.localPosition
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_4)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(0, 100, 0)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			local var_124_5 = arg_121_1.actors_["1015ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect1015ui_story == nil then
				arg_121_1.var_.characterEffect1015ui_story = var_124_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.characterEffect1015ui_story and not isNil(var_124_5) then
					arg_121_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_6)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect1015ui_story then
				arg_121_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_124_7 = "2078ui_story"

			if arg_121_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_124_8 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_121_1.stage_.transform)

				var_124_8.name = var_124_7
				var_124_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_[var_124_7] = var_124_8

				local var_124_9 = var_124_8:GetComponentInChildren(typeof(CharacterEffect))

				var_124_9.enabled = true

				local var_124_10 = GameObjectTools.GetOrAddComponent(var_124_8, typeof(DynamicBoneHelper))

				if var_124_10 then
					var_124_10:EnableDynamicBone(false)
				end

				arg_121_1:ShowWeapon(var_124_9.transform, false)

				arg_121_1.var_[var_124_7 .. "Animator"] = var_124_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_121_1.var_[var_124_7 .. "Animator"].applyRootMotion = true
				arg_121_1.var_[var_124_7 .. "LipSync"] = var_124_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_124_11 = arg_121_1.actors_["2078ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos2078ui_story = var_124_11.localPosition
			end

			local var_124_12 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_12 then
				var_124_11.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_121_1.time_ - 0) / var_124_12)
				var_124_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_11.position).x, (manager.ui.mainCamera.transform.position - var_124_11.position).y, (manager.ui.mainCamera.transform.position - var_124_11.position).z)
				var_124_11.localEulerAngles.z = 0
				var_124_11.localEulerAngles.x = 0
				var_124_11.localEulerAngles = var_124_11.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_12 and arg_121_1.time_ < 0 + var_124_12 + arg_124_0 then
				var_124_11.localPosition = Vector3.New(0, -1.28, -5.6)
				var_124_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_11.position).x, (manager.ui.mainCamera.transform.position - var_124_11.position).y, (manager.ui.mainCamera.transform.position - var_124_11.position).z)
				var_124_11.localEulerAngles.z = 0
				var_124_11.localEulerAngles.x = 0
				var_124_11.localEulerAngles = var_124_11.localEulerAngles
			end

			local var_124_13 = arg_121_1.actors_["2078ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_13) and arg_121_1.var_.characterEffect2078ui_story == nil then
				arg_121_1.var_.characterEffect2078ui_story = var_124_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_14 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_14 and not isNil(var_124_13) then
				if arg_121_1.var_.characterEffect2078ui_story and not isNil(var_124_13) then
					arg_121_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_14 and arg_121_1.time_ < 0 + var_124_14 + arg_124_0 and not isNil(var_124_13) and arg_121_1.var_.characterEffect2078ui_story then
				arg_121_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_16 = 0
			local var_124_17 = 0.4

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(317102030)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_21 = 16 <= 0 and var_124_17 or var_124_17 * (utf8.len(var_124_19) / 16)

				if (16 <= 0 and var_124_17 or var_124_17 * (utf8.len(var_124_19) / 16)) > 0 and var_124_17 < var_124_21 then
					arg_121_1.talkMaxDuration = var_124_21

					if var_124_21 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_21 + var_124_16
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102030", "story_v_out_317102.awb") ~= 0 then
					local var_124_22 = manager.audio:GetVoiceLength("story_v_out_317102", "317102030", "story_v_out_317102.awb") / 1000

					if var_124_22 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_16
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_317102", "317102030", "story_v_out_317102.awb")

						arg_121_1:RecordAudio("317102030", var_124_23)
						arg_121_1:RecordAudio("317102030", var_124_23)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_317102", "317102030", "story_v_out_317102.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_317102", "317102030", "story_v_out_317102.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_24 = math.max(var_124_17, arg_121_1.talkMaxDuration)

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_24 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_16) / var_124_24

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_16 + var_124_24 and arg_121_1.time_ < var_124_16 + var_124_24 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play317102031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 317102031
		arg_125_1.duration_ = 11.43

		local var_125_0 = {
			zh = 7.933,
			ja = 11.433
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play317102032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1093ui_story = arg_125_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).z)
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles = arg_125_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_125_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).z)
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles = arg_125_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1093ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1093ui_story == nil then
				arg_125_1.var_.characterEffect1093ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1093ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_2)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1093ui_story then
				arg_125_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_128_3 = arg_125_1.actors_["1015ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1015ui_story = var_128_3.localPosition
			end

			local var_128_4 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				var_128_3.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_125_1.time_ - 0) / var_128_4)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				var_128_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			local var_128_5 = arg_125_1.actors_["1015ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1015ui_story == nil then
				arg_125_1.var_.characterEffect1015ui_story = var_128_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.characterEffect1015ui_story and not isNil(var_128_5) then
					arg_125_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1015ui_story then
				arg_125_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_8 = arg_125_1.actors_["2078ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos2078ui_story = var_128_8.localPosition
			end

			local var_128_9 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_9 then
				var_128_8.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_9)
				var_128_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_8.position).x, (manager.ui.mainCamera.transform.position - var_128_8.position).y, (manager.ui.mainCamera.transform.position - var_128_8.position).z)
				var_128_8.localEulerAngles.z = 0
				var_128_8.localEulerAngles.x = 0
				var_128_8.localEulerAngles = var_128_8.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_9 and arg_125_1.time_ < 0 + var_128_9 + arg_128_0 then
				var_128_8.localPosition = Vector3.New(0, 100, 0)
				var_128_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_8.position).x, (manager.ui.mainCamera.transform.position - var_128_8.position).y, (manager.ui.mainCamera.transform.position - var_128_8.position).z)
				var_128_8.localEulerAngles.z = 0
				var_128_8.localEulerAngles.x = 0
				var_128_8.localEulerAngles = var_128_8.localEulerAngles
			end

			local var_128_10 = arg_125_1.actors_["2078ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_10) and arg_125_1.var_.characterEffect2078ui_story == nil then
				arg_125_1.var_.characterEffect2078ui_story = var_128_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_11 and not isNil(var_128_10) then
				if arg_125_1.var_.characterEffect2078ui_story and not isNil(var_128_10) then
					arg_125_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_125_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_11)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_11 and arg_125_1.time_ < 0 + var_128_11 + arg_128_0 and not isNil(var_128_10) and arg_125_1.var_.characterEffect2078ui_story then
				arg_125_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_125_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_128_12 = 0
			local var_128_13 = 0.975

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_14 = arg_125_1:GetWordFromCfg(317102031)
				local var_128_15 = arg_125_1:FormatText(var_128_14.content)

				arg_125_1.text_.text = var_128_15

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 39 <= 0 and var_128_13 or var_128_13 * (utf8.len(var_128_15) / 39)

				if (39 <= 0 and var_128_13 or var_128_13 * (utf8.len(var_128_15) / 39)) > 0 and var_128_13 < var_128_17 then
					arg_125_1.talkMaxDuration = var_128_17

					if var_128_17 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_17 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_15
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102031", "story_v_out_317102.awb") ~= 0 then
					local var_128_18 = manager.audio:GetVoiceLength("story_v_out_317102", "317102031", "story_v_out_317102.awb") / 1000

					if var_128_18 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_12
					end

					if var_128_14.prefab_name ~= "" and arg_125_1.actors_[var_128_14.prefab_name] ~= nil then
						local var_128_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_14.prefab_name].transform, "story_v_out_317102", "317102031", "story_v_out_317102.awb")

						arg_125_1:RecordAudio("317102031", var_128_19)
						arg_125_1:RecordAudio("317102031", var_128_19)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_317102", "317102031", "story_v_out_317102.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_317102", "317102031", "story_v_out_317102.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_20 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_20 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_12) / var_128_20

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_12 + var_128_20 and arg_125_1.time_ < var_128_12 + var_128_20 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play317102032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 317102032
		arg_129_1.duration_ = 9.43

		local var_129_0 = {
			zh = 7.733,
			ja = 9.433
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play317102033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1093ui_story"]) and arg_129_1.var_.characterEffect1093ui_story == nil then
				arg_129_1.var_.characterEffect1093ui_story = arg_129_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1093ui_story"]) then
				if arg_129_1.var_.characterEffect1093ui_story and not isNil(arg_129_1.actors_["1093ui_story"]) then
					arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1093ui_story"]) and arg_129_1.var_.characterEffect1093ui_story then
				arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_132_2 = arg_129_1.actors_["1015ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1015ui_story == nil then
				arg_129_1.var_.characterEffect1015ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect1015ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1015ui_story then
				arg_129_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_132_4 = 0
			local var_132_5 = 1.025

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(317102032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 41 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 41)

				if (41 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 41)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102032", "story_v_out_317102.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102032", "story_v_out_317102.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_317102", "317102032", "story_v_out_317102.awb")

						arg_129_1:RecordAudio("317102032", var_132_11)
						arg_129_1:RecordAudio("317102032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_317102", "317102032", "story_v_out_317102.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_317102", "317102032", "story_v_out_317102.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play317102033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 317102033
		arg_133_1.duration_ = 5.47

		local var_133_0 = {
			zh = 4.533,
			ja = 5.466
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play317102034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1093ui_story"]) and arg_133_1.var_.characterEffect1093ui_story == nil then
				arg_133_1.var_.characterEffect1093ui_story = arg_133_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1093ui_story"]) then
				if arg_133_1.var_.characterEffect1093ui_story and not isNil(arg_133_1.actors_["1093ui_story"]) then
					arg_133_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1093ui_story"]) and arg_133_1.var_.characterEffect1093ui_story then
				arg_133_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_136_1 = arg_133_1.actors_["1015ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1015ui_story == nil then
				arg_133_1.var_.characterEffect1015ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1015ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1015ui_story then
				arg_133_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_136_4 = 0
			local var_136_5 = 0.525

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(317102033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 21 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 21)

				if (21 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 21)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102033", "story_v_out_317102.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102033", "story_v_out_317102.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_317102", "317102033", "story_v_out_317102.awb")

						arg_133_1:RecordAudio("317102033", var_136_11)
						arg_133_1:RecordAudio("317102033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_317102", "317102033", "story_v_out_317102.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_317102", "317102033", "story_v_out_317102.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play317102034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 317102034
		arg_137_1.duration_ = 2.6

		local var_137_0 = {
			zh = 1.766,
			ja = 2.6
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play317102035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1093ui_story"]) and arg_137_1.var_.characterEffect1093ui_story == nil then
				arg_137_1.var_.characterEffect1093ui_story = arg_137_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1093ui_story"]) then
				if arg_137_1.var_.characterEffect1093ui_story and not isNil(arg_137_1.actors_["1093ui_story"]) then
					arg_137_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1093ui_story"]) and arg_137_1.var_.characterEffect1093ui_story then
				arg_137_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_140_2 = arg_137_1.actors_["1015ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1015ui_story == nil then
				arg_137_1.var_.characterEffect1015ui_story = var_140_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_3 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.characterEffect1015ui_story and not isNil(var_140_2) then
					arg_137_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_3)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1015ui_story then
				arg_137_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_140_4 = 0
			local var_140_5 = 0.2

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(317102034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 8 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 8)

				if (8 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 8)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102034", "story_v_out_317102.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102034", "story_v_out_317102.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_317102", "317102034", "story_v_out_317102.awb")

						arg_137_1:RecordAudio("317102034", var_140_11)
						arg_137_1:RecordAudio("317102034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_317102", "317102034", "story_v_out_317102.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_317102", "317102034", "story_v_out_317102.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play317102035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 317102035
		arg_141_1.duration_ = 13.37

		local var_141_0 = {
			zh = 8.5,
			ja = 13.366
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play317102036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1093ui_story = arg_141_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).z)
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles = arg_141_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_141_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).z)
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles = arg_141_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1093ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1093ui_story == nil then
				arg_141_1.var_.characterEffect1093ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1093ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_2)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1093ui_story then
				arg_141_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_144_3 = arg_141_1.actors_["1015ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1015ui_story = var_144_3.localPosition
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_3.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_141_1.time_ - 0) / var_144_4)
				var_144_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_3.position).x, (manager.ui.mainCamera.transform.position - var_144_3.position).y, (manager.ui.mainCamera.transform.position - var_144_3.position).z)
				var_144_3.localEulerAngles.z = 0
				var_144_3.localEulerAngles.x = 0
				var_144_3.localEulerAngles = var_144_3.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_144_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_3.position).x, (manager.ui.mainCamera.transform.position - var_144_3.position).y, (manager.ui.mainCamera.transform.position - var_144_3.position).z)
				var_144_3.localEulerAngles.z = 0
				var_144_3.localEulerAngles.x = 0
				var_144_3.localEulerAngles = var_144_3.localEulerAngles
			end

			local var_144_5 = arg_141_1.actors_["1015ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.characterEffect1015ui_story == nil then
				arg_141_1.var_.characterEffect1015ui_story = var_144_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 and not isNil(var_144_5) then
				if arg_141_1.var_.characterEffect1015ui_story and not isNil(var_144_5) then
					arg_141_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.characterEffect1015ui_story then
				arg_141_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_8 = 0
			local var_144_9 = 1.1

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(317102035)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 44 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 44)

				if (44 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 44)) > 0 and var_144_9 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102035", "story_v_out_317102.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_317102", "317102035", "story_v_out_317102.awb") / 1000

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end

					if var_144_10.prefab_name ~= "" and arg_141_1.actors_[var_144_10.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_10.prefab_name].transform, "story_v_out_317102", "317102035", "story_v_out_317102.awb")

						arg_141_1:RecordAudio("317102035", var_144_15)
						arg_141_1:RecordAudio("317102035", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_317102", "317102035", "story_v_out_317102.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_317102", "317102035", "story_v_out_317102.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_16 and arg_141_1.time_ < var_144_8 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play317102036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 317102036
		arg_145_1.duration_ = 9.1

		local var_145_0 = {
			zh = 7.533,
			ja = 9.1
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play317102037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.85

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(317102036)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 34 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 34)

				if (34 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 34)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102036", "story_v_out_317102.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102036", "story_v_out_317102.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_317102", "317102036", "story_v_out_317102.awb")

						arg_145_1:RecordAudio("317102036", var_148_6)
						arg_145_1:RecordAudio("317102036", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_317102", "317102036", "story_v_out_317102.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_317102", "317102036", "story_v_out_317102.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play317102037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 317102037
		arg_149_1.duration_ = 12.6

		local var_149_0 = {
			zh = 6.266,
			ja = 12.6
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play317102038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.8

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(317102037)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 32 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 32)

				if (32 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 32)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102037", "story_v_out_317102.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102037", "story_v_out_317102.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_317102", "317102037", "story_v_out_317102.awb")

						arg_149_1:RecordAudio("317102037", var_152_6)
						arg_149_1:RecordAudio("317102037", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_317102", "317102037", "story_v_out_317102.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_317102", "317102037", "story_v_out_317102.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play317102038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 317102038
		arg_153_1.duration_ = 17.03

		local var_153_0 = {
			zh = 12.533,
			ja = 17.033
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play317102039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1093ui_story"]) and arg_153_1.var_.characterEffect1093ui_story == nil then
				arg_153_1.var_.characterEffect1093ui_story = arg_153_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1093ui_story"]) then
				if arg_153_1.var_.characterEffect1093ui_story and not isNil(arg_153_1.actors_["1093ui_story"]) then
					arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1093ui_story"]) and arg_153_1.var_.characterEffect1093ui_story then
				arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_156_2 = arg_153_1.actors_["1015ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1015ui_story == nil then
				arg_153_1.var_.characterEffect1015ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect1015ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1015ui_story then
				arg_153_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_156_4 = 0
			local var_156_5 = 1.25

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(317102038)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 50 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 50)

				if (50 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 50)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102038", "story_v_out_317102.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102038", "story_v_out_317102.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_317102", "317102038", "story_v_out_317102.awb")

						arg_153_1:RecordAudio("317102038", var_156_11)
						arg_153_1:RecordAudio("317102038", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_317102", "317102038", "story_v_out_317102.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_317102", "317102038", "story_v_out_317102.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play317102039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 317102039
		arg_157_1.duration_ = 8.8

		local var_157_0 = {
			zh = 5.333,
			ja = 8.8
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play317102040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.6

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(317102039)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 24 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 24)

				if (24 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 24)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102039", "story_v_out_317102.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102039", "story_v_out_317102.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_317102", "317102039", "story_v_out_317102.awb")

						arg_157_1:RecordAudio("317102039", var_160_6)
						arg_157_1:RecordAudio("317102039", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_317102", "317102039", "story_v_out_317102.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_317102", "317102039", "story_v_out_317102.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play317102040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 317102040
		arg_161_1.duration_ = 4.17

		local var_161_0 = {
			zh = 4.066,
			ja = 4.166
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play317102041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1093ui_story = arg_161_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).z)
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles = arg_161_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_161_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).z)
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles = arg_161_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1093ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1093ui_story == nil then
				arg_161_1.var_.characterEffect1093ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1093ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1093ui_story then
				arg_161_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_4 = arg_161_1.actors_["1015ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1015ui_story = var_164_4.localPosition
			end

			local var_164_5 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_5 then
				var_164_4.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_161_1.time_ - 0) / var_164_5)
				var_164_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_4.position).x, (manager.ui.mainCamera.transform.position - var_164_4.position).y, (manager.ui.mainCamera.transform.position - var_164_4.position).z)
				var_164_4.localEulerAngles.z = 0
				var_164_4.localEulerAngles.x = 0
				var_164_4.localEulerAngles = var_164_4.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_5 and arg_161_1.time_ < 0 + var_164_5 + arg_164_0 then
				var_164_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_164_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_4.position).x, (manager.ui.mainCamera.transform.position - var_164_4.position).y, (manager.ui.mainCamera.transform.position - var_164_4.position).z)
				var_164_4.localEulerAngles.z = 0
				var_164_4.localEulerAngles.x = 0
				var_164_4.localEulerAngles = var_164_4.localEulerAngles
			end

			local var_164_6 = arg_161_1.actors_["1015ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect1015ui_story == nil then
				arg_161_1.var_.characterEffect1015ui_story = var_164_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_7 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 and not isNil(var_164_6) then
				if arg_161_1.var_.characterEffect1015ui_story and not isNil(var_164_6) then
					arg_161_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_7)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect1015ui_story then
				arg_161_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_164_8 = 0
			local var_164_9 = 0.4

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(317102040)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 16 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 16)

				if (16 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 16)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102040", "story_v_out_317102.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_317102", "317102040", "story_v_out_317102.awb") / 1000

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end

					if var_164_10.prefab_name ~= "" and arg_161_1.actors_[var_164_10.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_10.prefab_name].transform, "story_v_out_317102", "317102040", "story_v_out_317102.awb")

						arg_161_1:RecordAudio("317102040", var_164_15)
						arg_161_1:RecordAudio("317102040", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_317102", "317102040", "story_v_out_317102.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_317102", "317102040", "story_v_out_317102.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_16 and arg_161_1.time_ < var_164_8 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play317102041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 317102041
		arg_165_1.duration_ = 8.8

		local var_165_0 = {
			zh = 8.8,
			ja = 5.133
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play317102042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1093ui_story"]) and arg_165_1.var_.characterEffect1093ui_story == nil then
				arg_165_1.var_.characterEffect1093ui_story = arg_165_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1093ui_story"]) then
				if arg_165_1.var_.characterEffect1093ui_story and not isNil(arg_165_1.actors_["1093ui_story"]) then
					arg_165_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1093ui_story"]) and arg_165_1.var_.characterEffect1093ui_story then
				arg_165_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_168_1 = arg_165_1.actors_["1015ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1015ui_story == nil then
				arg_165_1.var_.characterEffect1015ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1015ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1015ui_story then
				arg_165_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_168_4 = 0
			local var_168_5 = 0.95

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(317102041)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 38 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 38)

				if (38 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 38)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102041", "story_v_out_317102.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102041", "story_v_out_317102.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_317102", "317102041", "story_v_out_317102.awb")

						arg_165_1:RecordAudio("317102041", var_168_11)
						arg_165_1:RecordAudio("317102041", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_317102", "317102041", "story_v_out_317102.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_317102", "317102041", "story_v_out_317102.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play317102042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 317102042
		arg_169_1.duration_ = 2.4

		local var_169_0 = {
			zh = 2.166,
			ja = 2.4
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play317102043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1093ui_story"]) and arg_169_1.var_.characterEffect1093ui_story == nil then
				arg_169_1.var_.characterEffect1093ui_story = arg_169_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1093ui_story"]) then
				if arg_169_1.var_.characterEffect1093ui_story and not isNil(arg_169_1.actors_["1093ui_story"]) then
					arg_169_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1093ui_story"]) and arg_169_1.var_.characterEffect1093ui_story then
				arg_169_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_172_2 = arg_169_1.actors_["1015ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1015ui_story == nil then
				arg_169_1.var_.characterEffect1015ui_story = var_172_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_3 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.characterEffect1015ui_story and not isNil(var_172_2) then
					arg_169_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_3)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1015ui_story then
				arg_169_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_172_4 = 0
			local var_172_5 = 0.325

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(317102042)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 13 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 13)

				if (13 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 13)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102042", "story_v_out_317102.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102042", "story_v_out_317102.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_317102", "317102042", "story_v_out_317102.awb")

						arg_169_1:RecordAudio("317102042", var_172_11)
						arg_169_1:RecordAudio("317102042", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_317102", "317102042", "story_v_out_317102.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_317102", "317102042", "story_v_out_317102.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play317102043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 317102043
		arg_173_1.duration_ = 6.07

		local var_173_0 = {
			zh = 6.033,
			ja = 6.066
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play317102044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1093ui_story"]) and arg_173_1.var_.characterEffect1093ui_story == nil then
				arg_173_1.var_.characterEffect1093ui_story = arg_173_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1093ui_story"]) then
				if arg_173_1.var_.characterEffect1093ui_story and not isNil(arg_173_1.actors_["1093ui_story"]) then
					arg_173_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1093ui_story"]) and arg_173_1.var_.characterEffect1093ui_story then
				arg_173_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_176_1 = arg_173_1.actors_["1015ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1015ui_story == nil then
				arg_173_1.var_.characterEffect1015ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1015ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1015ui_story then
				arg_173_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_176_4 = 0
			local var_176_5 = 0.625

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(317102043)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 25 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 25)

				if (25 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 25)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102043", "story_v_out_317102.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102043", "story_v_out_317102.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_317102", "317102043", "story_v_out_317102.awb")

						arg_173_1:RecordAudio("317102043", var_176_11)
						arg_173_1:RecordAudio("317102043", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_317102", "317102043", "story_v_out_317102.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_317102", "317102043", "story_v_out_317102.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play317102044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 317102044
		arg_177_1.duration_ = 4.47

		local var_177_0 = {
			zh = 4.466,
			ja = 3.933
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play317102045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1093ui_story = arg_177_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).z)
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles = arg_177_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).z)
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles = arg_177_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1093ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1093ui_story == nil then
				arg_177_1.var_.characterEffect1093ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1093ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_2)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1093ui_story then
				arg_177_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_180_3 = arg_177_1.actors_["1015ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1015ui_story = var_180_3.localPosition
			end

			local var_180_4 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				var_180_3.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_4)
				var_180_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_3.position).x, (manager.ui.mainCamera.transform.position - var_180_3.position).y, (manager.ui.mainCamera.transform.position - var_180_3.position).z)
				var_180_3.localEulerAngles.z = 0
				var_180_3.localEulerAngles.x = 0
				var_180_3.localEulerAngles = var_180_3.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				var_180_3.localPosition = Vector3.New(0, 100, 0)
				var_180_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_3.position).x, (manager.ui.mainCamera.transform.position - var_180_3.position).y, (manager.ui.mainCamera.transform.position - var_180_3.position).z)
				var_180_3.localEulerAngles.z = 0
				var_180_3.localEulerAngles.x = 0
				var_180_3.localEulerAngles = var_180_3.localEulerAngles
			end

			local var_180_5 = arg_177_1.actors_["1015ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.characterEffect1015ui_story == nil then
				arg_177_1.var_.characterEffect1015ui_story = var_180_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_6 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_6 and not isNil(var_180_5) then
				if arg_177_1.var_.characterEffect1015ui_story and not isNil(var_180_5) then
					arg_177_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_6)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_6 and arg_177_1.time_ < 0 + var_180_6 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.characterEffect1015ui_story then
				arg_177_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_180_7 = arg_177_1.actors_["2078ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos2078ui_story = var_180_7.localPosition
			end

			local var_180_8 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_8 then
				var_180_7.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_177_1.time_ - 0) / var_180_8)
				var_180_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_7.position).x, (manager.ui.mainCamera.transform.position - var_180_7.position).y, (manager.ui.mainCamera.transform.position - var_180_7.position).z)
				var_180_7.localEulerAngles.z = 0
				var_180_7.localEulerAngles.x = 0
				var_180_7.localEulerAngles = var_180_7.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_8 and arg_177_1.time_ < 0 + var_180_8 + arg_180_0 then
				var_180_7.localPosition = Vector3.New(0, -1.28, -5.6)
				var_180_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_7.position).x, (manager.ui.mainCamera.transform.position - var_180_7.position).y, (manager.ui.mainCamera.transform.position - var_180_7.position).z)
				var_180_7.localEulerAngles.z = 0
				var_180_7.localEulerAngles.x = 0
				var_180_7.localEulerAngles = var_180_7.localEulerAngles
			end

			local var_180_9 = arg_177_1.actors_["2078ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect2078ui_story == nil then
				arg_177_1.var_.characterEffect2078ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_10 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_10 and not isNil(var_180_9) then
				if arg_177_1.var_.characterEffect2078ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_10 and arg_177_1.time_ < 0 + var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect2078ui_story then
				arg_177_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_12 = 0
			local var_180_13 = 0.625

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_14 = arg_177_1:GetWordFromCfg(317102044)
				local var_180_15 = arg_177_1:FormatText(var_180_14.content)

				arg_177_1.text_.text = var_180_15

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_17 = 25 <= 0 and var_180_13 or var_180_13 * (utf8.len(var_180_15) / 25)

				if (25 <= 0 and var_180_13 or var_180_13 * (utf8.len(var_180_15) / 25)) > 0 and var_180_13 < var_180_17 then
					arg_177_1.talkMaxDuration = var_180_17

					if var_180_17 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_17 + var_180_12
					end
				end

				arg_177_1.text_.text = var_180_15
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102044", "story_v_out_317102.awb") ~= 0 then
					local var_180_18 = manager.audio:GetVoiceLength("story_v_out_317102", "317102044", "story_v_out_317102.awb") / 1000

					if var_180_18 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_18 + var_180_12
					end

					if var_180_14.prefab_name ~= "" and arg_177_1.actors_[var_180_14.prefab_name] ~= nil then
						local var_180_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_14.prefab_name].transform, "story_v_out_317102", "317102044", "story_v_out_317102.awb")

						arg_177_1:RecordAudio("317102044", var_180_19)
						arg_177_1:RecordAudio("317102044", var_180_19)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_317102", "317102044", "story_v_out_317102.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_317102", "317102044", "story_v_out_317102.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_20 = math.max(var_180_13, arg_177_1.talkMaxDuration)

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_20 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_12) / var_180_20

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_12 + var_180_20 and arg_177_1.time_ < var_180_12 + var_180_20 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play317102045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 317102045
		arg_181_1.duration_ = 6.4

		local var_181_0 = {
			zh = 6.4,
			ja = 4.433
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play317102046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1093ui_story = arg_181_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).z)
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles = arg_181_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_181_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).z)
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles = arg_181_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1093ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1093ui_story == nil then
				arg_181_1.var_.characterEffect1093ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1093ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_2)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1093ui_story then
				arg_181_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_184_3 = arg_181_1.actors_["1015ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1015ui_story = var_184_3.localPosition
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_3.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_181_1.time_ - 0) / var_184_4)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			local var_184_5 = arg_181_1.actors_["1015ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.characterEffect1015ui_story == nil then
				arg_181_1.var_.characterEffect1015ui_story = var_184_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.characterEffect1015ui_story and not isNil(var_184_5) then
					arg_181_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.characterEffect1015ui_story then
				arg_181_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_184_8 = arg_181_1.actors_["2078ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos2078ui_story = var_184_8.localPosition
			end

			local var_184_9 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_9 then
				var_184_8.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_9)
				var_184_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_8.position).x, (manager.ui.mainCamera.transform.position - var_184_8.position).y, (manager.ui.mainCamera.transform.position - var_184_8.position).z)
				var_184_8.localEulerAngles.z = 0
				var_184_8.localEulerAngles.x = 0
				var_184_8.localEulerAngles = var_184_8.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_9 and arg_181_1.time_ < 0 + var_184_9 + arg_184_0 then
				var_184_8.localPosition = Vector3.New(0, 100, 0)
				var_184_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_8.position).x, (manager.ui.mainCamera.transform.position - var_184_8.position).y, (manager.ui.mainCamera.transform.position - var_184_8.position).z)
				var_184_8.localEulerAngles.z = 0
				var_184_8.localEulerAngles.x = 0
				var_184_8.localEulerAngles = var_184_8.localEulerAngles
			end

			local var_184_10 = 0
			local var_184_11 = 0.85

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_12 = arg_181_1:GetWordFromCfg(317102045)
				local var_184_13 = arg_181_1:FormatText(var_184_12.content)

				arg_181_1.text_.text = var_184_13

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_15 = 34 <= 0 and var_184_11 or var_184_11 * (utf8.len(var_184_13) / 34)

				if (34 <= 0 and var_184_11 or var_184_11 * (utf8.len(var_184_13) / 34)) > 0 and var_184_11 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_10 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_10
					end
				end

				arg_181_1.text_.text = var_184_13
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102045", "story_v_out_317102.awb") ~= 0 then
					local var_184_16 = manager.audio:GetVoiceLength("story_v_out_317102", "317102045", "story_v_out_317102.awb") / 1000

					if var_184_16 + var_184_10 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_16 + var_184_10
					end

					if var_184_12.prefab_name ~= "" and arg_181_1.actors_[var_184_12.prefab_name] ~= nil then
						local var_184_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_12.prefab_name].transform, "story_v_out_317102", "317102045", "story_v_out_317102.awb")

						arg_181_1:RecordAudio("317102045", var_184_17)
						arg_181_1:RecordAudio("317102045", var_184_17)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_317102", "317102045", "story_v_out_317102.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_317102", "317102045", "story_v_out_317102.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_18 = math.max(var_184_11, arg_181_1.talkMaxDuration)

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_18 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_10) / var_184_18

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_10 + var_184_18 and arg_181_1.time_ < var_184_10 + var_184_18 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play317102046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 317102046
		arg_185_1.duration_ = 5.57

		local var_185_0 = {
			zh = 5.566,
			ja = 5.5
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play317102047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.625

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(317102046)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 26 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 26)

				if (26 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 26)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102046", "story_v_out_317102.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102046", "story_v_out_317102.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_317102", "317102046", "story_v_out_317102.awb")

						arg_185_1:RecordAudio("317102046", var_188_6)
						arg_185_1:RecordAudio("317102046", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_317102", "317102046", "story_v_out_317102.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_317102", "317102046", "story_v_out_317102.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play317102047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 317102047
		arg_189_1.duration_ = 9

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play317102048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 2 < arg_189_1.time_ and arg_189_1.time_ <= 2 + arg_192_0 then
				local var_192_0 = arg_189_1.bgs_.K09f

				arg_189_1.bgs_.K09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_1 = var_192_0:GetComponent("SpriteRenderer")

				if var_192_1 and var_192_1.sprite then
					local var_192_2 = 2 * (var_192_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_0.transform.localScale = Vector3.New(var_192_2 / var_192_1.sprite.bounds.size.y < var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x and var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x or var_192_2 / var_192_1.sprite.bounds.size.y, var_192_2 / var_192_1.sprite.bounds.size.y < var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x and var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x or var_192_2 / var_192_1.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "K09f" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_3 = 0

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_3 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_4 = 2

			if var_192_3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_3 + var_192_4 then
				local var_192_5 = Color.New(0, 0, 0)

				var_192_5.a = Mathf.Lerp(0, 1, (arg_189_1.time_ - var_192_3) / var_192_4)
				arg_189_1.mask_.color = var_192_5
			end

			if arg_189_1.time_ >= var_192_3 + var_192_4 and arg_189_1.time_ < var_192_3 + var_192_4 + arg_192_0 then
				local var_192_6 = Color.New(0, 0, 0)

				var_192_6.a = 1
				arg_189_1.mask_.color = var_192_6
			end

			local var_192_7 = 2

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_7 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_8 = 2

			if var_192_7 <= arg_189_1.time_ and arg_189_1.time_ < var_192_7 + var_192_8 then
				local var_192_9 = Color.New(0, 0, 0)

				var_192_9.a = Mathf.Lerp(1, 0, (arg_189_1.time_ - var_192_7) / var_192_8)
				arg_189_1.mask_.color = var_192_9
			end

			if arg_189_1.time_ >= var_192_7 + var_192_8 and arg_189_1.time_ < var_192_7 + var_192_8 + arg_192_0 then
				local var_192_10 = Color.New(0, 0, 0)

				arg_189_1.mask_.enabled = false
				var_192_10.a = 0
				arg_189_1.mask_.color = var_192_10
			end

			local var_192_11 = arg_189_1.actors_["1093ui_story"].transform

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= 2 + arg_192_0 then
				arg_189_1.var_.moveOldPos1093ui_story = var_192_11.localPosition
			end

			local var_192_12 = 0.001

			if 2 <= arg_189_1.time_ and arg_189_1.time_ < 2 + var_192_12 then
				var_192_11.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 2) / var_192_12)
				var_192_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_11.position).x, (manager.ui.mainCamera.transform.position - var_192_11.position).y, (manager.ui.mainCamera.transform.position - var_192_11.position).z)
				var_192_11.localEulerAngles.z = 0
				var_192_11.localEulerAngles.x = 0
				var_192_11.localEulerAngles = var_192_11.localEulerAngles
			end

			if arg_189_1.time_ >= 2 + var_192_12 and arg_189_1.time_ < 2 + var_192_12 + arg_192_0 then
				var_192_11.localPosition = Vector3.New(0, 100, 0)
				var_192_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_11.position).x, (manager.ui.mainCamera.transform.position - var_192_11.position).y, (manager.ui.mainCamera.transform.position - var_192_11.position).z)
				var_192_11.localEulerAngles.z = 0
				var_192_11.localEulerAngles.x = 0
				var_192_11.localEulerAngles = var_192_11.localEulerAngles
			end

			local var_192_13 = arg_189_1.actors_["1015ui_story"].transform

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= 2 + arg_192_0 then
				arg_189_1.var_.moveOldPos1015ui_story = var_192_13.localPosition
			end

			local var_192_14 = 0.001

			if 2 <= arg_189_1.time_ and arg_189_1.time_ < 2 + var_192_14 then
				var_192_13.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 2) / var_192_14)
				var_192_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_13.position).x, (manager.ui.mainCamera.transform.position - var_192_13.position).y, (manager.ui.mainCamera.transform.position - var_192_13.position).z)
				var_192_13.localEulerAngles.z = 0
				var_192_13.localEulerAngles.x = 0
				var_192_13.localEulerAngles = var_192_13.localEulerAngles
			end

			if arg_189_1.time_ >= 2 + var_192_14 and arg_189_1.time_ < 2 + var_192_14 + arg_192_0 then
				var_192_13.localPosition = Vector3.New(0, 100, 0)
				var_192_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_13.position).x, (manager.ui.mainCamera.transform.position - var_192_13.position).y, (manager.ui.mainCamera.transform.position - var_192_13.position).z)
				var_192_13.localEulerAngles.z = 0
				var_192_13.localEulerAngles.x = 0
				var_192_13.localEulerAngles = var_192_13.localEulerAngles
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_15 = 4
			local var_192_16 = 0.85

			if 4 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_17 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_17:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(317102047).content)

				arg_189_1.text_.text = var_192_18

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 34 <= 0 and var_192_16 or var_192_16 * (utf8.len(var_192_18) / 34)

				if (34 <= 0 and var_192_16 or var_192_16 * (utf8.len(var_192_18) / 34)) > 0 and var_192_16 < var_192_20 then
					arg_189_1.talkMaxDuration = var_192_20
					var_192_15 = var_192_15 + 0.3

					if var_192_20 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_18
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_21 = var_192_15 + 0.3
			local var_192_22 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_21 + var_192_22 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_21) / var_192_22

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_21 + var_192_22 and arg_189_1.time_ < var_192_21 + var_192_22 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play317102048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 317102048
		arg_195_1.duration_ = 5.03

		local var_195_0 = {
			zh = 2.933,
			ja = 5.033
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play317102049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.35

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(317102048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 14 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 14)

				if (14 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 14)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102048", "story_v_out_317102.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102048", "story_v_out_317102.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_317102", "317102048", "story_v_out_317102.awb")

						arg_195_1:RecordAudio("317102048", var_198_6)
						arg_195_1:RecordAudio("317102048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_317102", "317102048", "story_v_out_317102.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_317102", "317102048", "story_v_out_317102.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play317102049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 317102049
		arg_199_1.duration_ = 2.5

		local var_199_0 = {
			zh = 1.233,
			ja = 2.5
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play317102050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.175

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:GetWordFromCfg(317102049)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 7 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 7)

				if (7 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 7)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102049", "story_v_out_317102.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_317102", "317102049", "story_v_out_317102.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_317102", "317102049", "story_v_out_317102.awb")

						arg_199_1:RecordAudio("317102049", var_202_6)
						arg_199_1:RecordAudio("317102049", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_317102", "317102049", "story_v_out_317102.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_317102", "317102049", "story_v_out_317102.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play317102050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 317102050
		arg_203_1.duration_ = 9.97

		local var_203_0 = {
			zh = 7.633,
			ja = 9.966
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play317102051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if arg_203_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_206_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_203_1.stage_.transform)

				var_206_0.name = "1058ui_story"
				var_206_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.actors_["1058ui_story"] = var_206_0

				local var_206_1 = var_206_0:GetComponentInChildren(typeof(CharacterEffect))

				var_206_1.enabled = true

				local var_206_2 = GameObjectTools.GetOrAddComponent(var_206_0, typeof(DynamicBoneHelper))

				if var_206_2 then
					var_206_2:EnableDynamicBone(false)
				end

				arg_203_1:ShowWeapon(var_206_1.transform, false)

				arg_203_1.var_["1058ui_story" .. "Animator"] = var_206_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_203_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_203_1.var_["1058ui_story" .. "LipSync"] = var_206_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_206_3 = arg_203_1.actors_["1058ui_story"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1058ui_story = var_206_3.localPosition
			end

			local var_206_4 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				var_206_3.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_203_1.time_ - 0) / var_206_4)
				var_206_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_3.position).x, (manager.ui.mainCamera.transform.position - var_206_3.position).y, (manager.ui.mainCamera.transform.position - var_206_3.position).z)
				var_206_3.localEulerAngles.z = 0
				var_206_3.localEulerAngles.x = 0
				var_206_3.localEulerAngles = var_206_3.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				var_206_3.localPosition = Vector3.New(0, -0.95, -5.88)
				var_206_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_3.position).x, (manager.ui.mainCamera.transform.position - var_206_3.position).y, (manager.ui.mainCamera.transform.position - var_206_3.position).z)
				var_206_3.localEulerAngles.z = 0
				var_206_3.localEulerAngles.x = 0
				var_206_3.localEulerAngles = var_206_3.localEulerAngles
			end

			local var_206_5 = arg_203_1.actors_["1058ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_5) and arg_203_1.var_.characterEffect1058ui_story == nil then
				arg_203_1.var_.characterEffect1058ui_story = var_206_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_6 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_6 and not isNil(var_206_5) then
				if arg_203_1.var_.characterEffect1058ui_story and not isNil(var_206_5) then
					arg_203_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_6 and arg_203_1.time_ < 0 + var_206_6 + arg_206_0 and not isNil(var_206_5) and arg_203_1.var_.characterEffect1058ui_story then
				arg_203_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_8 = 0
			local var_206_9 = 0.925

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_10 = arg_203_1:GetWordFromCfg(317102050)
				local var_206_11 = arg_203_1:FormatText(var_206_10.content)

				arg_203_1.text_.text = var_206_11

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_13 = 37 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 37)

				if (37 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 37)) > 0 and var_206_9 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_11
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102050", "story_v_out_317102.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_out_317102", "317102050", "story_v_out_317102.awb") / 1000

					if var_206_14 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_8
					end

					if var_206_10.prefab_name ~= "" and arg_203_1.actors_[var_206_10.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_10.prefab_name].transform, "story_v_out_317102", "317102050", "story_v_out_317102.awb")

						arg_203_1:RecordAudio("317102050", var_206_15)
						arg_203_1:RecordAudio("317102050", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_317102", "317102050", "story_v_out_317102.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_317102", "317102050", "story_v_out_317102.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_16 and arg_203_1.time_ < var_206_8 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play317102051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 317102051
		arg_207_1.duration_ = 7.63

		local var_207_0 = {
			zh = 4.2,
			ja = 7.633
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play317102052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1058ui_story"]) and arg_207_1.var_.characterEffect1058ui_story == nil then
				arg_207_1.var_.characterEffect1058ui_story = arg_207_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1058ui_story"]) then
				if arg_207_1.var_.characterEffect1058ui_story and not isNil(arg_207_1.actors_["1058ui_story"]) then
					arg_207_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1058ui_story"]) and arg_207_1.var_.characterEffect1058ui_story then
				arg_207_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.5

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(317102051)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_6 = 20 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_4) / 20)

				if (20 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_4) / 20)) > 0 and var_210_2 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102051", "story_v_out_317102.awb") ~= 0 then
					local var_210_7 = manager.audio:GetVoiceLength("story_v_out_317102", "317102051", "story_v_out_317102.awb") / 1000

					if var_210_7 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_1
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_317102", "317102051", "story_v_out_317102.awb")

						arg_207_1:RecordAudio("317102051", var_210_8)
						arg_207_1:RecordAudio("317102051", var_210_8)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_317102", "317102051", "story_v_out_317102.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_317102", "317102051", "story_v_out_317102.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_9 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_9 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_9

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_9 and arg_207_1.time_ < var_210_1 + var_210_9 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play317102052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 317102052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play317102053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1058ui_story = arg_211_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).z)
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles = arg_211_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).z)
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles = arg_211_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_214_1 = 0
			local var_214_2 = 0.375

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(317102052).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 15 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 15)

				if (15 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 15)) > 0 and var_214_2 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_6 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_6 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_6

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_6 and arg_211_1.time_ < var_214_1 + var_214_6 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play317102053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 317102053
		arg_215_1.duration_ = 10.37

		local var_215_0 = {
			zh = 8.8,
			ja = 10.366
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play317102054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1058ui_story = arg_215_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).z)
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles = arg_215_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_215_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).z)
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles = arg_215_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1058ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1058ui_story == nil then
				arg_215_1.var_.characterEffect1058ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1058ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1058ui_story then
				arg_215_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_2")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_218_4 = 0
			local var_218_5 = 1

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(317102053)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 40 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 40)

				if (40 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 40)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102053", "story_v_out_317102.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102053", "story_v_out_317102.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_317102", "317102053", "story_v_out_317102.awb")

						arg_215_1:RecordAudio("317102053", var_218_11)
						arg_215_1:RecordAudio("317102053", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_317102", "317102053", "story_v_out_317102.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_317102", "317102053", "story_v_out_317102.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play317102054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 317102054
		arg_219_1.duration_ = 2.8

		local var_219_0 = {
			zh = 0.999999999999,
			ja = 2.8
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play317102055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1058ui_story"]) and arg_219_1.var_.characterEffect1058ui_story == nil then
				arg_219_1.var_.characterEffect1058ui_story = arg_219_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1058ui_story"]) then
				if arg_219_1.var_.characterEffect1058ui_story and not isNil(arg_219_1.actors_["1058ui_story"]) then
					arg_219_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1058ui_story"]) and arg_219_1.var_.characterEffect1058ui_story then
				arg_219_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.075

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(317102054)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_6 = 3 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_4) / 3)

				if (3 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_4) / 3)) > 0 and var_222_2 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102054", "story_v_out_317102.awb") ~= 0 then
					local var_222_7 = manager.audio:GetVoiceLength("story_v_out_317102", "317102054", "story_v_out_317102.awb") / 1000

					if var_222_7 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_1
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_317102", "317102054", "story_v_out_317102.awb")

						arg_219_1:RecordAudio("317102054", var_222_8)
						arg_219_1:RecordAudio("317102054", var_222_8)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_317102", "317102054", "story_v_out_317102.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_317102", "317102054", "story_v_out_317102.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_9 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_9 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_9

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_9 and arg_219_1.time_ < var_222_1 + var_222_9 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play317102055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 317102055
		arg_223_1.duration_ = 14.27

		local var_223_0 = {
			zh = 8.666,
			ja = 14.266
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play317102056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1058ui_story = arg_223_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1058ui_story"].transform.position).z)
				arg_223_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1058ui_story"].transform.localEulerAngles = arg_223_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_223_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1058ui_story"].transform.position).z)
				arg_223_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1058ui_story"].transform.localEulerAngles = arg_223_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1058ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1058ui_story == nil then
				arg_223_1.var_.characterEffect1058ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1058ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1058ui_story then
				arg_223_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_4 = 0
			local var_226_5 = 1.125

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(317102055)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 45 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 45)

				if (45 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 45)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102055", "story_v_out_317102.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_317102", "317102055", "story_v_out_317102.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_317102", "317102055", "story_v_out_317102.awb")

						arg_223_1:RecordAudio("317102055", var_226_11)
						arg_223_1:RecordAudio("317102055", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_317102", "317102055", "story_v_out_317102.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_317102", "317102055", "story_v_out_317102.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play317102056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 317102056
		arg_227_1.duration_ = 2.33

		local var_227_0 = {
			zh = 0.999999999999,
			ja = 2.333
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play317102057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1058ui_story"]) and arg_227_1.var_.characterEffect1058ui_story == nil then
				arg_227_1.var_.characterEffect1058ui_story = arg_227_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1058ui_story"]) then
				if arg_227_1.var_.characterEffect1058ui_story and not isNil(arg_227_1.actors_["1058ui_story"]) then
					arg_227_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1058ui_story"]) and arg_227_1.var_.characterEffect1058ui_story then
				arg_227_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.125

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(317102056)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_6 = 5 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_4) / 5)

				if (5 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_4) / 5)) > 0 and var_230_2 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317102", "317102056", "story_v_out_317102.awb") ~= 0 then
					local var_230_7 = manager.audio:GetVoiceLength("story_v_out_317102", "317102056", "story_v_out_317102.awb") / 1000

					if var_230_7 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_1
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_317102", "317102056", "story_v_out_317102.awb")

						arg_227_1:RecordAudio("317102056", var_230_8)
						arg_227_1:RecordAudio("317102056", var_230_8)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_317102", "317102056", "story_v_out_317102.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_317102", "317102056", "story_v_out_317102.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_9 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_9 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_9

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_9 and arg_227_1.time_ < var_230_1 + var_230_9 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play317102057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 317102057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
			arg_231_1.auto_ = false
		end

		function arg_231_1.playNext_(arg_233_0)
			arg_231_1.onStoryFinished_()
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1058ui_story = arg_231_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1058ui_story"].transform.position).z)
				arg_231_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1058ui_story"].transform.localEulerAngles = arg_231_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1058ui_story"].transform.position).z)
				arg_231_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1058ui_story"].transform.localEulerAngles = arg_231_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_234_1 = 0
			local var_234_2 = 0.775

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(317102057).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 31 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 31)

				if (31 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 31)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K09f"
	},
	voices = {
		"story_v_out_317102.awb"
	}
}
