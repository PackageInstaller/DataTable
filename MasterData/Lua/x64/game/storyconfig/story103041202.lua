return {
	Play304122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304122001
		arg_1_1.duration_ = 5.1

		local var_1_0 = {
			zh = 5.09966666666667,
			ja = 4.73266666666667
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
				arg_1_0:Play304122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B03b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B03b")
				var_4_0.name = "B03b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B03b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B03b

				arg_1_1.bgs_.B03b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B03b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "4010ui_story"

			if arg_1_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["4010ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect4010ui_story == nil then
				arg_1_1.var_.characterEffect4010ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect4010ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect4010ui_story then
				arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_command room", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 1.46666666666667
			local var_4_22 = 0.225

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_24 = arg_1_1:GetWordFromCfg(304122001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 9 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 9)

				if (9 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 9)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122001", "story_v_out_304122.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_304122", "304122001", "story_v_out_304122.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_304122", "304122001", "story_v_out_304122.awb")

						arg_1_1:RecordAudio("304122001", var_4_29)
						arg_1_1:RecordAudio("304122001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304122", "304122001", "story_v_out_304122.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304122", "304122001", "story_v_out_304122.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304122002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304122002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304122003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_9000

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["4010ui_story"]) and arg_8_1.var_.characterEffect4010ui_story == nil then
				arg_8_1.var_.characterEffect4010ui_story = arg_8_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["4010ui_story"]) then
				if arg_8_1.var_.characterEffect4010ui_story and not isNil(arg_8_1.actors_["4010ui_story"]) then
					arg_8_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_8_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["4010ui_story"]) and arg_8_1.var_.characterEffect4010ui_story then
				arg_8_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_8_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				local var_11_1 = arg_8_1.var_.effectsssfsssf

				if not arg_8_1.var_.effectsssfsssf then
					var_11_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boguang"), manager.ui.mainCamera.transform)
					var_11_1.name = "sssf"
					arg_8_1.var_.effectsssfsssf = var_11_1
				else
					var_11_1.transform:SetParent(var_11_9000)
				end

				var_11_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_11_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_11_1.transform.localScale = Vector3.New(var_11_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_11_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_11_1.transform.localScale.z)
			end

			if 1.28333333333333 < arg_8_1.time_ and arg_8_1.time_ <= 1.28333333333333 + arg_11_0 then
				if arg_8_1.var_.effectsssfsssf then
					Object.Destroy(arg_8_1.var_.effectsssfsssf)

					arg_8_1.var_.effectsssfsssf = nil
				end
			end

			local var_11_4 = 0
			local var_11_5 = 1.7

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_6 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(304122002).content)

				arg_8_1.text_.text = var_11_6

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_8 = 68 <= 0 and var_11_5 or var_11_5 * (utf8.len(var_11_6) / 68)

				if (68 <= 0 and var_11_5 or var_11_5 * (utf8.len(var_11_6) / 68)) > 0 and var_11_5 < var_11_8 then
					arg_8_1.talkMaxDuration = var_11_8

					if var_11_8 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_6
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_9 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_9 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_9

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_9 and arg_8_1.time_ < var_11_4 + var_11_9 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play304122003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304122003
		arg_12_1.duration_ = 4.03

		local var_12_0 = {
			zh = 2.966,
			ja = 4.033
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
				arg_12_0:Play304122004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1019ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1019ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1019ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1019ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1019ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1019ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["1019ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1019ui_story then
				arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_15_8 = 0
			local var_15_9 = 0.375

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(304122003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 15 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 15)

				if (15 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 15)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122003", "story_v_out_304122.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_304122", "304122003", "story_v_out_304122.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_304122", "304122003", "story_v_out_304122.awb")

						arg_12_1:RecordAudio("304122003", var_15_15)
						arg_12_1:RecordAudio("304122003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_304122", "304122003", "story_v_out_304122.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_304122", "304122003", "story_v_out_304122.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play304122004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304122004
		arg_16_1.duration_ = 5

		local var_16_0 = {
			zh = 3.133,
			ja = 5
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
				arg_16_0:Play304122005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos4010ui_story = arg_16_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).z)
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles = arg_16_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				arg_16_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).z)
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles = arg_16_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["1019ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_1.localPosition
			end

			local var_19_2 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 then
				var_19_1.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_16_1.time_ - 0) / var_19_2)
				var_19_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_1.position).x, (manager.ui.mainCamera.transform.position - var_19_1.position).y, (manager.ui.mainCamera.transform.position - var_19_1.position).z)
				var_19_1.localEulerAngles.z = 0
				var_19_1.localEulerAngles.x = 0
				var_19_1.localEulerAngles = var_19_1.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 then
				var_19_1.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_19_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_1.position).x, (manager.ui.mainCamera.transform.position - var_19_1.position).y, (manager.ui.mainCamera.transform.position - var_19_1.position).z)
				var_19_1.localEulerAngles.z = 0
				var_19_1.localEulerAngles.x = 0
				var_19_1.localEulerAngles = var_19_1.localEulerAngles
			end

			local var_19_3 = arg_16_1.actors_["4010ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect4010ui_story == nil then
				arg_16_1.var_.characterEffect4010ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect4010ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect4010ui_story then
				arg_16_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["1019ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 and not isNil(var_19_6) then
				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_6) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_7)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action5_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_8 = 0
			local var_19_9 = 0.325

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(304122004)
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

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122004", "story_v_out_304122.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_304122", "304122004", "story_v_out_304122.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_out_304122", "304122004", "story_v_out_304122.awb")

						arg_16_1:RecordAudio("304122004", var_19_15)
						arg_16_1:RecordAudio("304122004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304122", "304122004", "story_v_out_304122.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304122", "304122004", "story_v_out_304122.awb")
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play304122005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304122005
		arg_20_1.duration_ = 6.47

		local var_20_0 = {
			zh = 4.2,
			ja = 6.466
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
				arg_20_0:Play304122006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = arg_20_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) then
				if arg_20_1.var_.characterEffect1019ui_story and not isNil(arg_20_1.actors_["1019ui_story"]) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["4010ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect4010ui_story == nil then
				arg_20_1.var_.characterEffect4010ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect4010ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_20_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect4010ui_story then
				arg_20_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_20_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_23_4 = 0
			local var_23_5 = 0.475

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(304122005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 19 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 19)

				if (19 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 19)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122005", "story_v_out_304122.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122005", "story_v_out_304122.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_304122", "304122005", "story_v_out_304122.awb")

						arg_20_1:RecordAudio("304122005", var_23_11)
						arg_20_1:RecordAudio("304122005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304122", "304122005", "story_v_out_304122.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304122", "304122005", "story_v_out_304122.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_12 and arg_20_1.time_ < var_23_4 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304122006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304122006
		arg_24_1.duration_ = 7.8

		local var_24_0 = {
			zh = 5.333,
			ja = 7.8
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
				arg_24_0:Play304122007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_0 = 0
			local var_27_1 = 0.725

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(304122006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 29 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 29)

				if (29 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 29)) > 0 and var_27_1 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122006", "story_v_out_304122.awb") ~= 0 then
					local var_27_6 = manager.audio:GetVoiceLength("story_v_out_304122", "304122006", "story_v_out_304122.awb") / 1000

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end

					if var_27_2.prefab_name ~= "" and arg_24_1.actors_[var_27_2.prefab_name] ~= nil then
						local var_27_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_2.prefab_name].transform, "story_v_out_304122", "304122006", "story_v_out_304122.awb")

						arg_24_1:RecordAudio("304122006", var_27_7)
						arg_24_1:RecordAudio("304122006", var_27_7)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304122", "304122006", "story_v_out_304122.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304122", "304122006", "story_v_out_304122.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play304122007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304122007
		arg_28_1.duration_ = 7.9

		local var_28_0 = {
			zh = 7.9,
			ja = 7.566
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
				arg_28_0:Play304122008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["4010ui_story"]) and arg_28_1.var_.characterEffect4010ui_story == nil then
				arg_28_1.var_.characterEffect4010ui_story = arg_28_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["4010ui_story"]) then
				if arg_28_1.var_.characterEffect4010ui_story and not isNil(arg_28_1.actors_["4010ui_story"]) then
					arg_28_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["4010ui_story"]) and arg_28_1.var_.characterEffect4010ui_story then
				arg_28_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["1019ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action5_2")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_4 = 0
			local var_31_5 = 0.75

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(304122007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 30 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 30)

				if (30 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 30)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122007", "story_v_out_304122.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122007", "story_v_out_304122.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_304122", "304122007", "story_v_out_304122.awb")

						arg_28_1:RecordAudio("304122007", var_31_11)
						arg_28_1:RecordAudio("304122007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304122", "304122007", "story_v_out_304122.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304122", "304122007", "story_v_out_304122.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play304122008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304122008
		arg_32_1.duration_ = 6.3

		local var_32_0 = {
			zh = 3.3,
			ja = 6.3
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
				arg_32_0:Play304122009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.375

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(304122008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 15 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 15)

				if (15 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 15)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122008", "story_v_out_304122.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122008", "story_v_out_304122.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_304122", "304122008", "story_v_out_304122.awb")

						arg_32_1:RecordAudio("304122008", var_35_6)
						arg_32_1:RecordAudio("304122008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304122", "304122008", "story_v_out_304122.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304122", "304122008", "story_v_out_304122.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304122009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304122009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play304122010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos4010ui_story = arg_36_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["4010ui_story"].transform.position).z)
				arg_36_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["4010ui_story"].transform.localEulerAngles = arg_36_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["4010ui_story"].transform.position).z)
				arg_36_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["4010ui_story"].transform.localEulerAngles = arg_36_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["1019ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_1.localPosition
			end

			local var_39_2 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 then
				var_39_1.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_2)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 then
				var_39_1.localPosition = Vector3.New(0, 100, 0)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			local var_39_3 = arg_36_1.actors_["4010ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect4010ui_story == nil then
				arg_36_1.var_.characterEffect4010ui_story = var_39_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 and not isNil(var_39_3) then
				if arg_36_1.var_.characterEffect4010ui_story and not isNil(var_39_3) then
					arg_36_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_36_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_4)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect4010ui_story then
				arg_36_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_36_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_39_5 = 0
			local var_39_6 = 1.125

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_7 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(304122009).content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 45 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_7) / 45)

				if (45 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_7) / 45)) > 0 and var_39_6 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_5
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_6, arg_36_1.talkMaxDuration)

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_5) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_5 + var_39_10 and arg_36_1.time_ < var_39_5 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play304122010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304122010
		arg_40_1.duration_ = 3.27

		local var_40_0 = {
			zh = 3.266,
			ja = 1.333
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
				arg_40_0:Play304122011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_43_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_40_1.stage_.transform)

				var_43_0.name = "1084ui_story"
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1084ui_story"] = var_43_0

				local var_43_1 = var_43_0:GetComponentInChildren(typeof(CharacterEffect))

				var_43_1.enabled = true

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_1.transform, false)

				arg_40_1.var_["1084ui_story" .. "Animator"] = var_43_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_40_1.var_["1084ui_story" .. "LipSync"] = var_43_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_3 = arg_40_1.actors_["1084ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_3) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_4 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 and not isNil(var_43_3) then
				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_3) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 and not isNil(var_43_3) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_6 = 0
			local var_43_7 = 0.4

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_8 = arg_40_1:GetWordFromCfg(304122010)
				local var_43_9 = arg_40_1:FormatText(var_43_8.content)

				arg_40_1.text_.text = var_43_9

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 16 <= 0 and var_43_7 or var_43_7 * (utf8.len(var_43_9) / 16)

				if (16 <= 0 and var_43_7 or var_43_7 * (utf8.len(var_43_9) / 16)) > 0 and var_43_7 < var_43_11 then
					arg_40_1.talkMaxDuration = var_43_11

					if var_43_11 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_9
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122010", "story_v_out_304122.awb") ~= 0 then
					local var_43_12 = manager.audio:GetVoiceLength("story_v_out_304122", "304122010", "story_v_out_304122.awb") / 1000

					if var_43_12 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_6
					end

					if var_43_8.prefab_name ~= "" and arg_40_1.actors_[var_43_8.prefab_name] ~= nil then
						local var_43_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_8.prefab_name].transform, "story_v_out_304122", "304122010", "story_v_out_304122.awb")

						arg_40_1:RecordAudio("304122010", var_43_13)
						arg_40_1:RecordAudio("304122010", var_43_13)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304122", "304122010", "story_v_out_304122.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304122", "304122010", "story_v_out_304122.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_14 and arg_40_1.time_ < var_43_6 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play304122011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304122011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play304122012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = arg_44_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(arg_44_1.actors_["1084ui_story"]) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 0.85

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(304122011).content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 34 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 34)

				if (34 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 34)) > 0 and var_47_2 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_6 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_6 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_6

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_6 and arg_44_1.time_ < var_47_1 + var_47_6 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play304122012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304122012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play304122013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.775

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(304122012).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 31 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 31)

				if (31 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 31)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play304122013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304122013
		arg_52_1.duration_ = 5.2

		local var_52_0 = {
			zh = 3.166,
			ja = 5.2
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
				arg_52_0:Play304122014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos4010ui_story = arg_52_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["4010ui_story"].transform.position).z)
				arg_52_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["4010ui_story"].transform.localEulerAngles = arg_52_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				arg_52_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["4010ui_story"].transform.position).z)
				arg_52_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["4010ui_story"].transform.localEulerAngles = arg_52_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_55_1 = arg_52_1.actors_["4010ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect4010ui_story == nil then
				arg_52_1.var_.characterEffect4010ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 and not isNil(var_55_1) then
				if arg_52_1.var_.characterEffect4010ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect4010ui_story then
				arg_52_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 0.275

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(304122013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 11 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 11)

				if (11 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 11)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122013", "story_v_out_304122.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122013", "story_v_out_304122.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_304122", "304122013", "story_v_out_304122.awb")

						arg_52_1:RecordAudio("304122013", var_55_11)
						arg_52_1:RecordAudio("304122013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304122", "304122013", "story_v_out_304122.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304122", "304122013", "story_v_out_304122.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play304122014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304122014
		arg_56_1.duration_ = 3.4

		local var_56_0 = {
			zh = 3.4,
			ja = 1.999999999999
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
				arg_56_0:Play304122015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = arg_56_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1084ui_story"].transform.position).z)
				arg_56_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1084ui_story"].transform.localEulerAngles = arg_56_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_56_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1084ui_story"].transform.position).z)
				arg_56_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1084ui_story"].transform.localEulerAngles = arg_56_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["1084ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 and not isNil(var_59_1) then
				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["4010ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect4010ui_story == nil then
				arg_56_1.var_.characterEffect4010ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_5 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 and not isNil(var_59_4) then
				if arg_56_1.var_.characterEffect4010ui_story and not isNil(var_59_4) then
					arg_56_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_56_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_5)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect4010ui_story then
				arg_56_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_56_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_6 = 0
			local var_59_7 = 0.3

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_8 = arg_56_1:GetWordFromCfg(304122014)
				local var_59_9 = arg_56_1:FormatText(var_59_8.content)

				arg_56_1.text_.text = var_59_9

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 12 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 12)

				if (12 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 12)) > 0 and var_59_7 < var_59_11 then
					arg_56_1.talkMaxDuration = var_59_11

					if var_59_11 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_9
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122014", "story_v_out_304122.awb") ~= 0 then
					local var_59_12 = manager.audio:GetVoiceLength("story_v_out_304122", "304122014", "story_v_out_304122.awb") / 1000

					if var_59_12 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_6
					end

					if var_59_8.prefab_name ~= "" and arg_56_1.actors_[var_59_8.prefab_name] ~= nil then
						local var_59_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_8.prefab_name].transform, "story_v_out_304122", "304122014", "story_v_out_304122.awb")

						arg_56_1:RecordAudio("304122014", var_59_13)
						arg_56_1:RecordAudio("304122014", var_59_13)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304122", "304122014", "story_v_out_304122.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304122", "304122014", "story_v_out_304122.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play304122015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304122015
		arg_60_1.duration_ = 17.3

		local var_60_0 = {
			zh = 11.4,
			ja = 17.3
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
				arg_60_0:Play304122016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["4010ui_story"]) and arg_60_1.var_.characterEffect4010ui_story == nil then
				arg_60_1.var_.characterEffect4010ui_story = arg_60_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["4010ui_story"]) then
				if arg_60_1.var_.characterEffect4010ui_story and not isNil(arg_60_1.actors_["4010ui_story"]) then
					arg_60_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["4010ui_story"]) and arg_60_1.var_.characterEffect4010ui_story then
				arg_60_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1084ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_63_4 = 0
			local var_63_5 = 1.1

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(304122015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 44 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 44)

				if (44 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 44)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122015", "story_v_out_304122.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122015", "story_v_out_304122.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_304122", "304122015", "story_v_out_304122.awb")

						arg_60_1:RecordAudio("304122015", var_63_11)
						arg_60_1:RecordAudio("304122015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_304122", "304122015", "story_v_out_304122.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_304122", "304122015", "story_v_out_304122.awb")
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

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play304122016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304122016
		arg_64_1.duration_ = 4.43

		local var_64_0 = {
			zh = 3.633,
			ja = 4.433
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
				arg_64_0:Play304122017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if arg_64_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_67_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_64_1.stage_.transform)

				var_67_0.name = "1011ui_story"
				var_67_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1011ui_story"] = var_67_0

				local var_67_1 = var_67_0:GetComponentInChildren(typeof(CharacterEffect))

				var_67_1.enabled = true

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end

				arg_64_1:ShowWeapon(var_67_1.transform, false)

				arg_64_1.var_["1011ui_story" .. "Animator"] = var_67_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_64_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_64_1.var_["1011ui_story" .. "LipSync"] = var_67_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_67_3 = arg_64_1.actors_["1011ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_3.localPosition
			end

			local var_67_4 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				var_67_3.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_64_1.time_ - 0) / var_67_4)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				var_67_3.localPosition = Vector3.New(0.7, -0.71, -6)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles
			end

			local var_67_5 = arg_64_1.actors_["1084ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_5.localPosition
			end

			local var_67_6 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_6 then
				var_67_5.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_6)
				var_67_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_5.position).x, (manager.ui.mainCamera.transform.position - var_67_5.position).y, (manager.ui.mainCamera.transform.position - var_67_5.position).z)
				var_67_5.localEulerAngles.z = 0
				var_67_5.localEulerAngles.x = 0
				var_67_5.localEulerAngles = var_67_5.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_6 and arg_64_1.time_ < 0 + var_67_6 + arg_67_0 then
				var_67_5.localPosition = Vector3.New(0, 100, 0)
				var_67_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_5.position).x, (manager.ui.mainCamera.transform.position - var_67_5.position).y, (manager.ui.mainCamera.transform.position - var_67_5.position).z)
				var_67_5.localEulerAngles.z = 0
				var_67_5.localEulerAngles.x = 0
				var_67_5.localEulerAngles = var_67_5.localEulerAngles
			end

			local var_67_7 = arg_64_1.actors_["1011ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.characterEffect1011ui_story == nil then
				arg_64_1.var_.characterEffect1011ui_story = var_67_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_8 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_8 and not isNil(var_67_7) then
				if arg_64_1.var_.characterEffect1011ui_story and not isNil(var_67_7) then
					arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_8 and arg_64_1.time_ < 0 + var_67_8 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.characterEffect1011ui_story then
				arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_67_10 = arg_64_1.actors_["4010ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_10) and arg_64_1.var_.characterEffect4010ui_story == nil then
				arg_64_1.var_.characterEffect4010ui_story = var_67_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_11 and not isNil(var_67_10) then
				if arg_64_1.var_.characterEffect4010ui_story and not isNil(var_67_10) then
					arg_64_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_64_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_11)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_11 and arg_64_1.time_ < 0 + var_67_11 + arg_67_0 and not isNil(var_67_10) and arg_64_1.var_.characterEffect4010ui_story then
				arg_64_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_64_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action7_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_12 = 0
			local var_67_13 = 0.325

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_14 = arg_64_1:GetWordFromCfg(304122016)
				local var_67_15 = arg_64_1:FormatText(var_67_14.content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_17 = 13 <= 0 and var_67_13 or var_67_13 * (utf8.len(var_67_15) / 13)

				if (13 <= 0 and var_67_13 or var_67_13 * (utf8.len(var_67_15) / 13)) > 0 and var_67_13 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_12
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122016", "story_v_out_304122.awb") ~= 0 then
					local var_67_18 = manager.audio:GetVoiceLength("story_v_out_304122", "304122016", "story_v_out_304122.awb") / 1000

					if var_67_18 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_12
					end

					if var_67_14.prefab_name ~= "" and arg_64_1.actors_[var_67_14.prefab_name] ~= nil then
						local var_67_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_14.prefab_name].transform, "story_v_out_304122", "304122016", "story_v_out_304122.awb")

						arg_64_1:RecordAudio("304122016", var_67_19)
						arg_64_1:RecordAudio("304122016", var_67_19)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_304122", "304122016", "story_v_out_304122.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_304122", "304122016", "story_v_out_304122.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_20 = math.max(var_67_13, arg_64_1.talkMaxDuration)

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_20 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_12) / var_67_20

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_12 + var_67_20 and arg_64_1.time_ < var_67_12 + var_67_20 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play304122017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 304122017
		arg_68_1.duration_ = 7.43

		local var_68_0 = {
			zh = 7.433,
			ja = 6.966
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
				arg_68_0:Play304122018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["4010ui_story"]) and arg_68_1.var_.characterEffect4010ui_story == nil then
				arg_68_1.var_.characterEffect4010ui_story = arg_68_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["4010ui_story"]) then
				if arg_68_1.var_.characterEffect4010ui_story and not isNil(arg_68_1.actors_["4010ui_story"]) then
					arg_68_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["4010ui_story"]) and arg_68_1.var_.characterEffect4010ui_story then
				arg_68_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["1011ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1011ui_story == nil then
				arg_68_1.var_.characterEffect1011ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect1011ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1011ui_story then
				arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_71_4 = 0
			local var_71_5 = 0.85

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(304122017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 34 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 34)

				if (34 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 34)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122017", "story_v_out_304122.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122017", "story_v_out_304122.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_304122", "304122017", "story_v_out_304122.awb")

						arg_68_1:RecordAudio("304122017", var_71_11)
						arg_68_1:RecordAudio("304122017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_304122", "304122017", "story_v_out_304122.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_304122", "304122017", "story_v_out_304122.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play304122018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 304122018
		arg_72_1.duration_ = 6.23

		local var_72_0 = {
			zh = 6.233,
			ja = 5.5
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play304122019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.725

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:GetWordFromCfg(304122018)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 29 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 29)

				if (29 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 29)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122018", "story_v_out_304122.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122018", "story_v_out_304122.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_304122", "304122018", "story_v_out_304122.awb")

						arg_72_1:RecordAudio("304122018", var_75_6)
						arg_72_1:RecordAudio("304122018", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_304122", "304122018", "story_v_out_304122.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_304122", "304122018", "story_v_out_304122.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play304122019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 304122019
		arg_76_1.duration_ = 3.2

		local var_76_0 = {
			zh = 3.2,
			ja = 2.066
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
				arg_76_0:Play304122020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1011ui_story"]) and arg_76_1.var_.characterEffect1011ui_story == nil then
				arg_76_1.var_.characterEffect1011ui_story = arg_76_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1011ui_story"]) then
				if arg_76_1.var_.characterEffect1011ui_story and not isNil(arg_76_1.actors_["1011ui_story"]) then
					arg_76_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1011ui_story"]) and arg_76_1.var_.characterEffect1011ui_story then
				arg_76_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["4010ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect4010ui_story == nil then
				arg_76_1.var_.characterEffect4010ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect4010ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_76_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect4010ui_story then
				arg_76_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_76_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_79_4 = arg_76_1.actors_["1011ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1011ui_story = var_79_4.localPosition
			end

			local var_79_5 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 then
				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_5)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(0, 100, 0)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			local var_79_6 = arg_76_1.actors_["4010ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos4010ui_story = var_79_6.localPosition
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_6.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_7)
				var_79_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_6.position).x, (manager.ui.mainCamera.transform.position - var_79_6.position).y, (manager.ui.mainCamera.transform.position - var_79_6.position).z)
				var_79_6.localEulerAngles.z = 0
				var_79_6.localEulerAngles.x = 0
				var_79_6.localEulerAngles = var_79_6.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_6.localPosition = Vector3.New(0, 100, 0)
				var_79_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_6.position).x, (manager.ui.mainCamera.transform.position - var_79_6.position).y, (manager.ui.mainCamera.transform.position - var_79_6.position).z)
				var_79_6.localEulerAngles.z = 0
				var_79_6.localEulerAngles.x = 0
				var_79_6.localEulerAngles = var_79_6.localEulerAngles
			end

			local var_79_8 = 0
			local var_79_9 = 0.475

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_10 = arg_76_1:GetWordFromCfg(304122019)
				local var_79_11 = arg_76_1:FormatText(var_79_10.content)

				arg_76_1.text_.text = var_79_11

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 19 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 19)

				if (19 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 19)) > 0 and var_79_9 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_11
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122019", "story_v_out_304122.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_304122", "304122019", "story_v_out_304122.awb") / 1000

					if var_79_14 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_8
					end

					if var_79_10.prefab_name ~= "" and arg_76_1.actors_[var_79_10.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_10.prefab_name].transform, "story_v_out_304122", "304122019", "story_v_out_304122.awb")

						arg_76_1:RecordAudio("304122019", var_79_15)
						arg_76_1:RecordAudio("304122019", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_304122", "304122019", "story_v_out_304122.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_304122", "304122019", "story_v_out_304122.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_16 and arg_76_1.time_ < var_79_8 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play304122020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 304122020
		arg_80_1.duration_ = 6.77

		local var_80_0 = {
			zh = 4.866,
			ja = 6.766
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play304122021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["4010ui_story"]) and arg_80_1.var_.characterEffect4010ui_story == nil then
				arg_80_1.var_.characterEffect4010ui_story = arg_80_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["4010ui_story"]) then
				if arg_80_1.var_.characterEffect4010ui_story and not isNil(arg_80_1.actors_["4010ui_story"]) then
					arg_80_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["4010ui_story"]) and arg_80_1.var_.characterEffect4010ui_story then
				arg_80_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["1011ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1011ui_story == nil then
				arg_80_1.var_.characterEffect1011ui_story = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_3 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.characterEffect1011ui_story and not isNil(var_83_2) then
					arg_80_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_3)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1011ui_story then
				arg_80_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_4 = arg_80_1.actors_["4010ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos4010ui_story = var_83_4.localPosition
			end

			local var_83_5 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_5 then
				var_83_4.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_80_1.time_ - 0) / var_83_5)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_5 and arg_80_1.time_ < 0 + var_83_5 + arg_83_0 then
				var_83_4.localPosition = Vector3.New(0, -1.59, -5.2)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			local var_83_6 = 0
			local var_83_7 = 0.55

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_8 = arg_80_1:GetWordFromCfg(304122020)
				local var_83_9 = arg_80_1:FormatText(var_83_8.content)

				arg_80_1.text_.text = var_83_9

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 22 <= 0 and var_83_7 or var_83_7 * (utf8.len(var_83_9) / 22)

				if (22 <= 0 and var_83_7 or var_83_7 * (utf8.len(var_83_9) / 22)) > 0 and var_83_7 < var_83_11 then
					arg_80_1.talkMaxDuration = var_83_11

					if var_83_11 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_9
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122020", "story_v_out_304122.awb") ~= 0 then
					local var_83_12 = manager.audio:GetVoiceLength("story_v_out_304122", "304122020", "story_v_out_304122.awb") / 1000

					if var_83_12 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_12 + var_83_6
					end

					if var_83_8.prefab_name ~= "" and arg_80_1.actors_[var_83_8.prefab_name] ~= nil then
						local var_83_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_8.prefab_name].transform, "story_v_out_304122", "304122020", "story_v_out_304122.awb")

						arg_80_1:RecordAudio("304122020", var_83_13)
						arg_80_1:RecordAudio("304122020", var_83_13)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_304122", "304122020", "story_v_out_304122.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_304122", "304122020", "story_v_out_304122.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_14 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_14

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_14 and arg_80_1.time_ < var_83_6 + var_83_14 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play304122021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 304122021
		arg_84_1.duration_ = 4.63

		local var_84_0 = {
			zh = 4.633,
			ja = 1.999999999999
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
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play304122022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = arg_84_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).z)
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles = arg_84_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_84_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).z)
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles = arg_84_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["1011ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1011ui_story = var_87_1.localPosition
			end

			local var_87_2 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 then
				var_87_1.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_2)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 then
				var_87_1.localPosition = Vector3.New(0, 100, 0)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			local var_87_3 = arg_84_1.actors_["4010ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos4010ui_story = var_87_3.localPosition
			end

			local var_87_4 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				var_87_3.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_4)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_3.localPosition = Vector3.New(0, 100, 0)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			local var_87_5 = arg_84_1.actors_["1084ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_6 and not isNil(var_87_5) then
				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_5) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_6 and arg_84_1.time_ < 0 + var_87_6 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_87_8 = arg_84_1.actors_["4010ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.characterEffect4010ui_story == nil then
				arg_84_1.var_.characterEffect4010ui_story = var_87_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_9 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_9 and not isNil(var_87_8) then
				if arg_84_1.var_.characterEffect4010ui_story and not isNil(var_87_8) then
					arg_84_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_84_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_9)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_9 and arg_84_1.time_ < 0 + var_87_9 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.characterEffect4010ui_story then
				arg_84_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_84_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_87_10 = 0
			local var_87_11 = 0.45

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_12 = arg_84_1:GetWordFromCfg(304122021)
				local var_87_13 = arg_84_1:FormatText(var_87_12.content)

				arg_84_1.text_.text = var_87_13

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_15 = 18 <= 0 and var_87_11 or var_87_11 * (utf8.len(var_87_13) / 18)

				if (18 <= 0 and var_87_11 or var_87_11 * (utf8.len(var_87_13) / 18)) > 0 and var_87_11 < var_87_15 then
					arg_84_1.talkMaxDuration = var_87_15

					if var_87_15 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_15 + var_87_10
					end
				end

				arg_84_1.text_.text = var_87_13
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122021", "story_v_out_304122.awb") ~= 0 then
					local var_87_16 = manager.audio:GetVoiceLength("story_v_out_304122", "304122021", "story_v_out_304122.awb") / 1000

					if var_87_16 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_16 + var_87_10
					end

					if var_87_12.prefab_name ~= "" and arg_84_1.actors_[var_87_12.prefab_name] ~= nil then
						local var_87_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_12.prefab_name].transform, "story_v_out_304122", "304122021", "story_v_out_304122.awb")

						arg_84_1:RecordAudio("304122021", var_87_17)
						arg_84_1:RecordAudio("304122021", var_87_17)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_304122", "304122021", "story_v_out_304122.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_304122", "304122021", "story_v_out_304122.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_18 = math.max(var_87_11, arg_84_1.talkMaxDuration)

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_18 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_10) / var_87_18

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_10 + var_87_18 and arg_84_1.time_ < var_87_10 + var_87_18 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play304122022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 304122022
		arg_88_1.duration_ = 8

		local var_88_0 = {
			zh = 4.866,
			ja = 8
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play304122023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = arg_88_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1019ui_story"].transform.position).z)
				arg_88_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1019ui_story"].transform.localEulerAngles = arg_88_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_88_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1019ui_story"].transform.position).z)
				arg_88_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1019ui_story"].transform.localEulerAngles = arg_88_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_91_1 = arg_88_1.actors_["1019ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1019ui_story == nil then
				arg_88_1.var_.characterEffect1019ui_story = var_91_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 and not isNil(var_91_1) then
				if arg_88_1.var_.characterEffect1019ui_story and not isNil(var_91_1) then
					arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1019ui_story then
				arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["1084ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_5 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_5 and not isNil(var_91_4) then
				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_4) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_5)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_5 and arg_88_1.time_ < 0 + var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action475")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_6 = arg_88_1.actors_["1084ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_6.localPosition
			end

			local var_91_7 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				var_91_6.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_88_1.time_ - 0) / var_91_7)
				var_91_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_6.position).x, (manager.ui.mainCamera.transform.position - var_91_6.position).y, (manager.ui.mainCamera.transform.position - var_91_6.position).z)
				var_91_6.localEulerAngles.z = 0
				var_91_6.localEulerAngles.x = 0
				var_91_6.localEulerAngles = var_91_6.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				var_91_6.localPosition = Vector3.New(0.7, -0.97, -6)
				var_91_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_6.position).x, (manager.ui.mainCamera.transform.position - var_91_6.position).y, (manager.ui.mainCamera.transform.position - var_91_6.position).z)
				var_91_6.localEulerAngles.z = 0
				var_91_6.localEulerAngles.x = 0
				var_91_6.localEulerAngles = var_91_6.localEulerAngles
			end

			local var_91_8 = 0
			local var_91_9 = 0.675

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_10 = arg_88_1:GetWordFromCfg(304122022)
				local var_91_11 = arg_88_1:FormatText(var_91_10.content)

				arg_88_1.text_.text = var_91_11

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_13 = 27 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 27)

				if (27 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 27)) > 0 and var_91_9 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_11
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122022", "story_v_out_304122.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_304122", "304122022", "story_v_out_304122.awb") / 1000

					if var_91_14 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_8
					end

					if var_91_10.prefab_name ~= "" and arg_88_1.actors_[var_91_10.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_10.prefab_name].transform, "story_v_out_304122", "304122022", "story_v_out_304122.awb")

						arg_88_1:RecordAudio("304122022", var_91_15)
						arg_88_1:RecordAudio("304122022", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_304122", "304122022", "story_v_out_304122.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_304122", "304122022", "story_v_out_304122.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_8) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_8 + var_91_16 and arg_88_1.time_ < var_91_8 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play304122023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 304122023
		arg_92_1.duration_ = 9.6

		local var_92_0 = {
			zh = 5.333,
			ja = 9.6
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play304122024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.7

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_1 = arg_92_1:GetWordFromCfg(304122023)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 28 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 28)

				if (28 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 28)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122023", "story_v_out_304122.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122023", "story_v_out_304122.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_304122", "304122023", "story_v_out_304122.awb")

						arg_92_1:RecordAudio("304122023", var_95_6)
						arg_92_1:RecordAudio("304122023", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_304122", "304122023", "story_v_out_304122.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_304122", "304122023", "story_v_out_304122.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play304122024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 304122024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play304122025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1019ui_story = arg_96_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1019ui_story"].transform.position).z)
				arg_96_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1019ui_story"].transform.localEulerAngles = arg_96_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1019ui_story"].transform.position).z)
				arg_96_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1019ui_story"].transform.localEulerAngles = arg_96_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["1019ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1019ui_story == nil then
				arg_96_1.var_.characterEffect1019ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1019ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_2)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1019ui_story then
				arg_96_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_99_3 = arg_96_1.actors_["1084ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1084ui_story = var_99_3.localPosition
			end

			local var_99_4 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				var_99_3.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_4)
				var_99_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_3.position).x, (manager.ui.mainCamera.transform.position - var_99_3.position).y, (manager.ui.mainCamera.transform.position - var_99_3.position).z)
				var_99_3.localEulerAngles.z = 0
				var_99_3.localEulerAngles.x = 0
				var_99_3.localEulerAngles = var_99_3.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				var_99_3.localPosition = Vector3.New(0, 100, 0)
				var_99_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_3.position).x, (manager.ui.mainCamera.transform.position - var_99_3.position).y, (manager.ui.mainCamera.transform.position - var_99_3.position).z)
				var_99_3.localEulerAngles.z = 0
				var_99_3.localEulerAngles.x = 0
				var_99_3.localEulerAngles = var_99_3.localEulerAngles
			end

			local var_99_5 = 0
			local var_99_6 = 1.2

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_7 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(304122024).content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 48 <= 0 and var_99_6 or var_99_6 * (utf8.len(var_99_7) / 48)

				if (48 <= 0 and var_99_6 or var_99_6 * (utf8.len(var_99_7) / 48)) > 0 and var_99_6 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_5
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_6, arg_96_1.talkMaxDuration)

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_5) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_5 + var_99_10 and arg_96_1.time_ < var_99_5 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play304122025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 304122025
		arg_100_1.duration_ = 7.97

		local var_100_0 = {
			zh = 6.433,
			ja = 7.966
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play304122026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos4010ui_story = arg_100_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["4010ui_story"].transform.position).z)
				arg_100_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["4010ui_story"].transform.localEulerAngles = arg_100_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_100_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["4010ui_story"].transform.position).z)
				arg_100_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["4010ui_story"].transform.localEulerAngles = arg_100_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["4010ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect4010ui_story == nil then
				arg_100_1.var_.characterEffect4010ui_story = var_103_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 and not isNil(var_103_1) then
				if arg_100_1.var_.characterEffect4010ui_story and not isNil(var_103_1) then
					arg_100_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect4010ui_story then
				arg_100_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_2")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_103_4 = 0
			local var_103_5 = 0.675

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(304122025)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 27 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 27)

				if (27 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 27)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122025", "story_v_out_304122.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122025", "story_v_out_304122.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_304122", "304122025", "story_v_out_304122.awb")

						arg_100_1:RecordAudio("304122025", var_103_11)
						arg_100_1:RecordAudio("304122025", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_304122", "304122025", "story_v_out_304122.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_304122", "304122025", "story_v_out_304122.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_12 and arg_100_1.time_ < var_103_4 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play304122026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 304122026
		arg_104_1.duration_ = 7.73

		local var_104_0 = {
			zh = 7.366,
			ja = 7.733
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play304122027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.75

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:GetWordFromCfg(304122026)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 30 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 30)

				if (30 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 30)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122026", "story_v_out_304122.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122026", "story_v_out_304122.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_304122", "304122026", "story_v_out_304122.awb")

						arg_104_1:RecordAudio("304122026", var_107_6)
						arg_104_1:RecordAudio("304122026", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_304122", "304122026", "story_v_out_304122.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_304122", "304122026", "story_v_out_304122.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play304122027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 304122027
		arg_108_1.duration_ = 2.73

		local var_108_0 = {
			zh = 2.733,
			ja = 1.999999999999
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play304122028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos4010ui_story = arg_108_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["4010ui_story"].transform.position).z)
				arg_108_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["4010ui_story"].transform.localEulerAngles = arg_108_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				arg_108_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["4010ui_story"].transform.position).z)
				arg_108_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["4010ui_story"].transform.localEulerAngles = arg_108_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["1084ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1084ui_story = var_111_1.localPosition
			end

			local var_111_2 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 then
				var_111_1.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_108_1.time_ - 0) / var_111_2)
				var_111_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_1.position).x, (manager.ui.mainCamera.transform.position - var_111_1.position).y, (manager.ui.mainCamera.transform.position - var_111_1.position).z)
				var_111_1.localEulerAngles.z = 0
				var_111_1.localEulerAngles.x = 0
				var_111_1.localEulerAngles = var_111_1.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 then
				var_111_1.localPosition = Vector3.New(0.7, -0.97, -6)
				var_111_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_1.position).x, (manager.ui.mainCamera.transform.position - var_111_1.position).y, (manager.ui.mainCamera.transform.position - var_111_1.position).z)
				var_111_1.localEulerAngles.z = 0
				var_111_1.localEulerAngles.x = 0
				var_111_1.localEulerAngles = var_111_1.localEulerAngles
			end

			local var_111_3 = arg_108_1.actors_["1084ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_3) and arg_108_1.var_.characterEffect1084ui_story == nil then
				arg_108_1.var_.characterEffect1084ui_story = var_111_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_4 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 and not isNil(var_111_3) then
				if arg_108_1.var_.characterEffect1084ui_story and not isNil(var_111_3) then
					arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 and not isNil(var_111_3) and arg_108_1.var_.characterEffect1084ui_story then
				arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_111_6 = arg_108_1.actors_["4010ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_6) and arg_108_1.var_.characterEffect4010ui_story == nil then
				arg_108_1.var_.characterEffect4010ui_story = var_111_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_7 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 and not isNil(var_111_6) then
				if arg_108_1.var_.characterEffect4010ui_story and not isNil(var_111_6) then
					arg_108_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_7)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 and not isNil(var_111_6) and arg_108_1.var_.characterEffect4010ui_story then
				arg_108_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_111_8 = 0
			local var_111_9 = 0.2

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_10 = arg_108_1:GetWordFromCfg(304122027)
				local var_111_11 = arg_108_1:FormatText(var_111_10.content)

				arg_108_1.text_.text = var_111_11

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 8 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 8)

				if (8 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 8)) > 0 and var_111_9 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_11
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122027", "story_v_out_304122.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_304122", "304122027", "story_v_out_304122.awb") / 1000

					if var_111_14 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_8
					end

					if var_111_10.prefab_name ~= "" and arg_108_1.actors_[var_111_10.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_10.prefab_name].transform, "story_v_out_304122", "304122027", "story_v_out_304122.awb")

						arg_108_1:RecordAudio("304122027", var_111_15)
						arg_108_1:RecordAudio("304122027", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_304122", "304122027", "story_v_out_304122.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_304122", "304122027", "story_v_out_304122.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_16 and arg_108_1.time_ < var_111_8 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play304122028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 304122028
		arg_112_1.duration_ = 4.2

		local var_112_0 = {
			zh = 4.2,
			ja = 2.633
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play304122029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["4010ui_story"]) and arg_112_1.var_.characterEffect4010ui_story == nil then
				arg_112_1.var_.characterEffect4010ui_story = arg_112_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["4010ui_story"]) then
				if arg_112_1.var_.characterEffect4010ui_story and not isNil(arg_112_1.actors_["4010ui_story"]) then
					arg_112_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["4010ui_story"]) and arg_112_1.var_.characterEffect4010ui_story then
				arg_112_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_115_2 = arg_112_1.actors_["1084ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = var_115_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_3 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.characterEffect1084ui_story and not isNil(var_115_2) then
					arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_3)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1084ui_story then
				arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_115_4 = 0
			local var_115_5 = 0.325

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(304122028)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 13 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 13)

				if (13 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 13)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122028", "story_v_out_304122.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122028", "story_v_out_304122.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_304122", "304122028", "story_v_out_304122.awb")

						arg_112_1:RecordAudio("304122028", var_115_11)
						arg_112_1:RecordAudio("304122028", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_304122", "304122028", "story_v_out_304122.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_304122", "304122028", "story_v_out_304122.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play304122029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 304122029
		arg_116_1.duration_ = 5.13

		local var_116_0 = {
			zh = 4.8,
			ja = 5.133
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play304122030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action7_1")
			end

			local var_119_0 = 0
			local var_119_1 = 0.4

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_2 = arg_116_1:GetWordFromCfg(304122029)
				local var_119_3 = arg_116_1:FormatText(var_119_2.content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 16 <= 0 and var_119_1 or var_119_1 * (utf8.len(var_119_3) / 16)

				if (16 <= 0 and var_119_1 or var_119_1 * (utf8.len(var_119_3) / 16)) > 0 and var_119_1 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122029", "story_v_out_304122.awb") ~= 0 then
					local var_119_6 = manager.audio:GetVoiceLength("story_v_out_304122", "304122029", "story_v_out_304122.awb") / 1000

					if var_119_6 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_0
					end

					if var_119_2.prefab_name ~= "" and arg_116_1.actors_[var_119_2.prefab_name] ~= nil then
						local var_119_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_2.prefab_name].transform, "story_v_out_304122", "304122029", "story_v_out_304122.awb")

						arg_116_1:RecordAudio("304122029", var_119_7)
						arg_116_1:RecordAudio("304122029", var_119_7)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_304122", "304122029", "story_v_out_304122.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_304122", "304122029", "story_v_out_304122.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_8 and arg_116_1.time_ < var_119_0 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play304122030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 304122030
		arg_120_1.duration_ = 8.3

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play304122031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if arg_120_1.bgs_.B06b == nil then
				local var_123_0 = Object.Instantiate(arg_120_1.paintGo_)

				var_123_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B06b")
				var_123_0.name = "B06b"
				var_123_0.transform.parent = arg_120_1.stage_.transform
				var_123_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.bgs_.B06b = var_123_0
			end

			if 1.9 < arg_120_1.time_ and arg_120_1.time_ <= 1.9 + arg_123_0 then
				local var_123_1 = arg_120_1.bgs_.B06b

				arg_120_1.bgs_.B06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_123_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_123_2 = var_123_1:GetComponent("SpriteRenderer")

				if var_123_2 and var_123_2.sprite then
					local var_123_3 = 2 * (var_123_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_123_1.transform.localScale = Vector3.New(var_123_3 / var_123_2.sprite.bounds.size.y < var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x and var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x or var_123_3 / var_123_2.sprite.bounds.size.y, var_123_3 / var_123_2.sprite.bounds.size.y < var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x and var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x or var_123_3 / var_123_2.sprite.bounds.size.y, 0)
				end

				for iter_123_0, iter_123_1 in pairs(arg_120_1.bgs_) do
					if iter_123_0 ~= "B06b" then
						iter_123_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_123_4 = 1.9

			if 1.9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.allBtn_.enabled = false
			end

			if arg_120_1.time_ >= var_123_4 + 0.3 and arg_120_1.time_ < var_123_4 + 0.3 + arg_123_0 then
				arg_120_1.allBtn_.enabled = true
			end

			local var_123_5 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_6 = 1.9

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 then
				local var_123_7 = Color.New(0, 0, 0)

				var_123_7.a = Mathf.Lerp(0, 1, (arg_120_1.time_ - var_123_5) / var_123_6)
				arg_120_1.mask_.color = var_123_7
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 then
				local var_123_8 = Color.New(0, 0, 0)

				var_123_8.a = 1
				arg_120_1.mask_.color = var_123_8
			end

			local var_123_9 = 1.9

			if 1.9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_10 = 2.13333333333333

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 then
				local var_123_11 = Color.New(0, 0, 0)

				var_123_11.a = Mathf.Lerp(1, 0, (arg_120_1.time_ - var_123_9) / var_123_10)
				arg_120_1.mask_.color = var_123_11
			end

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 then
				local var_123_12 = Color.New(0, 0, 0)

				arg_120_1.mask_.enabled = false
				var_123_12.a = 0
				arg_120_1.mask_.color = var_123_12
			end

			local var_123_13 = arg_120_1.actors_["4010ui_story"].transform

			if 1.9 < arg_120_1.time_ and arg_120_1.time_ <= 1.9 + arg_123_0 then
				arg_120_1.var_.moveOldPos4010ui_story = var_123_13.localPosition
			end

			local var_123_14 = 0.001

			if 1.9 <= arg_120_1.time_ and arg_120_1.time_ < 1.9 + var_123_14 then
				var_123_13.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 1.9) / var_123_14)
				var_123_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_13.position).x, (manager.ui.mainCamera.transform.position - var_123_13.position).y, (manager.ui.mainCamera.transform.position - var_123_13.position).z)
				var_123_13.localEulerAngles.z = 0
				var_123_13.localEulerAngles.x = 0
				var_123_13.localEulerAngles = var_123_13.localEulerAngles
			end

			if arg_120_1.time_ >= 1.9 + var_123_14 and arg_120_1.time_ < 1.9 + var_123_14 + arg_123_0 then
				var_123_13.localPosition = Vector3.New(0, 100, 0)
				var_123_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_13.position).x, (manager.ui.mainCamera.transform.position - var_123_13.position).y, (manager.ui.mainCamera.transform.position - var_123_13.position).z)
				var_123_13.localEulerAngles.z = 0
				var_123_13.localEulerAngles.x = 0
				var_123_13.localEulerAngles = var_123_13.localEulerAngles
			end

			local var_123_15 = arg_120_1.actors_["1084ui_story"].transform

			if 1.9 < arg_120_1.time_ and arg_120_1.time_ <= 1.9 + arg_123_0 then
				arg_120_1.var_.moveOldPos1084ui_story = var_123_15.localPosition
			end

			local var_123_16 = 0.001

			if 1.9 <= arg_120_1.time_ and arg_120_1.time_ < 1.9 + var_123_16 then
				var_123_15.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 1.9) / var_123_16)
				var_123_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_15.position).x, (manager.ui.mainCamera.transform.position - var_123_15.position).y, (manager.ui.mainCamera.transform.position - var_123_15.position).z)
				var_123_15.localEulerAngles.z = 0
				var_123_15.localEulerAngles.x = 0
				var_123_15.localEulerAngles = var_123_15.localEulerAngles
			end

			if arg_120_1.time_ >= 1.9 + var_123_16 and arg_120_1.time_ < 1.9 + var_123_16 + arg_123_0 then
				var_123_15.localPosition = Vector3.New(0, 100, 0)
				var_123_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_15.position).x, (manager.ui.mainCamera.transform.position - var_123_15.position).y, (manager.ui.mainCamera.transform.position - var_123_15.position).z)
				var_123_15.localEulerAngles.z = 0
				var_123_15.localEulerAngles.x = 0
				var_123_15.localEulerAngles = var_123_15.localEulerAngles
			end

			local var_123_17 = arg_120_1.actors_["4010ui_story"]

			if 1.9 < arg_120_1.time_ and arg_120_1.time_ <= 1.9 + arg_123_0 and not isNil(var_123_17) and arg_120_1.var_.characterEffect4010ui_story == nil then
				arg_120_1.var_.characterEffect4010ui_story = var_123_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_18 = 0.200000002980232

			if 1.9 <= arg_120_1.time_ and arg_120_1.time_ < 1.9 + var_123_18 and not isNil(var_123_17) then
				if arg_120_1.var_.characterEffect4010ui_story and not isNil(var_123_17) then
					arg_120_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_120_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 1.9) / var_123_18)
				end
			end

			if arg_120_1.time_ >= 1.9 + var_123_18 and arg_120_1.time_ < 1.9 + var_123_18 + arg_123_0 and not isNil(var_123_17) and arg_120_1.var_.characterEffect4010ui_story then
				arg_120_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_120_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_19 = 3.3
			local var_123_20 = 1.1

			if 3.3 < arg_120_1.time_ and arg_120_1.time_ <= var_123_19 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_21 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_21:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_22 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(304122030).content)

				arg_120_1.text_.text = var_123_22

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_24 = 44 <= 0 and var_123_20 or var_123_20 * (utf8.len(var_123_22) / 44)

				if (44 <= 0 and var_123_20 or var_123_20 * (utf8.len(var_123_22) / 44)) > 0 and var_123_20 < var_123_24 then
					arg_120_1.talkMaxDuration = var_123_24
					var_123_19 = var_123_19 + 0.3

					if var_123_24 + var_123_19 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_24 + var_123_19
					end
				end

				arg_120_1.text_.text = var_123_22
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_25 = var_123_19 + 0.3
			local var_123_26 = math.max(var_123_20, arg_120_1.talkMaxDuration)

			if var_123_19 + 0.3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_25 + var_123_26 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_25) / var_123_26

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_25 + var_123_26 and arg_120_1.time_ < var_123_25 + var_123_26 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play304122031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 304122031
		arg_126_1.duration_ = 5.23

		local var_126_0 = {
			zh = 5.233,
			ja = 1.999999999999
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play304122032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = arg_126_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1084ui_story"].transform.position).z)
				arg_126_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1084ui_story"].transform.localEulerAngles = arg_126_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_126_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1084ui_story"].transform.position).z)
				arg_126_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1084ui_story"].transform.localEulerAngles = arg_126_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_129_1 = arg_126_1.actors_["1084ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = var_129_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 and not isNil(var_129_1) then
				if arg_126_1.var_.characterEffect1084ui_story and not isNil(var_129_1) then
					arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1084ui_story then
				arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_129_4 = 0
			local var_129_5 = 0.375

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_6 = arg_126_1:GetWordFromCfg(304122031)
				local var_129_7 = arg_126_1:FormatText(var_129_6.content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_9 = 15 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 15)

				if (15 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 15)) > 0 and var_129_5 < var_129_9 then
					arg_126_1.talkMaxDuration = var_129_9

					if var_129_9 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_4
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122031", "story_v_out_304122.awb") ~= 0 then
					local var_129_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122031", "story_v_out_304122.awb") / 1000

					if var_129_10 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_4
					end

					if var_129_6.prefab_name ~= "" and arg_126_1.actors_[var_129_6.prefab_name] ~= nil then
						local var_129_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_6.prefab_name].transform, "story_v_out_304122", "304122031", "story_v_out_304122.awb")

						arg_126_1:RecordAudio("304122031", var_129_11)
						arg_126_1:RecordAudio("304122031", var_129_11)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_304122", "304122031", "story_v_out_304122.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_304122", "304122031", "story_v_out_304122.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_12 = math.max(var_129_5, arg_126_1.talkMaxDuration)

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_12 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_4) / var_129_12

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_4 + var_129_12 and arg_126_1.time_ < var_129_4 + var_129_12 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play304122032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 304122032
		arg_130_1.duration_ = 8.67

		local var_130_0 = {
			zh = 5.333,
			ja = 8.666
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play304122033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1011ui_story = arg_130_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).z)
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles = arg_130_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_130_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).z)
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles = arg_130_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_133_1 = arg_130_1.actors_["1011ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1011ui_story == nil then
				arg_130_1.var_.characterEffect1011ui_story = var_133_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_2 and not isNil(var_133_1) then
				if arg_130_1.var_.characterEffect1011ui_story and not isNil(var_133_1) then
					arg_130_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_2 and arg_130_1.time_ < 0 + var_133_2 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1011ui_story then
				arg_130_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_133_4 = arg_130_1.actors_["1084ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1084ui_story == nil then
				arg_130_1.var_.characterEffect1084ui_story = var_133_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_5 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_5 and not isNil(var_133_4) then
				if arg_130_1.var_.characterEffect1084ui_story and not isNil(var_133_4) then
					arg_130_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_5)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_5 and arg_130_1.time_ < 0 + var_133_5 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1084ui_story then
				arg_130_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_133_6 = 0
			local var_133_7 = 0.575

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_8 = arg_130_1:GetWordFromCfg(304122032)
				local var_133_9 = arg_130_1:FormatText(var_133_8.content)

				arg_130_1.text_.text = var_133_9

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 23 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 23)

				if (23 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 23)) > 0 and var_133_7 < var_133_11 then
					arg_130_1.talkMaxDuration = var_133_11

					if var_133_11 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_9
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122032", "story_v_out_304122.awb") ~= 0 then
					local var_133_12 = manager.audio:GetVoiceLength("story_v_out_304122", "304122032", "story_v_out_304122.awb") / 1000

					if var_133_12 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_6
					end

					if var_133_8.prefab_name ~= "" and arg_130_1.actors_[var_133_8.prefab_name] ~= nil then
						local var_133_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_8.prefab_name].transform, "story_v_out_304122", "304122032", "story_v_out_304122.awb")

						arg_130_1:RecordAudio("304122032", var_133_13)
						arg_130_1:RecordAudio("304122032", var_133_13)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_304122", "304122032", "story_v_out_304122.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_304122", "304122032", "story_v_out_304122.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_14 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_14 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_14

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_14 and arg_130_1.time_ < var_133_6 + var_133_14 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play304122033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 304122033
		arg_134_1.duration_ = 6.83

		local var_134_0 = {
			zh = 4.8,
			ja = 6.833
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play304122034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1019ui_story = arg_134_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1019ui_story"].transform.position).z)
				arg_134_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1019ui_story"].transform.localEulerAngles = arg_134_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_134_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1019ui_story"].transform.position).z)
				arg_134_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1019ui_story"].transform.localEulerAngles = arg_134_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["1011ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1011ui_story = var_137_1.localPosition
			end

			local var_137_2 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 then
				var_137_1.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_134_1.time_ - 0) / var_137_2)
				var_137_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_1.position).x, (manager.ui.mainCamera.transform.position - var_137_1.position).y, (manager.ui.mainCamera.transform.position - var_137_1.position).z)
				var_137_1.localEulerAngles.z = 0
				var_137_1.localEulerAngles.x = 0
				var_137_1.localEulerAngles = var_137_1.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 then
				var_137_1.localPosition = Vector3.New(0, 100, 0)
				var_137_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_1.position).x, (manager.ui.mainCamera.transform.position - var_137_1.position).y, (manager.ui.mainCamera.transform.position - var_137_1.position).z)
				var_137_1.localEulerAngles.z = 0
				var_137_1.localEulerAngles.x = 0
				var_137_1.localEulerAngles = var_137_1.localEulerAngles
			end

			local var_137_3 = arg_134_1.actors_["1084ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1084ui_story = var_137_3.localPosition
			end

			local var_137_4 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				var_137_3.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_134_1.time_ - 0) / var_137_4)
				var_137_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_3.position).x, (manager.ui.mainCamera.transform.position - var_137_3.position).y, (manager.ui.mainCamera.transform.position - var_137_3.position).z)
				var_137_3.localEulerAngles.z = 0
				var_137_3.localEulerAngles.x = 0
				var_137_3.localEulerAngles = var_137_3.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
				var_137_3.localPosition = Vector3.New(0, 100, 0)
				var_137_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_3.position).x, (manager.ui.mainCamera.transform.position - var_137_3.position).y, (manager.ui.mainCamera.transform.position - var_137_3.position).z)
				var_137_3.localEulerAngles.z = 0
				var_137_3.localEulerAngles.x = 0
				var_137_3.localEulerAngles = var_137_3.localEulerAngles
			end

			local var_137_5 = arg_134_1.actors_["1019ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.characterEffect1019ui_story == nil then
				arg_134_1.var_.characterEffect1019ui_story = var_137_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_6 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_6 and not isNil(var_137_5) then
				if arg_134_1.var_.characterEffect1019ui_story and not isNil(var_137_5) then
					arg_134_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_6 and arg_134_1.time_ < 0 + var_137_6 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.characterEffect1019ui_story then
				arg_134_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_137_8 = arg_134_1.actors_["1011ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.characterEffect1011ui_story == nil then
				arg_134_1.var_.characterEffect1011ui_story = var_137_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_9 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_9 and not isNil(var_137_8) then
				if arg_134_1.var_.characterEffect1011ui_story and not isNil(var_137_8) then
					arg_134_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_9)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_9 and arg_134_1.time_ < 0 + var_137_9 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.characterEffect1011ui_story then
				arg_134_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_10 = 0
			local var_137_11 = 0.625

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_12 = arg_134_1:GetWordFromCfg(304122033)
				local var_137_13 = arg_134_1:FormatText(var_137_12.content)

				arg_134_1.text_.text = var_137_13

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_15 = 25 <= 0 and var_137_11 or var_137_11 * (utf8.len(var_137_13) / 25)

				if (25 <= 0 and var_137_11 or var_137_11 * (utf8.len(var_137_13) / 25)) > 0 and var_137_11 < var_137_15 then
					arg_134_1.talkMaxDuration = var_137_15

					if var_137_15 + var_137_10 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_15 + var_137_10
					end
				end

				arg_134_1.text_.text = var_137_13
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122033", "story_v_out_304122.awb") ~= 0 then
					local var_137_16 = manager.audio:GetVoiceLength("story_v_out_304122", "304122033", "story_v_out_304122.awb") / 1000

					if var_137_16 + var_137_10 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_16 + var_137_10
					end

					if var_137_12.prefab_name ~= "" and arg_134_1.actors_[var_137_12.prefab_name] ~= nil then
						local var_137_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_12.prefab_name].transform, "story_v_out_304122", "304122033", "story_v_out_304122.awb")

						arg_134_1:RecordAudio("304122033", var_137_17)
						arg_134_1:RecordAudio("304122033", var_137_17)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_304122", "304122033", "story_v_out_304122.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_304122", "304122033", "story_v_out_304122.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_18 = math.max(var_137_11, arg_134_1.talkMaxDuration)

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_18 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_10) / var_137_18

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_10 + var_137_18 and arg_134_1.time_ < var_137_10 + var_137_18 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play304122034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 304122034
		arg_138_1.duration_ = 5.37

		local var_138_0 = {
			zh = 4.433,
			ja = 5.366
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play304122035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1011ui_story = arg_138_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).z)
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles = arg_138_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_138_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).z)
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles = arg_138_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_141_1 = arg_138_1.actors_["1019ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1019ui_story = var_141_1.localPosition
			end

			local var_141_2 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 then
				var_141_1.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_138_1.time_ - 0) / var_141_2)
				var_141_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_1.position).x, (manager.ui.mainCamera.transform.position - var_141_1.position).y, (manager.ui.mainCamera.transform.position - var_141_1.position).z)
				var_141_1.localEulerAngles.z = 0
				var_141_1.localEulerAngles.x = 0
				var_141_1.localEulerAngles = var_141_1.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 then
				var_141_1.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_141_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_1.position).x, (manager.ui.mainCamera.transform.position - var_141_1.position).y, (manager.ui.mainCamera.transform.position - var_141_1.position).z)
				var_141_1.localEulerAngles.z = 0
				var_141_1.localEulerAngles.x = 0
				var_141_1.localEulerAngles = var_141_1.localEulerAngles
			end

			local var_141_3 = arg_138_1.actors_["1011ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect1011ui_story == nil then
				arg_138_1.var_.characterEffect1011ui_story = var_141_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_4 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 and not isNil(var_141_3) then
				if arg_138_1.var_.characterEffect1011ui_story and not isNil(var_141_3) then
					arg_138_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect1011ui_story then
				arg_138_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_141_6 = arg_138_1.actors_["1019ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect1019ui_story == nil then
				arg_138_1.var_.characterEffect1019ui_story = var_141_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_7 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 and not isNil(var_141_6) then
				if arg_138_1.var_.characterEffect1019ui_story and not isNil(var_141_6) then
					arg_138_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_7)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect1019ui_story then
				arg_138_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_141_8 = 0
			local var_141_9 = 0.55

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_8 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_10 = arg_138_1:GetWordFromCfg(304122034)
				local var_141_11 = arg_138_1:FormatText(var_141_10.content)

				arg_138_1.text_.text = var_141_11

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_13 = 22 <= 0 and var_141_9 or var_141_9 * (utf8.len(var_141_11) / 22)

				if (22 <= 0 and var_141_9 or var_141_9 * (utf8.len(var_141_11) / 22)) > 0 and var_141_9 < var_141_13 then
					arg_138_1.talkMaxDuration = var_141_13

					if var_141_13 + var_141_8 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_8
					end
				end

				arg_138_1.text_.text = var_141_11
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122034", "story_v_out_304122.awb") ~= 0 then
					local var_141_14 = manager.audio:GetVoiceLength("story_v_out_304122", "304122034", "story_v_out_304122.awb") / 1000

					if var_141_14 + var_141_8 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_14 + var_141_8
					end

					if var_141_10.prefab_name ~= "" and arg_138_1.actors_[var_141_10.prefab_name] ~= nil then
						local var_141_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_10.prefab_name].transform, "story_v_out_304122", "304122034", "story_v_out_304122.awb")

						arg_138_1:RecordAudio("304122034", var_141_15)
						arg_138_1:RecordAudio("304122034", var_141_15)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_304122", "304122034", "story_v_out_304122.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_304122", "304122034", "story_v_out_304122.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_16 = math.max(var_141_9, arg_138_1.talkMaxDuration)

			if var_141_8 <= arg_138_1.time_ and arg_138_1.time_ < var_141_8 + var_141_16 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_8) / var_141_16

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_8 + var_141_16 and arg_138_1.time_ < var_141_8 + var_141_16 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play304122035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 304122035
		arg_142_1.duration_ = 10.47

		local var_142_0 = {
			zh = 6.7,
			ja = 10.466
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play304122036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_2")
			end

			local var_145_0 = 0
			local var_145_1 = 0.8

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(304122035)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 32 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 32)

				if (32 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 32)) > 0 and var_145_1 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122035", "story_v_out_304122.awb") ~= 0 then
					local var_145_6 = manager.audio:GetVoiceLength("story_v_out_304122", "304122035", "story_v_out_304122.awb") / 1000

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end

					if var_145_2.prefab_name ~= "" and arg_142_1.actors_[var_145_2.prefab_name] ~= nil then
						local var_145_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_2.prefab_name].transform, "story_v_out_304122", "304122035", "story_v_out_304122.awb")

						arg_142_1:RecordAudio("304122035", var_145_7)
						arg_142_1:RecordAudio("304122035", var_145_7)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_304122", "304122035", "story_v_out_304122.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_304122", "304122035", "story_v_out_304122.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_8 and arg_142_1.time_ < var_145_0 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play304122036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 304122036
		arg_146_1.duration_ = 18.47

		local var_146_0 = {
			zh = 8.1,
			ja = 18.466
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play304122037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1019ui_story"]) and arg_146_1.var_.characterEffect1019ui_story == nil then
				arg_146_1.var_.characterEffect1019ui_story = arg_146_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1019ui_story"]) then
				if arg_146_1.var_.characterEffect1019ui_story and not isNil(arg_146_1.actors_["1019ui_story"]) then
					arg_146_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1019ui_story"]) and arg_146_1.var_.characterEffect1019ui_story then
				arg_146_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_149_2 = arg_146_1.actors_["1011ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect1011ui_story == nil then
				arg_146_1.var_.characterEffect1011ui_story = var_149_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_3 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 and not isNil(var_149_2) then
				if arg_146_1.var_.characterEffect1011ui_story and not isNil(var_149_2) then
					arg_146_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_3)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect1011ui_story then
				arg_146_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_149_4 = 0
			local var_149_5 = 1.025

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(304122036)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 41 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 41)

				if (41 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 41)) > 0 and var_149_5 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122036", "story_v_out_304122.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122036", "story_v_out_304122.awb") / 1000

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end

					if var_149_6.prefab_name ~= "" and arg_146_1.actors_[var_149_6.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_6.prefab_name].transform, "story_v_out_304122", "304122036", "story_v_out_304122.awb")

						arg_146_1:RecordAudio("304122036", var_149_11)
						arg_146_1:RecordAudio("304122036", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_304122", "304122036", "story_v_out_304122.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_304122", "304122036", "story_v_out_304122.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_12 and arg_146_1.time_ < var_149_4 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play304122037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 304122037
		arg_150_1.duration_ = 3.93

		local var_150_0 = {
			zh = 3.466,
			ja = 3.933
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play304122038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.45

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:GetWordFromCfg(304122037)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 18 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 18)

				if (18 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 18)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122037", "story_v_out_304122.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122037", "story_v_out_304122.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_304122", "304122037", "story_v_out_304122.awb")

						arg_150_1:RecordAudio("304122037", var_153_6)
						arg_150_1:RecordAudio("304122037", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_304122", "304122037", "story_v_out_304122.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_304122", "304122037", "story_v_out_304122.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play304122038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 304122038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play304122039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1019ui_story = arg_154_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_157_0 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 then
				arg_154_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_0)
				arg_154_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1019ui_story"].transform.position).z)
				arg_154_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1019ui_story"].transform.localEulerAngles = arg_154_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 then
				arg_154_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1019ui_story"].transform.position).z)
				arg_154_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1019ui_story"].transform.localEulerAngles = arg_154_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_157_1 = arg_154_1.actors_["1011ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1011ui_story = var_157_1.localPosition
			end

			local var_157_2 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_2 then
				var_157_1.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_2)
				var_157_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_1.position).x, (manager.ui.mainCamera.transform.position - var_157_1.position).y, (manager.ui.mainCamera.transform.position - var_157_1.position).z)
				var_157_1.localEulerAngles.z = 0
				var_157_1.localEulerAngles.x = 0
				var_157_1.localEulerAngles = var_157_1.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_2 and arg_154_1.time_ < 0 + var_157_2 + arg_157_0 then
				var_157_1.localPosition = Vector3.New(0, 100, 0)
				var_157_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_1.position).x, (manager.ui.mainCamera.transform.position - var_157_1.position).y, (manager.ui.mainCamera.transform.position - var_157_1.position).z)
				var_157_1.localEulerAngles.z = 0
				var_157_1.localEulerAngles.x = 0
				var_157_1.localEulerAngles = var_157_1.localEulerAngles
			end

			local var_157_3 = arg_154_1.actors_["1019ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_3) and arg_154_1.var_.characterEffect1019ui_story == nil then
				arg_154_1.var_.characterEffect1019ui_story = var_157_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_4 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 and not isNil(var_157_3) then
				if arg_154_1.var_.characterEffect1019ui_story and not isNil(var_157_3) then
					arg_154_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_4)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 and not isNil(var_157_3) and arg_154_1.var_.characterEffect1019ui_story then
				arg_154_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_157_5 = 0
			local var_157_6 = 1.275

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_7 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(304122038).content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 51 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_7) / 51)

				if (51 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_7) / 51)) > 0 and var_157_6 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_5
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_6, arg_154_1.talkMaxDuration)

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_5) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_5 + var_157_10 and arg_154_1.time_ < var_157_5 + var_157_10 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play304122039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 304122039
		arg_158_1.duration_ = 7.2

		local var_158_0 = {
			zh = 4.066,
			ja = 7.2
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play304122040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1019ui_story = arg_158_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_161_0 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 then
				arg_158_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_158_1.time_ - 0) / var_161_0)
				arg_158_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1019ui_story"].transform.position).z)
				arg_158_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1019ui_story"].transform.localEulerAngles = arg_158_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 then
				arg_158_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_158_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1019ui_story"].transform.position).z)
				arg_158_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1019ui_story"].transform.localEulerAngles = arg_158_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_161_1 = arg_158_1.actors_["1019ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1019ui_story == nil then
				arg_158_1.var_.characterEffect1019ui_story = var_161_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_2 and not isNil(var_161_1) then
				if arg_158_1.var_.characterEffect1019ui_story and not isNil(var_161_1) then
					arg_158_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_2 and arg_158_1.time_ < 0 + var_161_2 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1019ui_story then
				arg_158_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_161_4 = 0
			local var_161_5 = 0.5

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_6 = arg_158_1:GetWordFromCfg(304122039)
				local var_161_7 = arg_158_1:FormatText(var_161_6.content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 20 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 20)

				if (20 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 20)) > 0 and var_161_5 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_4
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122039", "story_v_out_304122.awb") ~= 0 then
					local var_161_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122039", "story_v_out_304122.awb") / 1000

					if var_161_10 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_10 + var_161_4
					end

					if var_161_6.prefab_name ~= "" and arg_158_1.actors_[var_161_6.prefab_name] ~= nil then
						local var_161_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_6.prefab_name].transform, "story_v_out_304122", "304122039", "story_v_out_304122.awb")

						arg_158_1:RecordAudio("304122039", var_161_11)
						arg_158_1:RecordAudio("304122039", var_161_11)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_304122", "304122039", "story_v_out_304122.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_304122", "304122039", "story_v_out_304122.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_12 = math.max(var_161_5, arg_158_1.talkMaxDuration)

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_12 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_4) / var_161_12

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_4 + var_161_12 and arg_158_1.time_ < var_161_4 + var_161_12 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play304122040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 304122040
		arg_162_1.duration_ = 9.53

		local var_162_0 = {
			zh = 5.833,
			ja = 9.533
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play304122041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.75

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:GetWordFromCfg(304122040)
				local var_165_2 = arg_162_1:FormatText(var_165_1.content)

				arg_162_1.text_.text = var_165_2

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 30 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 30)

				if (30 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 30)) > 0 and var_165_0 < var_165_4 then
					arg_162_1.talkMaxDuration = var_165_4

					if var_165_4 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_4 + 0
					end
				end

				arg_162_1.text_.text = var_165_2
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122040", "story_v_out_304122.awb") ~= 0 then
					local var_165_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122040", "story_v_out_304122.awb") / 1000

					if var_165_5 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + 0
					end

					if var_165_1.prefab_name ~= "" and arg_162_1.actors_[var_165_1.prefab_name] ~= nil then
						local var_165_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_1.prefab_name].transform, "story_v_out_304122", "304122040", "story_v_out_304122.awb")

						arg_162_1:RecordAudio("304122040", var_165_6)
						arg_162_1:RecordAudio("304122040", var_165_6)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_304122", "304122040", "story_v_out_304122.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_304122", "304122040", "story_v_out_304122.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play304122041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 304122041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play304122042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1019ui_story"]) and arg_166_1.var_.characterEffect1019ui_story == nil then
				arg_166_1.var_.characterEffect1019ui_story = arg_166_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1019ui_story"]) then
				if arg_166_1.var_.characterEffect1019ui_story and not isNil(arg_166_1.actors_["1019ui_story"]) then
					arg_166_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_0)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1019ui_story"]) and arg_166_1.var_.characterEffect1019ui_story then
				arg_166_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_169_1 = 0
			local var_169_2 = 0.775

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_166_1.callingController_:SetSelectedState("calling")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(304122041).content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 29 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 29)

				if (29 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 29)) > 0 and var_169_2 < var_169_5 then
					arg_166_1.talkMaxDuration = var_169_5

					if var_169_5 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_6 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_6 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_6

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_6 and arg_166_1.time_ < var_169_1 + var_169_6 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play304122042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 304122042
		arg_170_1.duration_ = 11.45

		local var_170_0 = {
			zh = 8.615999999998,
			ja = 11.449999999998
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play304122043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if arg_170_1.bgs_.S0401 == nil then
				local var_173_0 = Object.Instantiate(arg_170_1.paintGo_)

				var_173_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0401")
				var_173_0.name = "S0401"
				var_173_0.transform.parent = arg_170_1.stage_.transform
				var_173_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.bgs_.S0401 = var_173_0
			end

			if 1.999999999999 < arg_170_1.time_ and arg_170_1.time_ <= 1.999999999999 + arg_173_0 then
				local var_173_1 = arg_170_1.bgs_.S0401

				arg_170_1.bgs_.S0401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_173_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_173_2 = var_173_1:GetComponent("SpriteRenderer")

				if var_173_2 and var_173_2.sprite then
					local var_173_3 = 2 * (var_173_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_173_1.transform.localScale = Vector3.New(var_173_3 / var_173_2.sprite.bounds.size.y < var_173_3 * manager.ui.mainCameraCom_.aspect / var_173_2.sprite.bounds.size.x and var_173_3 * manager.ui.mainCameraCom_.aspect / var_173_2.sprite.bounds.size.x or var_173_3 / var_173_2.sprite.bounds.size.y, var_173_3 / var_173_2.sprite.bounds.size.y < var_173_3 * manager.ui.mainCameraCom_.aspect / var_173_2.sprite.bounds.size.x and var_173_3 * manager.ui.mainCameraCom_.aspect / var_173_2.sprite.bounds.size.x or var_173_3 / var_173_2.sprite.bounds.size.y, 0)
				end

				for iter_173_0, iter_173_1 in pairs(arg_170_1.bgs_) do
					if iter_173_0 ~= "S0401" then
						iter_173_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_173_4 = 1.999999999999

			if 1.999999999999 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.allBtn_.enabled = false
			end

			if arg_170_1.time_ >= var_173_4 + 0.3 and arg_170_1.time_ < var_173_4 + 0.3 + arg_173_0 then
				arg_170_1.allBtn_.enabled = true
			end

			local var_173_5 = 0

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 then
				arg_170_1.mask_.enabled = true
				arg_170_1.mask_.raycastTarget = true

				arg_170_1:SetGaussion(false)
			end

			local var_173_6 = 2

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_6 then
				local var_173_7 = Color.New(0, 0, 0)

				var_173_7.a = Mathf.Lerp(0, 1, (arg_170_1.time_ - var_173_5) / var_173_6)
				arg_170_1.mask_.color = var_173_7
			end

			if arg_170_1.time_ >= var_173_5 + var_173_6 and arg_170_1.time_ < var_173_5 + var_173_6 + arg_173_0 then
				local var_173_8 = Color.New(0, 0, 0)

				var_173_8.a = 1
				arg_170_1.mask_.color = var_173_8
			end

			local var_173_9 = 1.999999999999

			if 1.999999999999 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 then
				arg_170_1.mask_.enabled = true
				arg_170_1.mask_.raycastTarget = true

				arg_170_1:SetGaussion(false)
			end

			local var_173_10 = 2

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_10 then
				local var_173_11 = Color.New(0, 0, 0)

				var_173_11.a = Mathf.Lerp(1, 0, (arg_170_1.time_ - var_173_9) / var_173_10)
				arg_170_1.mask_.color = var_173_11
			end

			if arg_170_1.time_ >= var_173_9 + var_173_10 and arg_170_1.time_ < var_173_9 + var_173_10 + arg_173_0 then
				local var_173_12 = Color.New(0, 0, 0)

				arg_170_1.mask_.enabled = false
				var_173_12.a = 0
				arg_170_1.mask_.color = var_173_12
			end

			local var_173_13 = arg_170_1.actors_["1019ui_story"].transform

			if 1.999999999999 < arg_170_1.time_ and arg_170_1.time_ <= 1.999999999999 + arg_173_0 then
				arg_170_1.var_.moveOldPos1019ui_story = var_173_13.localPosition
			end

			local var_173_14 = 0.001

			if 1.999999999999 <= arg_170_1.time_ and arg_170_1.time_ < 1.999999999999 + var_173_14 then
				var_173_13.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_170_1.time_ - 1.999999999999) / var_173_14)
				var_173_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_13.position).x, (manager.ui.mainCamera.transform.position - var_173_13.position).y, (manager.ui.mainCamera.transform.position - var_173_13.position).z)
				var_173_13.localEulerAngles.z = 0
				var_173_13.localEulerAngles.x = 0
				var_173_13.localEulerAngles = var_173_13.localEulerAngles
			end

			if arg_170_1.time_ >= 1.999999999999 + var_173_14 and arg_170_1.time_ < 1.999999999999 + var_173_14 + arg_173_0 then
				var_173_13.localPosition = Vector3.New(0, 100, 0)
				var_173_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_13.position).x, (manager.ui.mainCamera.transform.position - var_173_13.position).y, (manager.ui.mainCamera.transform.position - var_173_13.position).z)
				var_173_13.localEulerAngles.z = 0
				var_173_13.localEulerAngles.x = 0
				var_173_13.localEulerAngles = var_173_13.localEulerAngles
			end

			local var_173_15 = "1036ui_story"

			if arg_170_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_173_16 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_170_1.stage_.transform)

				var_173_16.name = var_173_15
				var_173_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.actors_[var_173_15] = var_173_16

				local var_173_17 = var_173_16:GetComponentInChildren(typeof(CharacterEffect))

				var_173_17.enabled = true

				local var_173_18 = GameObjectTools.GetOrAddComponent(var_173_16, typeof(DynamicBoneHelper))

				if var_173_18 then
					var_173_18:EnableDynamicBone(false)
				end

				arg_170_1:ShowWeapon(var_173_17.transform, false)

				arg_170_1.var_[var_173_15 .. "Animator"] = var_173_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_170_1.var_[var_173_15 .. "Animator"].applyRootMotion = true
				arg_170_1.var_[var_173_15 .. "LipSync"] = var_173_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_173_19 = arg_170_1.actors_["1036ui_story"]

			if 1.999999999999 < arg_170_1.time_ and arg_170_1.time_ <= 1.999999999999 + arg_173_0 and not isNil(var_173_19) and arg_170_1.var_.characterEffect1036ui_story == nil then
				arg_170_1.var_.characterEffect1036ui_story = var_173_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_20 = 0.200000002980232

			if 1.999999999999 <= arg_170_1.time_ and arg_170_1.time_ < 1.999999999999 + var_173_20 and not isNil(var_173_19) then
				if arg_170_1.var_.characterEffect1036ui_story and not isNil(var_173_19) then
					arg_170_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 1.999999999999 + var_173_20 and arg_170_1.time_ < 1.999999999999 + var_173_20 + arg_173_0 and not isNil(var_173_19) and arg_170_1.var_.characterEffect1036ui_story then
				arg_170_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if arg_170_1.frameCnt_ <= 1 then
				arg_170_1.dialog_:SetActive(false)
			end

			local var_173_22 = 3.149999999998
			local var_173_23 = 0.85

			if 3.149999999998 < arg_170_1.time_ and arg_170_1.time_ <= var_173_22 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0

				arg_170_1.dialog_:SetActive(true)

				arg_170_1.dialogCg_.alpha = 0

				local var_173_24 = LeanTween.value(arg_170_1.dialog_, 0, 1, 0.3)

				var_173_24:setOnUpdate(LuaHelper.FloatAction(function(arg_174_0)
					arg_170_1.dialogCg_.alpha = arg_174_0
				end))
				var_173_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_170_1.dialog_)
					var_173_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_170_1.duration_ = arg_170_1.duration_ + 0.3

				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_25 = arg_170_1:GetWordFromCfg(304122042)
				local var_173_26 = arg_170_1:FormatText(var_173_25.content)

				arg_170_1.text_.text = var_173_26

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_28 = 34 <= 0 and var_173_23 or var_173_23 * (utf8.len(var_173_26) / 34)

				if (34 <= 0 and var_173_23 or var_173_23 * (utf8.len(var_173_26) / 34)) > 0 and var_173_23 < var_173_28 then
					arg_170_1.talkMaxDuration = var_173_28
					var_173_22 = var_173_22 + 0.3

					if var_173_28 + var_173_22 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_28 + var_173_22
					end
				end

				arg_170_1.text_.text = var_173_26
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122042", "story_v_out_304122.awb") ~= 0 then
					local var_173_29 = manager.audio:GetVoiceLength("story_v_out_304122", "304122042", "story_v_out_304122.awb") / 1000

					if var_173_29 + var_173_22 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_29 + var_173_22
					end

					if var_173_25.prefab_name ~= "" and arg_170_1.actors_[var_173_25.prefab_name] ~= nil then
						local var_173_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_25.prefab_name].transform, "story_v_out_304122", "304122042", "story_v_out_304122.awb")

						arg_170_1:RecordAudio("304122042", var_173_30)
						arg_170_1:RecordAudio("304122042", var_173_30)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_304122", "304122042", "story_v_out_304122.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_304122", "304122042", "story_v_out_304122.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_31 = var_173_22 + 0.3
			local var_173_32 = math.max(var_173_23, arg_170_1.talkMaxDuration)

			if var_173_22 + 0.3 <= arg_170_1.time_ and arg_170_1.time_ < var_173_31 + var_173_32 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_31) / var_173_32

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_31 + var_173_32 and arg_170_1.time_ < var_173_31 + var_173_32 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play304122043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 304122043
		arg_176_1.duration_ = 9.83

		local var_176_0 = {
			zh = 6.533,
			ja = 9.833
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play304122044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.85

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_1 = arg_176_1:GetWordFromCfg(304122043)
				local var_179_2 = arg_176_1:FormatText(var_179_1.content)

				arg_176_1.text_.text = var_179_2

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 34 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 34)

				if (34 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 34)) > 0 and var_179_0 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end

				arg_176_1.text_.text = var_179_2
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122043", "story_v_out_304122.awb") ~= 0 then
					local var_179_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122043", "story_v_out_304122.awb") / 1000

					if var_179_5 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + 0
					end

					if var_179_1.prefab_name ~= "" and arg_176_1.actors_[var_179_1.prefab_name] ~= nil then
						local var_179_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_1.prefab_name].transform, "story_v_out_304122", "304122043", "story_v_out_304122.awb")

						arg_176_1:RecordAudio("304122043", var_179_6)
						arg_176_1:RecordAudio("304122043", var_179_6)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_304122", "304122043", "story_v_out_304122.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_304122", "304122043", "story_v_out_304122.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play304122044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 304122044
		arg_180_1.duration_ = 3.47

		local var_180_0 = {
			zh = 1.9,
			ja = 3.466
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play304122045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.275

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_1 = arg_180_1:GetWordFromCfg(304122044)
				local var_183_2 = arg_180_1:FormatText(var_183_1.content)

				arg_180_1.text_.text = var_183_2

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_4 = 11 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 11)

				if (11 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 11)) > 0 and var_183_0 < var_183_4 then
					arg_180_1.talkMaxDuration = var_183_4

					if var_183_4 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_4 + 0
					end
				end

				arg_180_1.text_.text = var_183_2
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122044", "story_v_out_304122.awb") ~= 0 then
					local var_183_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122044", "story_v_out_304122.awb") / 1000

					if var_183_5 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + 0
					end

					if var_183_1.prefab_name ~= "" and arg_180_1.actors_[var_183_1.prefab_name] ~= nil then
						local var_183_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_1.prefab_name].transform, "story_v_out_304122", "304122044", "story_v_out_304122.awb")

						arg_180_1:RecordAudio("304122044", var_183_6)
						arg_180_1:RecordAudio("304122044", var_183_6)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_304122", "304122044", "story_v_out_304122.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_304122", "304122044", "story_v_out_304122.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_7 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_7

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play304122045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 304122045
		arg_184_1.duration_ = 5.9

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play304122046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1036ui_story"]) and arg_184_1.var_.characterEffect1036ui_story == nil then
				arg_184_1.var_.characterEffect1036ui_story = arg_184_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1036ui_story"]) then
				if arg_184_1.var_.characterEffect1036ui_story and not isNil(arg_184_1.actors_["1036ui_story"]) then
					arg_184_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1036ui_story"]) and arg_184_1.var_.characterEffect1036ui_story then
				arg_184_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_187_1 = arg_184_1.bgs_.S0401.transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPosS0401 = var_187_1.localPosition
			end

			local var_187_2 = 2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_2 then
				var_187_1.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPosS0401, Vector3.New(0, 1.27, 8), (arg_184_1.time_ - 0) / var_187_2)
			end

			if arg_184_1.time_ >= 0 + var_187_2 and arg_184_1.time_ < 0 + var_187_2 + arg_187_0 then
				var_187_1.localPosition = Vector3.New(0, 1.27, 8)
			end

			local var_187_3 = 0

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_3 + arg_187_0 then
				arg_184_1.allBtn_.enabled = false
			end

			if arg_184_1.time_ >= var_187_3 + 1 and arg_184_1.time_ < var_187_3 + 1 + arg_187_0 then
				arg_184_1.allBtn_.enabled = true
			end

			if arg_184_1.frameCnt_ <= 1 then
				arg_184_1.dialog_:SetActive(false)
			end

			local var_187_4 = 0.9
			local var_187_5 = 1.625

			if 0.9 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				arg_184_1.dialog_:SetActive(true)

				arg_184_1.dialogCg_.alpha = 0

				local var_187_6 = LeanTween.value(arg_184_1.dialog_, 0, 1, 0.3)

				var_187_6:setOnUpdate(LuaHelper.FloatAction(function(arg_188_0)
					arg_184_1.dialogCg_.alpha = arg_188_0
				end))
				var_187_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_184_1.dialog_)
					var_187_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_184_1.duration_ = arg_184_1.duration_ + 0.3

				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_7 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(304122045).content)

				arg_184_1.text_.text = var_187_7

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_9 = 65 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 65)

				if (65 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 65)) > 0 and var_187_5 < var_187_9 then
					arg_184_1.talkMaxDuration = var_187_9
					var_187_4 = var_187_4 + 0.3

					if var_187_9 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_9 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_7
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = var_187_4 + 0.3
			local var_187_11 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 + 0.3 <= arg_184_1.time_ and arg_184_1.time_ < var_187_10 + var_187_11 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_10) / var_187_11

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_10 + var_187_11 and arg_184_1.time_ < var_187_10 + var_187_11 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "S0401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1.27, 8),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play304122046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 304122046
		arg_190_1.duration_ = 4.93

		local var_190_0 = {
			zh = 3.3,
			ja = 4.933
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play304122047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1036ui_story"]) and arg_190_1.var_.characterEffect1036ui_story == nil then
				arg_190_1.var_.characterEffect1036ui_story = arg_190_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1036ui_story"]) then
				if arg_190_1.var_.characterEffect1036ui_story and not isNil(arg_190_1.actors_["1036ui_story"]) then
					arg_190_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1036ui_story"]) and arg_190_1.var_.characterEffect1036ui_story then
				arg_190_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_193_2 = 0
			local var_193_3 = 0.55

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_4 = arg_190_1:GetWordFromCfg(304122046)
				local var_193_5 = arg_190_1:FormatText(var_193_4.content)

				arg_190_1.text_.text = var_193_5

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_7 = 22 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 22)

				if (22 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 22)) > 0 and var_193_3 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_2
					end
				end

				arg_190_1.text_.text = var_193_5
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122046", "story_v_out_304122.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_304122", "304122046", "story_v_out_304122.awb") / 1000

					if var_193_8 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_2
					end

					if var_193_4.prefab_name ~= "" and arg_190_1.actors_[var_193_4.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_4.prefab_name].transform, "story_v_out_304122", "304122046", "story_v_out_304122.awb")

						arg_190_1:RecordAudio("304122046", var_193_9)
						arg_190_1:RecordAudio("304122046", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_304122", "304122046", "story_v_out_304122.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_304122", "304122046", "story_v_out_304122.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_3, arg_190_1.talkMaxDuration)

			if var_193_2 <= arg_190_1.time_ and arg_190_1.time_ < var_193_2 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_2) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_2 + var_193_10 and arg_190_1.time_ < var_193_2 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play304122047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 304122047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play304122048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1036ui_story"]) and arg_194_1.var_.characterEffect1036ui_story == nil then
				arg_194_1.var_.characterEffect1036ui_story = arg_194_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1036ui_story"]) then
				if arg_194_1.var_.characterEffect1036ui_story and not isNil(arg_194_1.actors_["1036ui_story"]) then
					arg_194_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_0)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1036ui_story"]) and arg_194_1.var_.characterEffect1036ui_story then
				arg_194_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_197_1 = 0
			local var_197_2 = 0.225

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_194_1.callingController_:SetSelectedState("calling")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(304122047).content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 9 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 9)

				if (9 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 9)) > 0 and var_197_2 < var_197_5 then
					arg_194_1.talkMaxDuration = var_197_5

					if var_197_5 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + var_197_1
					end
				end

				arg_194_1.text_.text = var_197_3
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_6 = math.max(var_197_2, arg_194_1.talkMaxDuration)

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_6 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_1) / var_197_6

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_1 + var_197_6 and arg_194_1.time_ < var_197_1 + var_197_6 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play304122048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 304122048
		arg_198_1.duration_ = 8.23

		local var_198_0 = {
			zh = 4.9,
			ja = 8.233
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play304122049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1036ui_story"]) and arg_198_1.var_.characterEffect1036ui_story == nil then
				arg_198_1.var_.characterEffect1036ui_story = arg_198_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1036ui_story"]) then
				if arg_198_1.var_.characterEffect1036ui_story and not isNil(arg_198_1.actors_["1036ui_story"]) then
					arg_198_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1036ui_story"]) and arg_198_1.var_.characterEffect1036ui_story then
				arg_198_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_201_2 = 0
			local var_201_3 = 0.7

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_2 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_4 = arg_198_1:GetWordFromCfg(304122048)
				local var_201_5 = arg_198_1:FormatText(var_201_4.content)

				arg_198_1.text_.text = var_201_5

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_7 = 28 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 28)

				if (28 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 28)) > 0 and var_201_3 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_2
					end
				end

				arg_198_1.text_.text = var_201_5
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122048", "story_v_out_304122.awb") ~= 0 then
					local var_201_8 = manager.audio:GetVoiceLength("story_v_out_304122", "304122048", "story_v_out_304122.awb") / 1000

					if var_201_8 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_2
					end

					if var_201_4.prefab_name ~= "" and arg_198_1.actors_[var_201_4.prefab_name] ~= nil then
						local var_201_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_4.prefab_name].transform, "story_v_out_304122", "304122048", "story_v_out_304122.awb")

						arg_198_1:RecordAudio("304122048", var_201_9)
						arg_198_1:RecordAudio("304122048", var_201_9)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_304122", "304122048", "story_v_out_304122.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_304122", "304122048", "story_v_out_304122.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_3, arg_198_1.talkMaxDuration)

			if var_201_2 <= arg_198_1.time_ and arg_198_1.time_ < var_201_2 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_2) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_2 + var_201_10 and arg_198_1.time_ < var_201_2 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play304122049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 304122049
		arg_202_1.duration_ = 8.27

		local var_202_0 = {
			zh = 6.766,
			ja = 8.266
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play304122050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 1.025

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_1 = arg_202_1:GetWordFromCfg(304122049)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 41 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 41)

				if (41 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 41)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122049", "story_v_out_304122.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122049", "story_v_out_304122.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_304122", "304122049", "story_v_out_304122.awb")

						arg_202_1:RecordAudio("304122049", var_205_6)
						arg_202_1:RecordAudio("304122049", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_304122", "304122049", "story_v_out_304122.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_304122", "304122049", "story_v_out_304122.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play304122050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 304122050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play304122051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1036ui_story"]) and arg_206_1.var_.characterEffect1036ui_story == nil then
				arg_206_1.var_.characterEffect1036ui_story = arg_206_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1036ui_story"]) then
				if arg_206_1.var_.characterEffect1036ui_story and not isNil(arg_206_1.actors_["1036ui_story"]) then
					arg_206_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_0)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1036ui_story"]) and arg_206_1.var_.characterEffect1036ui_story then
				arg_206_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_209_1 = 0

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.allBtn_.enabled = false
			end

			if arg_206_1.time_ >= var_209_1 + 1 and arg_206_1.time_ < var_209_1 + 1 + arg_209_0 then
				arg_206_1.allBtn_.enabled = true
			end

			local var_209_2 = 0
			local var_209_3 = 0.3

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_206_1.callingController_:SetSelectedState("calling")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_4 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(304122050).content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_6 = 12 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_4) / 12)

				if (12 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_4) / 12)) > 0 and var_209_3 < var_209_6 then
					arg_206_1.talkMaxDuration = var_209_6

					if var_209_6 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_4
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_7 and arg_206_1.time_ < var_209_2 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 7,
				className = "StoryShakeNode",
				duration = 0.7,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG_HEAD,
				offset = Vector3.New(4, 0.1, 0.1)
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play304122051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 304122051
		arg_210_1.duration_ = 5.2

		local var_210_0 = {
			zh = 4.166,
			ja = 5.2
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play304122052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1036ui_story"]) and arg_210_1.var_.characterEffect1036ui_story == nil then
				arg_210_1.var_.characterEffect1036ui_story = arg_210_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1036ui_story"]) then
				if arg_210_1.var_.characterEffect1036ui_story and not isNil(arg_210_1.actors_["1036ui_story"]) then
					arg_210_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1036ui_story"]) and arg_210_1.var_.characterEffect1036ui_story then
				arg_210_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_213_2 = 0
			local var_213_3 = 0.575

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_4 = arg_210_1:GetWordFromCfg(304122051)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 23 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 23)

				if (23 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 23)) > 0 and var_213_3 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122051", "story_v_out_304122.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_304122", "304122051", "story_v_out_304122.awb") / 1000

					if var_213_8 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_2
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_out_304122", "304122051", "story_v_out_304122.awb")

						arg_210_1:RecordAudio("304122051", var_213_9)
						arg_210_1:RecordAudio("304122051", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_304122", "304122051", "story_v_out_304122.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_304122", "304122051", "story_v_out_304122.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_10 and arg_210_1.time_ < var_213_2 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play304122052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 304122052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play304122053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1036ui_story"]) and arg_214_1.var_.characterEffect1036ui_story == nil then
				arg_214_1.var_.characterEffect1036ui_story = arg_214_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1036ui_story"]) then
				if arg_214_1.var_.characterEffect1036ui_story and not isNil(arg_214_1.actors_["1036ui_story"]) then
					arg_214_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1036ui_story"]) and arg_214_1.var_.characterEffect1036ui_story then
				arg_214_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 1.025

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("calling")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(304122052).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 41 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 41)

				if (41 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 41)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play304122053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 304122053
		arg_218_1.duration_ = 2.03

		local var_218_0 = {
			zh = 2,
			ja = 2.033
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play304122054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1036ui_story"]) and arg_218_1.var_.characterEffect1036ui_story == nil then
				arg_218_1.var_.characterEffect1036ui_story = arg_218_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1036ui_story"]) then
				if arg_218_1.var_.characterEffect1036ui_story and not isNil(arg_218_1.actors_["1036ui_story"]) then
					arg_218_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1036ui_story"]) and arg_218_1.var_.characterEffect1036ui_story then
				arg_218_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_221_2 = 0
			local var_221_3 = 0.25

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_4 = arg_218_1:GetWordFromCfg(304122053)
				local var_221_5 = arg_218_1:FormatText(var_221_4.content)

				arg_218_1.text_.text = var_221_5

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_7 = 10 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 10)

				if (10 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 10)) > 0 and var_221_3 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_2
					end
				end

				arg_218_1.text_.text = var_221_5
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122053", "story_v_out_304122.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_304122", "304122053", "story_v_out_304122.awb") / 1000

					if var_221_8 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_2
					end

					if var_221_4.prefab_name ~= "" and arg_218_1.actors_[var_221_4.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_4.prefab_name].transform, "story_v_out_304122", "304122053", "story_v_out_304122.awb")

						arg_218_1:RecordAudio("304122053", var_221_9)
						arg_218_1:RecordAudio("304122053", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_304122", "304122053", "story_v_out_304122.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_304122", "304122053", "story_v_out_304122.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_3, arg_218_1.talkMaxDuration)

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_2) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_2 + var_221_10 and arg_218_1.time_ < var_221_2 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play304122054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 304122054
		arg_222_1.duration_ = 9.73

		local var_222_0 = {
			zh = 7.4,
			ja = 9.733
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play304122055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.625

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:GetWordFromCfg(304122054)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 25 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 25)

				if (25 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 25)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122054", "story_v_out_304122.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122054", "story_v_out_304122.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_304122", "304122054", "story_v_out_304122.awb")

						arg_222_1:RecordAudio("304122054", var_225_6)
						arg_222_1:RecordAudio("304122054", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_304122", "304122054", "story_v_out_304122.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_304122", "304122054", "story_v_out_304122.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play304122055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 304122055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play304122056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1036ui_story"]) and arg_226_1.var_.characterEffect1036ui_story == nil then
				arg_226_1.var_.characterEffect1036ui_story = arg_226_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1036ui_story"]) then
				if arg_226_1.var_.characterEffect1036ui_story and not isNil(arg_226_1.actors_["1036ui_story"]) then
					arg_226_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1036ui_story"]) and arg_226_1.var_.characterEffect1036ui_story then
				arg_226_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 1.225

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(304122055).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 49 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 49)

				if (49 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 49)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play304122056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 304122056
		arg_230_1.duration_ = 5.33

		local var_230_0 = {
			zh = 3.366,
			ja = 5.333
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play304122057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1036ui_story"]) and arg_230_1.var_.characterEffect1036ui_story == nil then
				arg_230_1.var_.characterEffect1036ui_story = arg_230_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1036ui_story"]) then
				if arg_230_1.var_.characterEffect1036ui_story and not isNil(arg_230_1.actors_["1036ui_story"]) then
					arg_230_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1036ui_story"]) and arg_230_1.var_.characterEffect1036ui_story then
				arg_230_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_233_2 = 0
			local var_233_3 = 0.425

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_4 = arg_230_1:GetWordFromCfg(304122056)
				local var_233_5 = arg_230_1:FormatText(var_233_4.content)

				arg_230_1.text_.text = var_233_5

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 17 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 17)

				if (17 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 17)) > 0 and var_233_3 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_5
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122056", "story_v_out_304122.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_304122", "304122056", "story_v_out_304122.awb") / 1000

					if var_233_8 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_2
					end

					if var_233_4.prefab_name ~= "" and arg_230_1.actors_[var_233_4.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_4.prefab_name].transform, "story_v_out_304122", "304122056", "story_v_out_304122.awb")

						arg_230_1:RecordAudio("304122056", var_233_9)
						arg_230_1:RecordAudio("304122056", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_304122", "304122056", "story_v_out_304122.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_304122", "304122056", "story_v_out_304122.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_10 and arg_230_1.time_ < var_233_2 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play304122057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 304122057
		arg_234_1.duration_ = 1.03

		local var_234_0 = {
			zh = 1.033,
			ja = 0.999999999999
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play304122058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.1

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_1 = arg_234_1:GetWordFromCfg(304122057)
				local var_237_2 = arg_234_1:FormatText(var_237_1.content)

				arg_234_1.text_.text = var_237_2

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 4 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 4)

				if (4 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 4)) > 0 and var_237_0 < var_237_4 then
					arg_234_1.talkMaxDuration = var_237_4

					if var_237_4 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_4 + 0
					end
				end

				arg_234_1.text_.text = var_237_2
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122057", "story_v_out_304122.awb") ~= 0 then
					local var_237_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122057", "story_v_out_304122.awb") / 1000

					if var_237_5 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + 0
					end

					if var_237_1.prefab_name ~= "" and arg_234_1.actors_[var_237_1.prefab_name] ~= nil then
						local var_237_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_1.prefab_name].transform, "story_v_out_304122", "304122057", "story_v_out_304122.awb")

						arg_234_1:RecordAudio("304122057", var_237_6)
						arg_234_1:RecordAudio("304122057", var_237_6)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_304122", "304122057", "story_v_out_304122.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_304122", "304122057", "story_v_out_304122.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play304122058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 304122058
		arg_238_1.duration_ = 7.6

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play304122059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if arg_238_1.bgs_.B03e == nil then
				local var_241_0 = Object.Instantiate(arg_238_1.paintGo_)

				var_241_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B03e")
				var_241_0.name = "B03e"
				var_241_0.transform.parent = arg_238_1.stage_.transform
				var_241_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_238_1.bgs_.B03e = var_241_0
			end

			if 1.46666666666667 < arg_238_1.time_ and arg_238_1.time_ <= 1.46666666666667 + arg_241_0 then
				local var_241_1 = arg_238_1.bgs_.B03e

				arg_238_1.bgs_.B03e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_241_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_2 = var_241_1:GetComponent("SpriteRenderer")

				if var_241_2 and var_241_2.sprite then
					local var_241_3 = 2 * (var_241_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_241_1.transform.localScale = Vector3.New(var_241_3 / var_241_2.sprite.bounds.size.y < var_241_3 * manager.ui.mainCameraCom_.aspect / var_241_2.sprite.bounds.size.x and var_241_3 * manager.ui.mainCameraCom_.aspect / var_241_2.sprite.bounds.size.x or var_241_3 / var_241_2.sprite.bounds.size.y, var_241_3 / var_241_2.sprite.bounds.size.y < var_241_3 * manager.ui.mainCameraCom_.aspect / var_241_2.sprite.bounds.size.x and var_241_3 * manager.ui.mainCameraCom_.aspect / var_241_2.sprite.bounds.size.x or var_241_3 / var_241_2.sprite.bounds.size.y, 0)
				end

				for iter_241_0, iter_241_1 in pairs(arg_238_1.bgs_) do
					if iter_241_0 ~= "B03e" then
						iter_241_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_4 = 0

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1.allBtn_.enabled = false
			end

			if arg_238_1.time_ >= var_241_4 + 0.3 and arg_238_1.time_ < var_241_4 + 0.3 + arg_241_0 then
				arg_238_1.allBtn_.enabled = true
			end

			local var_241_5 = 0

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_6 = 1.46666666666667

			if var_241_5 <= arg_238_1.time_ and arg_238_1.time_ < var_241_5 + var_241_6 then
				local var_241_7 = Color.New(0, 0, 0)

				var_241_7.a = Mathf.Lerp(0, 1, (arg_238_1.time_ - var_241_5) / var_241_6)
				arg_238_1.mask_.color = var_241_7
			end

			if arg_238_1.time_ >= var_241_5 + var_241_6 and arg_238_1.time_ < var_241_5 + var_241_6 + arg_241_0 then
				local var_241_8 = Color.New(0, 0, 0)

				var_241_8.a = 1
				arg_238_1.mask_.color = var_241_8
			end

			local var_241_9 = 1.46666666666667

			if 1.46666666666667 < arg_238_1.time_ and arg_238_1.time_ <= var_241_9 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_10 = 1.46666666666667

			if var_241_9 <= arg_238_1.time_ and arg_238_1.time_ < var_241_9 + var_241_10 then
				local var_241_11 = Color.New(0, 0, 0)

				var_241_11.a = Mathf.Lerp(1, 0, (arg_238_1.time_ - var_241_9) / var_241_10)
				arg_238_1.mask_.color = var_241_11
			end

			if arg_238_1.time_ >= var_241_9 + var_241_10 and arg_238_1.time_ < var_241_9 + var_241_10 + arg_241_0 then
				local var_241_12 = Color.New(0, 0, 0)

				arg_238_1.mask_.enabled = false
				var_241_12.a = 0
				arg_238_1.mask_.color = var_241_12
			end

			local var_241_13 = arg_238_1.actors_["1036ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_13) and arg_238_1.var_.characterEffect1036ui_story == nil then
				arg_238_1.var_.characterEffect1036ui_story = var_241_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_14 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_14 and not isNil(var_241_13) then
				if arg_238_1.var_.characterEffect1036ui_story and not isNil(var_241_13) then
					arg_238_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_14)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_14 and arg_238_1.time_ < 0 + var_241_14 + arg_241_0 and not isNil(var_241_13) and arg_238_1.var_.characterEffect1036ui_story then
				arg_238_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_15 = 2.6
			local var_241_16 = 1.6

			if 2.6 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_17 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_17:setOnUpdate(LuaHelper.FloatAction(function(arg_242_0)
					arg_238_1.dialogCg_.alpha = arg_242_0
				end))
				var_241_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_18 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(304122058).content)

				arg_238_1.text_.text = var_241_18

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_20 = 64 <= 0 and var_241_16 or var_241_16 * (utf8.len(var_241_18) / 64)

				if (64 <= 0 and var_241_16 or var_241_16 * (utf8.len(var_241_18) / 64)) > 0 and var_241_16 < var_241_20 then
					arg_238_1.talkMaxDuration = var_241_20
					var_241_15 = var_241_15 + 0.3

					if var_241_20 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_20 + var_241_15
					end
				end

				arg_238_1.text_.text = var_241_18
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_21 = var_241_15 + 0.3
			local var_241_22 = math.max(var_241_16, arg_238_1.talkMaxDuration)

			if var_241_15 + 0.3 <= arg_238_1.time_ and arg_238_1.time_ < var_241_21 + var_241_22 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_21) / var_241_22

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_21 + var_241_22 and arg_238_1.time_ < var_241_21 + var_241_22 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play304122059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 304122059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play304122060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 1.225

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_1 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(304122059).content)

				arg_244_1.text_.text = var_247_1

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_3 = 49 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 49)

				if (49 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 49)) > 0 and var_247_0 < var_247_3 then
					arg_244_1.talkMaxDuration = var_247_3

					if var_247_3 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_3 + 0
					end
				end

				arg_244_1.text_.text = var_247_1
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_4 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_4

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play304122060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 304122060
		arg_248_1.duration_ = 7.8

		local var_248_0 = {
			zh = 6.266,
			ja = 7.8
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play304122061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1036ui_story = arg_248_1.actors_["1036ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["1036ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1036ui_story"].transform.position).z)
				arg_248_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1036ui_story"].transform.localEulerAngles = arg_248_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["1036ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.78)
				arg_248_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1036ui_story"].transform.position).z)
				arg_248_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1036ui_story"].transform.localEulerAngles = arg_248_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["1036ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1036ui_story == nil then
				arg_248_1.var_.characterEffect1036ui_story = var_251_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_2 and not isNil(var_251_1) then
				if arg_248_1.var_.characterEffect1036ui_story and not isNil(var_251_1) then
					arg_248_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_2 and arg_248_1.time_ < 0 + var_251_2 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1036ui_story then
				arg_248_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_251_4 = 0
			local var_251_5 = 0.65

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_6 = arg_248_1:GetWordFromCfg(304122060)
				local var_251_7 = arg_248_1:FormatText(var_251_6.content)

				arg_248_1.text_.text = var_251_7

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_9 = 26 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 26)

				if (26 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 26)) > 0 and var_251_5 < var_251_9 then
					arg_248_1.talkMaxDuration = var_251_9

					if var_251_9 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_9 + var_251_4
					end
				end

				arg_248_1.text_.text = var_251_7
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122060", "story_v_out_304122.awb") ~= 0 then
					local var_251_10 = manager.audio:GetVoiceLength("story_v_out_304122", "304122060", "story_v_out_304122.awb") / 1000

					if var_251_10 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_10 + var_251_4
					end

					if var_251_6.prefab_name ~= "" and arg_248_1.actors_[var_251_6.prefab_name] ~= nil then
						local var_251_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_6.prefab_name].transform, "story_v_out_304122", "304122060", "story_v_out_304122.awb")

						arg_248_1:RecordAudio("304122060", var_251_11)
						arg_248_1:RecordAudio("304122060", var_251_11)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_304122", "304122060", "story_v_out_304122.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_304122", "304122060", "story_v_out_304122.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_12 = math.max(var_251_5, arg_248_1.talkMaxDuration)

			if var_251_4 <= arg_248_1.time_ and arg_248_1.time_ < var_251_4 + var_251_12 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_4) / var_251_12

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_4 + var_251_12 and arg_248_1.time_ < var_251_4 + var_251_12 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play304122061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 304122061
		arg_252_1.duration_ = 7.53

		local var_252_0 = {
			zh = 6.433,
			ja = 7.533
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play304122062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.85

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_1 = arg_252_1:GetWordFromCfg(304122061)
				local var_255_2 = arg_252_1:FormatText(var_255_1.content)

				arg_252_1.text_.text = var_255_2

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 34 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 34)

				if (34 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 34)) > 0 and var_255_0 < var_255_4 then
					arg_252_1.talkMaxDuration = var_255_4

					if var_255_4 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_4 + 0
					end
				end

				arg_252_1.text_.text = var_255_2
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122061", "story_v_out_304122.awb") ~= 0 then
					local var_255_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122061", "story_v_out_304122.awb") / 1000

					if var_255_5 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + 0
					end

					if var_255_1.prefab_name ~= "" and arg_252_1.actors_[var_255_1.prefab_name] ~= nil then
						local var_255_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_1.prefab_name].transform, "story_v_out_304122", "304122061", "story_v_out_304122.awb")

						arg_252_1:RecordAudio("304122061", var_255_6)
						arg_252_1:RecordAudio("304122061", var_255_6)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_304122", "304122061", "story_v_out_304122.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_304122", "304122061", "story_v_out_304122.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_7 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_7

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play304122062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 304122062
		arg_256_1.duration_ = 4.87

		local var_256_0 = {
			zh = 4.866,
			ja = 1.999999999999
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play304122063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_2")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_259_0 = 0
			local var_259_1 = 0.05

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_2 = arg_256_1:GetWordFromCfg(304122062)
				local var_259_3 = arg_256_1:FormatText(var_259_2.content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 2 <= 0 and var_259_1 or var_259_1 * (utf8.len(var_259_3) / 2)

				if (2 <= 0 and var_259_1 or var_259_1 * (utf8.len(var_259_3) / 2)) > 0 and var_259_1 < var_259_5 then
					arg_256_1.talkMaxDuration = var_259_5

					if var_259_5 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122062", "story_v_out_304122.awb") ~= 0 then
					local var_259_6 = manager.audio:GetVoiceLength("story_v_out_304122", "304122062", "story_v_out_304122.awb") / 1000

					if var_259_6 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_6 + var_259_0
					end

					if var_259_2.prefab_name ~= "" and arg_256_1.actors_[var_259_2.prefab_name] ~= nil then
						local var_259_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_2.prefab_name].transform, "story_v_out_304122", "304122062", "story_v_out_304122.awb")

						arg_256_1:RecordAudio("304122062", var_259_7)
						arg_256_1:RecordAudio("304122062", var_259_7)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_304122", "304122062", "story_v_out_304122.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_304122", "304122062", "story_v_out_304122.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_8 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_8 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_8

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_8 and arg_256_1.time_ < var_259_0 + var_259_8 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play304122063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 304122063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play304122064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1036ui_story = arg_260_1.actors_["1036ui_story"].transform.localPosition
			end

			local var_263_0 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 then
				arg_260_1.actors_["1036ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_260_1.time_ - 0) / var_263_0)
				arg_260_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1036ui_story"].transform.position).z)
				arg_260_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1036ui_story"].transform.localEulerAngles = arg_260_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 then
				arg_260_1.actors_["1036ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1036ui_story"].transform.position).z)
				arg_260_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1036ui_story"].transform.localEulerAngles = arg_260_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			local var_263_1 = arg_260_1.actors_["1036ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect1036ui_story == nil then
				arg_260_1.var_.characterEffect1036ui_story = var_263_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_2 and not isNil(var_263_1) then
				if arg_260_1.var_.characterEffect1036ui_story and not isNil(var_263_1) then
					arg_260_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_2)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_2 and arg_260_1.time_ < 0 + var_263_2 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect1036ui_story then
				arg_260_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_263_3 = 0
			local var_263_4 = 1.1

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_3 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_5 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(304122063).content)

				arg_260_1.text_.text = var_263_5

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_7 = 44 <= 0 and var_263_4 or var_263_4 * (utf8.len(var_263_5) / 44)

				if (44 <= 0 and var_263_4 or var_263_4 * (utf8.len(var_263_5) / 44)) > 0 and var_263_4 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_3 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_3
					end
				end

				arg_260_1.text_.text = var_263_5
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_8 = math.max(var_263_4, arg_260_1.talkMaxDuration)

			if var_263_3 <= arg_260_1.time_ and arg_260_1.time_ < var_263_3 + var_263_8 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_3) / var_263_8

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_3 + var_263_8 and arg_260_1.time_ < var_263_3 + var_263_8 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play304122064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 304122064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play304122065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 1

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_1 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(304122064).content)

				arg_264_1.text_.text = var_267_1

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_3 = 40 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 40)

				if (40 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 40)) > 0 and var_267_0 < var_267_3 then
					arg_264_1.talkMaxDuration = var_267_3

					if var_267_3 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_3 + 0
					end
				end

				arg_264_1.text_.text = var_267_1
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_4 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_4

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play304122065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 304122065
		arg_268_1.duration_ = 7

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play304122066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_9000

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_0 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 then
				local var_271_1 = Color.New(1, 1, 1)

				var_271_1.a = Mathf.Lerp(1, 0, (arg_268_1.time_ - 0) / var_271_0)
				arg_268_1.mask_.color = var_271_1
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 then
				local var_271_2 = Color.New(1, 1, 1)

				arg_268_1.mask_.enabled = false
				var_271_2.a = 0
				arg_268_1.mask_.color = var_271_2
			end

			local var_271_3 = 0.2

			if 0.2 < arg_268_1.time_ and arg_268_1.time_ <= var_271_3 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_4 = 0.333333333333333

			if var_271_3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_3 + var_271_4 then
				local var_271_5 = Color.New(1, 1, 1)

				var_271_5.a = Mathf.Lerp(1, 0, (arg_268_1.time_ - var_271_3) / var_271_4)
				arg_268_1.mask_.color = var_271_5
			end

			if arg_268_1.time_ >= var_271_3 + var_271_4 and arg_268_1.time_ < var_271_3 + var_271_4 + arg_271_0 then
				local var_271_6 = Color.New(1, 1, 1)

				arg_268_1.mask_.enabled = false
				var_271_6.a = 0
				arg_268_1.mask_.color = var_271_6
			end

			if 0.2 < arg_268_1.time_ and arg_268_1.time_ <= 0.2 + arg_271_0 then
				local var_271_7 = arg_268_1.var_.effect企鹅翁

				if not arg_268_1.var_.effect企鹅翁 then
					var_271_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heidong_out"), manager.ui.mainCamera.transform)
					var_271_7.name = "企鹅翁"
					arg_268_1.var_.effect企鹅翁 = var_271_7
				else
					var_271_7.transform:SetParent(var_271_9000)
				end

				var_271_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_271_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_271_7.transform.localScale = Vector3.New(var_271_7.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_271_7.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_271_7.transform.localScale.z)
			end

			if 2.8 < arg_268_1.time_ and arg_268_1.time_ <= 2.8 + arg_271_0 then
				if arg_268_1.var_.effect企鹅翁 then
					Object.Destroy(arg_268_1.var_.effect企鹅翁)

					arg_268_1.var_.effect企鹅翁 = nil
				end
			end

			local var_271_10 = 0

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_10 + arg_271_0 then
				arg_268_1.allBtn_.enabled = false
			end

			if arg_268_1.time_ >= var_271_10 + 2.4 and arg_268_1.time_ < var_271_10 + 2.4 + arg_271_0 then
				arg_268_1.allBtn_.enabled = true
			end

			if arg_268_1.frameCnt_ <= 1 then
				arg_268_1.dialog_:SetActive(false)
			end

			local var_271_11 = 2
			local var_271_12 = 0.95

			if 2 < arg_268_1.time_ and arg_268_1.time_ <= var_271_11 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0

				arg_268_1.dialog_:SetActive(true)

				arg_268_1.dialogCg_.alpha = 0

				local var_271_13 = LeanTween.value(arg_268_1.dialog_, 0, 1, 0.3)

				var_271_13:setOnUpdate(LuaHelper.FloatAction(function(arg_272_0)
					arg_268_1.dialogCg_.alpha = arg_272_0
				end))
				var_271_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_268_1.dialog_)
					var_271_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_268_1.duration_ = arg_268_1.duration_ + 0.3

				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_14 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(304122065).content)

				arg_268_1.text_.text = var_271_14

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_16 = 38 <= 0 and var_271_12 or var_271_12 * (utf8.len(var_271_14) / 38)

				if (38 <= 0 and var_271_12 or var_271_12 * (utf8.len(var_271_14) / 38)) > 0 and var_271_12 < var_271_16 then
					arg_268_1.talkMaxDuration = var_271_16
					var_271_11 = var_271_11 + 0.3

					if var_271_16 + var_271_11 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_16 + var_271_11
					end
				end

				arg_268_1.text_.text = var_271_14
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_17 = var_271_11 + 0.3
			local var_271_18 = math.max(var_271_12, arg_268_1.talkMaxDuration)

			if var_271_11 + 0.3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_17 + var_271_18 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_17) / var_271_18

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_17 + var_271_18 and arg_268_1.time_ < var_271_17 + var_271_18 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play304122066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 304122066
		arg_274_1.duration_ = 6.07

		local var_274_0 = {
			zh = 6.066,
			ja = 5.8
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play304122067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_9000

			if arg_274_1.bgs_.MS0501 == nil then
				local var_277_0 = Object.Instantiate(arg_274_1.paintGo_)

				var_277_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS0501")
				var_277_0.name = "MS0501"
				var_277_0.transform.parent = arg_274_1.stage_.transform
				var_277_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.bgs_.MS0501 = var_277_0
			end

			if 0.433333333333333 < arg_274_1.time_ and arg_274_1.time_ <= 0.433333333333333 + arg_277_0 then
				local var_277_1 = arg_274_1.bgs_.MS0501

				arg_274_1.bgs_.MS0501.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_277_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_277_2 = var_277_1:GetComponent("SpriteRenderer")

				if var_277_2 and var_277_2.sprite then
					local var_277_3 = 2 * (var_277_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_277_1.transform.localScale = Vector3.New(var_277_3 / var_277_2.sprite.bounds.size.y < var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x and var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x or var_277_3 / var_277_2.sprite.bounds.size.y, var_277_3 / var_277_2.sprite.bounds.size.y < var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x and var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x or var_277_3 / var_277_2.sprite.bounds.size.y, 0)
				end

				for iter_277_0, iter_277_1 in pairs(arg_274_1.bgs_) do
					if iter_277_0 ~= "MS0501" then
						iter_277_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_277_4 = 0.433333333333333

			if 0.433333333333333 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.allBtn_.enabled = false
			end

			if arg_274_1.time_ >= var_277_4 + 0.3 and arg_274_1.time_ < var_277_4 + 0.3 + arg_277_0 then
				arg_274_1.allBtn_.enabled = true
			end

			local var_277_5 = 0

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_5 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_6 = 0.433333333333333

			if var_277_5 <= arg_274_1.time_ and arg_274_1.time_ < var_277_5 + var_277_6 then
				local var_277_7 = Color.New(1, 1, 1)

				var_277_7.a = Mathf.Lerp(0, 1, (arg_274_1.time_ - var_277_5) / var_277_6)
				arg_274_1.mask_.color = var_277_7
			end

			if arg_274_1.time_ >= var_277_5 + var_277_6 and arg_274_1.time_ < var_277_5 + var_277_6 + arg_277_0 then
				local var_277_8 = Color.New(1, 1, 1)

				var_277_8.a = 1
				arg_274_1.mask_.color = var_277_8
			end

			local var_277_9 = 0.433333333333333

			if 0.433333333333333 < arg_274_1.time_ and arg_274_1.time_ <= var_277_9 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_10 = 1.33333333333333

			if var_277_9 <= arg_274_1.time_ and arg_274_1.time_ < var_277_9 + var_277_10 then
				local var_277_11 = Color.New(1, 1, 1)

				var_277_11.a = Mathf.Lerp(1, 0, (arg_274_1.time_ - var_277_9) / var_277_10)
				arg_274_1.mask_.color = var_277_11
			end

			if arg_274_1.time_ >= var_277_9 + var_277_10 and arg_274_1.time_ < var_277_9 + var_277_10 + arg_277_0 then
				local var_277_12 = Color.New(1, 1, 1)

				arg_274_1.mask_.enabled = false
				var_277_12.a = 0
				arg_274_1.mask_.color = var_277_12
			end

			local var_277_13 = arg_274_1.actors_["1036ui_story"]

			if 0.433333333333333 < arg_274_1.time_ and arg_274_1.time_ <= 0.433333333333333 + arg_277_0 and not isNil(var_277_13) and arg_274_1.var_.characterEffect1036ui_story == nil then
				arg_274_1.var_.characterEffect1036ui_story = var_277_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_14 = 0.200000002980232

			if 0.433333333333333 <= arg_274_1.time_ and arg_274_1.time_ < 0.433333333333333 + var_277_14 and not isNil(var_277_13) then
				if arg_274_1.var_.characterEffect1036ui_story and not isNil(var_277_13) then
					arg_274_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0.433333333333333 + var_277_14 and arg_274_1.time_ < 0.433333333333333 + var_277_14 + arg_277_0 and not isNil(var_277_13) and arg_274_1.var_.characterEffect1036ui_story then
				arg_274_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0.433333333333333 < arg_274_1.time_ and arg_274_1.time_ <= 0.433333333333333 + arg_277_0 then
				local var_277_16 = arg_274_1.var_.effect发发箍

				if not arg_274_1.var_.effect发发箍 then
					var_277_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), manager.ui.mainCamera.transform)
					var_277_16.name = "发发箍"
					arg_274_1.var_.effect发发箍 = var_277_16
				else
					var_277_16.transform:SetParent(var_277_9000)
				end

				var_277_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_277_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_277_16.transform.localScale = Vector3.New(var_277_16.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_277_16.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_277_16.transform.localScale.z)
			end

			local var_277_18 = 1.26666666666667

			if 1.26666666666667 < arg_274_1.time_ and arg_274_1.time_ <= var_277_18 + arg_277_0 then
				arg_274_1.allBtn_.enabled = false
			end

			if arg_274_1.time_ >= var_277_18 + 2.16666666666667 and arg_274_1.time_ < var_277_18 + 2.16666666666667 + arg_277_0 then
				arg_274_1.allBtn_.enabled = true
			end

			if arg_274_1.frameCnt_ <= 1 then
				arg_274_1.dialog_:SetActive(false)
			end

			local var_277_19 = 3.2
			local var_277_20 = 0.25

			if 3.2 < arg_274_1.time_ and arg_274_1.time_ <= var_277_19 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0

				arg_274_1.dialog_:SetActive(true)

				arg_274_1.dialogCg_.alpha = 0

				local var_277_21 = LeanTween.value(arg_274_1.dialog_, 0, 1, 0.3)

				var_277_21:setOnUpdate(LuaHelper.FloatAction(function(arg_278_0)
					arg_274_1.dialogCg_.alpha = arg_278_0
				end))
				var_277_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_274_1.dialog_)
					var_277_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_274_1.duration_ = arg_274_1.duration_ + 0.3

				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_22 = arg_274_1:GetWordFromCfg(304122066)
				local var_277_23 = arg_274_1:FormatText(var_277_22.content)

				arg_274_1.text_.text = var_277_23

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_25 = 10 <= 0 and var_277_20 or var_277_20 * (utf8.len(var_277_23) / 10)

				if (10 <= 0 and var_277_20 or var_277_20 * (utf8.len(var_277_23) / 10)) > 0 and var_277_20 < var_277_25 then
					arg_274_1.talkMaxDuration = var_277_25
					var_277_19 = var_277_19 + 0.3

					if var_277_25 + var_277_19 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_25 + var_277_19
					end
				end

				arg_274_1.text_.text = var_277_23
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122066", "story_v_out_304122.awb") ~= 0 then
					local var_277_26 = manager.audio:GetVoiceLength("story_v_out_304122", "304122066", "story_v_out_304122.awb") / 1000

					if var_277_26 + var_277_19 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_26 + var_277_19
					end

					if var_277_22.prefab_name ~= "" and arg_274_1.actors_[var_277_22.prefab_name] ~= nil then
						local var_277_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_22.prefab_name].transform, "story_v_out_304122", "304122066", "story_v_out_304122.awb")

						arg_274_1:RecordAudio("304122066", var_277_27)
						arg_274_1:RecordAudio("304122066", var_277_27)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_304122", "304122066", "story_v_out_304122.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_304122", "304122066", "story_v_out_304122.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_28 = var_277_19 + 0.3
			local var_277_29 = math.max(var_277_20, arg_274_1.talkMaxDuration)

			if var_277_19 + 0.3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_28 + var_277_29 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_28) / var_277_29

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_28 + var_277_29 and arg_274_1.time_ < var_277_28 + var_277_29 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play304122067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 304122067
		arg_280_1.duration_ = 8.53

		local var_280_0 = {
			zh = 7.3,
			ja = 8.533
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play304122068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1036ui_story"]) and arg_280_1.var_.characterEffect1036ui_story == nil then
				arg_280_1.var_.characterEffect1036ui_story = arg_280_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1036ui_story"]) then
				if arg_280_1.var_.characterEffect1036ui_story and not isNil(arg_280_1.actors_["1036ui_story"]) then
					arg_280_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_0)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1036ui_story"]) and arg_280_1.var_.characterEffect1036ui_story then
				arg_280_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_283_1 = 0
			local var_283_2 = 0.525

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_3 = arg_280_1:GetWordFromCfg(304122067)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_6 = 21 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 21)

				if (21 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 21)) > 0 and var_283_2 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122067", "story_v_out_304122.awb") ~= 0 then
					local var_283_7 = manager.audio:GetVoiceLength("story_v_out_304122", "304122067", "story_v_out_304122.awb") / 1000

					if var_283_7 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_1
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_304122", "304122067", "story_v_out_304122.awb")

						arg_280_1:RecordAudio("304122067", var_283_8)
						arg_280_1:RecordAudio("304122067", var_283_8)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_304122", "304122067", "story_v_out_304122.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_304122", "304122067", "story_v_out_304122.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_9 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_9 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_9

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_9 and arg_280_1.time_ < var_283_1 + var_283_9 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play304122068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 304122068
		arg_284_1.duration_ = 3.77

		local var_284_0 = {
			zh = 3.766,
			ja = 3.366
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play304122069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.3

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_1 = arg_284_1:GetWordFromCfg(304122068)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 12 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 12)

				if (12 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 12)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122068", "story_v_out_304122.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122068", "story_v_out_304122.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_304122", "304122068", "story_v_out_304122.awb")

						arg_284_1:RecordAudio("304122068", var_287_6)
						arg_284_1:RecordAudio("304122068", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_304122", "304122068", "story_v_out_304122.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_304122", "304122068", "story_v_out_304122.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play304122069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 304122069
		arg_288_1.duration_ = 12.7

		local var_288_0 = {
			zh = 12.7,
			ja = 10.533
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play304122070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 1.075

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_1 = arg_288_1:GetWordFromCfg(304122069)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 43 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 43)

				if (43 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 43)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122069", "story_v_out_304122.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122069", "story_v_out_304122.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_out_304122", "304122069", "story_v_out_304122.awb")

						arg_288_1:RecordAudio("304122069", var_291_6)
						arg_288_1:RecordAudio("304122069", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_304122", "304122069", "story_v_out_304122.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_304122", "304122069", "story_v_out_304122.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play304122070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 304122070
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play304122071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.8

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(304122070).content)

				arg_292_1.text_.text = var_295_1

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_3 = 32 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 32)

				if (32 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 32)) > 0 and var_295_0 < var_295_3 then
					arg_292_1.talkMaxDuration = var_295_3

					if var_295_3 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_3 + 0
					end
				end

				arg_292_1.text_.text = var_295_1
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_4 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_4

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play304122071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 304122071
		arg_296_1.duration_ = 7.7

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play304122072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_9000

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				local var_299_0 = arg_296_1.var_.effect柔柔弱弱

				if not arg_296_1.var_.effect柔柔弱弱 then
					var_299_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_299_0.name = "柔柔弱弱"
					arg_296_1.var_.effect柔柔弱弱 = var_299_0
				else
					var_299_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_299_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_299_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_299_0.transform.localScale = Vector3.New(var_299_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_299_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_299_0.transform.localScale.z)
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				local var_299_2 = arg_296_1.var_.effect烦烦烦

				if not arg_296_1.var_.effect烦烦烦 then
					var_299_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), manager.ui.mainCamera.transform)
					var_299_2.name = "烦烦烦"
					arg_296_1.var_.effect烦烦烦 = var_299_2
				else
					var_299_2.transform:SetParent(var_299_9000)
				end

				var_299_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_299_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_299_2.transform.localScale = Vector3.New(var_299_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_299_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_299_2.transform.localScale.z)
			end

			local var_299_4

			if 0.6 < arg_296_1.time_ and arg_296_1.time_ <= 0.6 + arg_299_0 then
				local var_299_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_299_5 then
					var_299_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_299_5.radialBlurScale = 0
					var_299_5.radialBlurGradient = 1
					var_299_5.radialBlurIntensity = 1

					if var_299_4 then
						var_299_5.radialBlurTarget = var_299_4.transform
					end
				end
			end

			local var_299_6 = 1.675

			if 0.6 <= arg_296_1.time_ and arg_296_1.time_ < 0.6 + var_299_6 then
				local var_299_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_299_7 then
					var_299_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_299_7.radialBlurScale = Mathf.Lerp(0, 0.986, (arg_296_1.time_ - 0.6) / var_299_6)
					var_299_7.radialBlurGradient = Mathf.Lerp(1, 1, (arg_296_1.time_ - 0.6) / var_299_6)
					var_299_7.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_296_1.time_ - 0.6) / var_299_6)
				end
			end

			if arg_296_1.time_ >= 0.6 + var_299_6 and arg_296_1.time_ < 0.6 + var_299_6 + arg_299_0 then
				local var_299_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_299_8 then
					var_299_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_299_8.radialBlurScale = 0.986
					var_299_8.radialBlurGradient = 1
					var_299_8.radialBlurIntensity = 1
				end
			end

			local var_299_9 = 0

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			if arg_296_1.time_ >= var_299_9 + 3.26666666666667 and arg_296_1.time_ < var_299_9 + 3.26666666666667 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end

			if arg_296_1.frameCnt_ <= 1 then
				arg_296_1.dialog_:SetActive(false)
			end

			local var_299_10 = 2.7
			local var_299_11 = 1.275

			if 2.7 < arg_296_1.time_ and arg_296_1.time_ <= var_299_10 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0

				arg_296_1.dialog_:SetActive(true)

				arg_296_1.dialogCg_.alpha = 0

				local var_299_12 = LeanTween.value(arg_296_1.dialog_, 0, 1, 0.3)

				var_299_12:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_296_1.dialogCg_.alpha = arg_300_0
				end))
				var_299_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_296_1.dialog_)
					var_299_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_296_1.duration_ = arg_296_1.duration_ + 0.3

				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_13 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(304122071).content)

				arg_296_1.text_.text = var_299_13

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_15 = 51 <= 0 and var_299_11 or var_299_11 * (utf8.len(var_299_13) / 51)

				if (51 <= 0 and var_299_11 or var_299_11 * (utf8.len(var_299_13) / 51)) > 0 and var_299_11 < var_299_15 then
					arg_296_1.talkMaxDuration = var_299_15
					var_299_10 = var_299_10 + 0.3

					if var_299_15 + var_299_10 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_15 + var_299_10
					end
				end

				arg_296_1.text_.text = var_299_13
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_16 = var_299_10 + 0.3
			local var_299_17 = math.max(var_299_11, arg_296_1.talkMaxDuration)

			if var_299_10 + 0.3 <= arg_296_1.time_ and arg_296_1.time_ < var_299_16 + var_299_17 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_16) / var_299_17

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_16 + var_299_17 and arg_296_1.time_ < var_299_16 + var_299_17 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play304122072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 304122072
		arg_302_1.duration_ = 3.43

		local var_302_0 = {
			zh = 2.5,
			ja = 3.433
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play304122073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["1036ui_story"]) and arg_302_1.var_.characterEffect1036ui_story == nil then
				arg_302_1.var_.characterEffect1036ui_story = arg_302_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_0 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["1036ui_story"]) then
				if arg_302_1.var_.characterEffect1036ui_story and not isNil(arg_302_1.actors_["1036ui_story"]) then
					arg_302_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["1036ui_story"]) and arg_302_1.var_.characterEffect1036ui_story then
				arg_302_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_305_2 = 0
			local var_305_3 = 0.175

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_4 = arg_302_1:GetWordFromCfg(304122072)
				local var_305_5 = arg_302_1:FormatText(var_305_4.content)

				arg_302_1.text_.text = var_305_5

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_7 = 7 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_5) / 7)

				if (7 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_5) / 7)) > 0 and var_305_3 < var_305_7 then
					arg_302_1.talkMaxDuration = var_305_7

					if var_305_7 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_5
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122072", "story_v_out_304122.awb") ~= 0 then
					local var_305_8 = manager.audio:GetVoiceLength("story_v_out_304122", "304122072", "story_v_out_304122.awb") / 1000

					if var_305_8 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_8 + var_305_2
					end

					if var_305_4.prefab_name ~= "" and arg_302_1.actors_[var_305_4.prefab_name] ~= nil then
						local var_305_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_4.prefab_name].transform, "story_v_out_304122", "304122072", "story_v_out_304122.awb")

						arg_302_1:RecordAudio("304122072", var_305_9)
						arg_302_1:RecordAudio("304122072", var_305_9)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_304122", "304122072", "story_v_out_304122.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_304122", "304122072", "story_v_out_304122.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_10 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_10 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_10

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_10 and arg_302_1.time_ < var_305_2 + var_305_10 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play304122073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 304122073
		arg_306_1.duration_ = 9.93

		local var_306_0 = {
			zh = 9.933,
			ja = 9.766
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play304122074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1036ui_story"]) and arg_306_1.var_.characterEffect1036ui_story == nil then
				arg_306_1.var_.characterEffect1036ui_story = arg_306_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1036ui_story"]) then
				if arg_306_1.var_.characterEffect1036ui_story and not isNil(arg_306_1.actors_["1036ui_story"]) then
					arg_306_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1036ui_story"]) and arg_306_1.var_.characterEffect1036ui_story then
				arg_306_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_down", "")
			end

			local var_309_2 = 0
			local var_309_3 = 0.625

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_2 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_4 = arg_306_1:GetWordFromCfg(304122073)
				local var_309_5 = arg_306_1:FormatText(var_309_4.content)

				arg_306_1.text_.text = var_309_5

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_7 = 25 <= 0 and var_309_3 or var_309_3 * (utf8.len(var_309_5) / 25)

				if (25 <= 0 and var_309_3 or var_309_3 * (utf8.len(var_309_5) / 25)) > 0 and var_309_3 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_2 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_2
					end
				end

				arg_306_1.text_.text = var_309_5
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122073", "story_v_out_304122.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_out_304122", "304122073", "story_v_out_304122.awb") / 1000

					if var_309_8 + var_309_2 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_2
					end

					if var_309_4.prefab_name ~= "" and arg_306_1.actors_[var_309_4.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_4.prefab_name].transform, "story_v_out_304122", "304122073", "story_v_out_304122.awb")

						arg_306_1:RecordAudio("304122073", var_309_9)
						arg_306_1:RecordAudio("304122073", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_304122", "304122073", "story_v_out_304122.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_304122", "304122073", "story_v_out_304122.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_10 = math.max(var_309_3, arg_306_1.talkMaxDuration)

			if var_309_2 <= arg_306_1.time_ and arg_306_1.time_ < var_309_2 + var_309_10 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_2) / var_309_10

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_2 + var_309_10 and arg_306_1.time_ < var_309_2 + var_309_10 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play304122074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 304122074
		arg_310_1.duration_ = 11

		local var_310_0 = {
			zh = 9.1,
			ja = 11
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play304122075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0.725

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_1 = arg_310_1:GetWordFromCfg(304122074)
				local var_313_2 = arg_310_1:FormatText(var_313_1.content)

				arg_310_1.text_.text = var_313_2

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_4 = 29 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_2) / 29)

				if (29 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_2) / 29)) > 0 and var_313_0 < var_313_4 then
					arg_310_1.talkMaxDuration = var_313_4

					if var_313_4 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_4 + 0
					end
				end

				arg_310_1.text_.text = var_313_2
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122074", "story_v_out_304122.awb") ~= 0 then
					local var_313_5 = manager.audio:GetVoiceLength("story_v_out_304122", "304122074", "story_v_out_304122.awb") / 1000

					if var_313_5 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + 0
					end

					if var_313_1.prefab_name ~= "" and arg_310_1.actors_[var_313_1.prefab_name] ~= nil then
						local var_313_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_1.prefab_name].transform, "story_v_out_304122", "304122074", "story_v_out_304122.awb")

						arg_310_1:RecordAudio("304122074", var_313_6)
						arg_310_1:RecordAudio("304122074", var_313_6)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_304122", "304122074", "story_v_out_304122.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_304122", "304122074", "story_v_out_304122.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_7 and arg_310_1.time_ < 0 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play304122075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 304122075
		arg_314_1.duration_ = 9.27

		local var_314_0 = {
			zh = 7.133,
			ja = 9.266
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
			arg_314_1.auto_ = false
		end

		function arg_314_1.playNext_(arg_316_0)
			arg_314_1.onStoryFinished_()
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_9000

			if 1.63333333333333 < arg_314_1.time_ and arg_314_1.time_ <= 1.63333333333333 + arg_317_0 then
				local var_317_0 = arg_314_1.var_.effect企鹅企鹅问问

				if not arg_314_1.var_.effect企鹅企鹅问问 then
					var_317_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapshut"), manager.ui.mainCamera.transform)
					var_317_0.name = "企鹅企鹅问问"
					arg_314_1.var_.effect企鹅企鹅问问 = var_317_0
				else
					var_317_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_317_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_317_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_317_0.transform.localScale = Vector3.New(var_317_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_317_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_317_0.transform.localScale.z)
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				local var_317_2 = arg_314_1.var_.effect333问问

				if not arg_314_1.var_.effect333问问 then
					var_317_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapblink"), manager.ui.mainCamera.transform)
					var_317_2.name = "333问问"
					arg_314_1.var_.effect333问问 = var_317_2
				else
					var_317_2.transform:SetParent(var_317_9000)
				end

				var_317_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_317_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_317_2.transform.localScale = Vector3.New(var_317_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_317_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_317_2.transform.localScale.z)
			end

			local var_317_4 = 0

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1.allBtn_.enabled = false
			end

			if arg_314_1.time_ >= var_317_4 + 3.6 and arg_314_1.time_ < var_317_4 + 3.6 + arg_317_0 then
				arg_314_1.allBtn_.enabled = true
			end

			local var_317_5 = 0
			local var_317_6 = 0.525

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_7 = arg_314_1:GetWordFromCfg(304122075)
				local var_317_8 = arg_314_1:FormatText(var_317_7.content)

				arg_314_1.text_.text = var_317_8

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_10 = 21 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_8) / 21)

				if (21 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_8) / 21)) > 0 and var_317_6 < var_317_10 then
					arg_314_1.talkMaxDuration = var_317_10

					if var_317_10 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_5
					end
				end

				arg_314_1.text_.text = var_317_8
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304122", "304122075", "story_v_out_304122.awb") ~= 0 then
					local var_317_11 = manager.audio:GetVoiceLength("story_v_out_304122", "304122075", "story_v_out_304122.awb") / 1000

					if var_317_11 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_11 + var_317_5
					end

					if var_317_7.prefab_name ~= "" and arg_314_1.actors_[var_317_7.prefab_name] ~= nil then
						local var_317_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_7.prefab_name].transform, "story_v_out_304122", "304122075", "story_v_out_304122.awb")

						arg_314_1:RecordAudio("304122075", var_317_12)
						arg_314_1:RecordAudio("304122075", var_317_12)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_304122", "304122075", "story_v_out_304122.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_304122", "304122075", "story_v_out_304122.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_13 = math.max(var_317_6, arg_314_1.talkMaxDuration)

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_13 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_5) / var_317_13

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_5 + var_317_13 and arg_314_1.time_ < var_317_5 + var_317_13 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B03b",
		"TextureConfig/Background/B06b",
		"TextureConfig/Background/S0401",
		"TextureConfig/Background/B03e",
		"TextureConfig/Background/MS0501"
	},
	voices = {
		"story_v_out_304122.awb"
	}
}
