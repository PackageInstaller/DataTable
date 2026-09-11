return {
	Play1107506001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1107506001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1107506002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST32a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST32a")
				var_4_0.name = "ST32a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST32a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST32a

				arg_1_1.bgs_.ST32a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST32a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1075ui_actor"

			if arg_1_1.actors_["1075ui_actor"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_actor"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1075ui_actor"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1075ui_actor == nil then
				arg_1_1.var_.characterEffect1075ui_actor = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1075ui_actor and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_14 and arg_1_1.time_ < 2 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1075ui_actor then
				arg_1_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			if 1.7 < arg_1_1.time_ and arg_1_1.time_ <= 1.7 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_footstep_quiet", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2
			local var_4_21 = 0.925

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1107506001).content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 37 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_23) / 37)

				if (37 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_23) / 37)) > 0 and var_4_21 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_20 = var_4_20 + 0.3

					if var_4_25 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_26 = var_4_20 + 0.3
			local var_4_27 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_26) / var_4_27

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1107506002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1107506002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1107506003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.125

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1107506002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 45 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 45)

				if (45 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 45)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1107506003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1107506003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1107506004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.225

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(1107506003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 9 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 9)

				if (9 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 9)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1107506004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1107506004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1107506005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.725

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(1107506004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 29 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 29)

				if (29 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 29)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play1107506005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1107506005
		arg_20_1.duration_ = 9

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1107506006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.bgs_.ST37a == nil then
				local var_23_0 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37a")
				var_23_0.name = "ST37a"
				var_23_0.transform.parent = arg_20_1.stage_.transform
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_.ST37a = var_23_0
			end

			if 2 < arg_20_1.time_ and arg_20_1.time_ <= 2 + arg_23_0 then
				local var_23_1 = arg_20_1.bgs_.ST37a

				arg_20_1.bgs_.ST37a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_23_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_2 = var_23_1:GetComponent("SpriteRenderer")

				if var_23_2 and var_23_2.sprite then
					local var_23_3 = 2 * (var_23_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_23_1.transform.localScale = Vector3.New(var_23_3 / var_23_2.sprite.bounds.size.y < var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x and var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x or var_23_3 / var_23_2.sprite.bounds.size.y, var_23_3 / var_23_2.sprite.bounds.size.y < var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x and var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x or var_23_3 / var_23_2.sprite.bounds.size.y, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "ST37a" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_4 = 3.999999999999

			if 3.999999999999 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_4 + 0.3 and arg_20_1.time_ < var_23_4 + 0.3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_5 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_6 = 2

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 then
				local var_23_7 = Color.New(0, 0, 0)

				var_23_7.a = Mathf.Lerp(0, 1, (arg_20_1.time_ - var_23_5) / var_23_6)
				arg_20_1.mask_.color = var_23_7
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 then
				local var_23_8 = Color.New(0, 0, 0)

				var_23_8.a = 1
				arg_20_1.mask_.color = var_23_8
			end

			local var_23_9 = 2

			if 2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_10 = 2

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_10 then
				local var_23_11 = Color.New(0, 0, 0)

				var_23_11.a = Mathf.Lerp(1, 0, (arg_20_1.time_ - var_23_9) / var_23_10)
				arg_20_1.mask_.color = var_23_11
			end

			if arg_20_1.time_ >= var_23_9 + var_23_10 and arg_20_1.time_ < var_23_9 + var_23_10 + arg_23_0 then
				local var_23_12 = Color.New(0, 0, 0)

				arg_20_1.mask_.enabled = false
				var_23_12.a = 0
				arg_20_1.mask_.color = var_23_12
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_23_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_15 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_15

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_15
						arg_20_1.bgmTxt2_.text = var_23_15
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.23333333333333 < arg_20_1.time_ and arg_20_1.time_ <= 1.23333333333333 + arg_23_0 then
				arg_20_1:AudioAction("play", "music", "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_23_18 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if "" ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_18 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_18

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_18
						arg_20_1.bgmTxt2_.text = var_23_18
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_19 = 4
			local var_23_20 = 0.375

			if 4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_21 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_21:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_20_1.dialogCg_.alpha = arg_26_0
				end))
				var_23_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_22 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(1107506005).content)

				arg_20_1.text_.text = var_23_22

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_24 = 15 <= 0 and var_23_20 or var_23_20 * (utf8.len(var_23_22) / 15)

				if (15 <= 0 and var_23_20 or var_23_20 * (utf8.len(var_23_22) / 15)) > 0 and var_23_20 < var_23_24 then
					arg_20_1.talkMaxDuration = var_23_24
					var_23_19 = var_23_19 + 0.3

					if var_23_24 + var_23_19 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_24 + var_23_19
					end
				end

				arg_20_1.text_.text = var_23_22
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_25 = var_23_19 + 0.3
			local var_23_26 = math.max(var_23_20, arg_20_1.talkMaxDuration)

			if var_23_19 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_25 + var_23_26 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_25) / var_23_26

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_25 + var_23_26 and arg_20_1.time_ < var_23_25 + var_23_26 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1107506006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1107506006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1107506007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 1

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(1107506006).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 40 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 40)

				if (40 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 40)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1107506007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1107506007
		arg_32_1.duration_ = 6.3

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1107506008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1075ui_actor = arg_32_1.actors_["1075ui_actor"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1075ui_actor"].transform.position).z)
				arg_32_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_32_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_32_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1075ui_actor"].transform.position).z)
				arg_32_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_32_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = arg_32_1.actors_["1075ui_actor"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1075ui_actor == nil then
				arg_32_1.var_.characterEffect1075ui_actor = var_35_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_4 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 and not isNil(var_35_3) then
				if arg_32_1.var_.characterEffect1075ui_actor and not isNil(var_35_3) then
					arg_32_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1075ui_actor then
				arg_32_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_35_6 = 0
			local var_35_7 = 0.425

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_8 = arg_32_1:GetWordFromCfg(1107506007)
				local var_35_9 = arg_32_1:FormatText(var_35_8.content)

				arg_32_1.text_.text = var_35_9

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 17 <= 0 and var_35_7 or var_35_7 * (utf8.len(var_35_9) / 17)

				if (17 <= 0 and var_35_7 or var_35_7 * (utf8.len(var_35_9) / 17)) > 0 and var_35_7 < var_35_11 then
					arg_32_1.talkMaxDuration = var_35_11

					if var_35_11 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_11 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_9
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506007", "story_v_side_new_1107506.awb") ~= 0 then
					local var_35_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506007", "story_v_side_new_1107506.awb") / 1000

					if var_35_12 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_6
					end

					if var_35_8.prefab_name ~= "" and arg_32_1.actors_[var_35_8.prefab_name] ~= nil then
						local var_35_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_8.prefab_name].transform, "story_v_side_new_1107506", "1107506007", "story_v_side_new_1107506.awb")

						arg_32_1:RecordAudio("1107506007", var_35_13)
						arg_32_1:RecordAudio("1107506007", var_35_13)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506007", "story_v_side_new_1107506.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506007", "story_v_side_new_1107506.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_14 and arg_32_1.time_ < var_35_6 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play1107506008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1107506008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1107506009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1075ui_actor"]) and arg_36_1.var_.characterEffect1075ui_actor == nil then
				arg_36_1.var_.characterEffect1075ui_actor = arg_36_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1075ui_actor"]) then
				if arg_36_1.var_.characterEffect1075ui_actor and not isNil(arg_36_1.actors_["1075ui_actor"]) then
					arg_36_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_36_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1075ui_actor"]) and arg_36_1.var_.characterEffect1075ui_actor then
				arg_36_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_36_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 0.425

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(1107506008).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 17 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 17)

				if (17 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 17)) > 0 and var_39_2 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_6 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_6 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_6

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_6 and arg_36_1.time_ < var_39_1 + var_39_6 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play1107506009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1107506009
		arg_40_1.duration_ = 3.7

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1107506010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1075ui_actor"]) and arg_40_1.var_.characterEffect1075ui_actor == nil then
				arg_40_1.var_.characterEffect1075ui_actor = arg_40_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1075ui_actor"]) then
				if arg_40_1.var_.characterEffect1075ui_actor and not isNil(arg_40_1.actors_["1075ui_actor"]) then
					arg_40_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1075ui_actor"]) and arg_40_1.var_.characterEffect1075ui_actor then
				arg_40_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_43_2 = 0
			local var_43_3 = 0.325

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_4 = arg_40_1:GetWordFromCfg(1107506009)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 13 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 13)

				if (13 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 13)) > 0 and var_43_3 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506009", "story_v_side_new_1107506.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506009", "story_v_side_new_1107506.awb") / 1000

					if var_43_8 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_2
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_side_new_1107506", "1107506009", "story_v_side_new_1107506.awb")

						arg_40_1:RecordAudio("1107506009", var_43_9)
						arg_40_1:RecordAudio("1107506009", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506009", "story_v_side_new_1107506.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506009", "story_v_side_new_1107506.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_10 and arg_40_1.time_ < var_43_2 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1107506010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1107506010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1107506011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1075ui_actor"]) and arg_44_1.var_.characterEffect1075ui_actor == nil then
				arg_44_1.var_.characterEffect1075ui_actor = arg_44_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1075ui_actor"]) then
				if arg_44_1.var_.characterEffect1075ui_actor and not isNil(arg_44_1.actors_["1075ui_actor"]) then
					arg_44_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_44_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1075ui_actor"]) and arg_44_1.var_.characterEffect1075ui_actor then
				arg_44_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_44_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 0.675

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(1107506010).content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 27 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 27)

				if (27 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 27)) > 0 and var_47_2 < var_47_5 then
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
	Play1107506011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1107506011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1107506012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.35

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(1107506011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 14 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 14)

				if (14 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 14)) > 0 and var_51_0 < var_51_3 then
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
	Play1107506012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1107506012
		arg_52_1.duration_ = 5.3

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1107506013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1075ui_actor"]) and arg_52_1.var_.characterEffect1075ui_actor == nil then
				arg_52_1.var_.characterEffect1075ui_actor = arg_52_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1075ui_actor"]) then
				if arg_52_1.var_.characterEffect1075ui_actor and not isNil(arg_52_1.actors_["1075ui_actor"]) then
					arg_52_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1075ui_actor"]) and arg_52_1.var_.characterEffect1075ui_actor then
				arg_52_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_55_2 = 0
			local var_55_3 = 0.625

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_4 = arg_52_1:GetWordFromCfg(1107506012)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 25 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 25)

				if (25 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 25)) > 0 and var_55_3 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506012", "story_v_side_new_1107506.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506012", "story_v_side_new_1107506.awb") / 1000

					if var_55_8 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_2
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_side_new_1107506", "1107506012", "story_v_side_new_1107506.awb")

						arg_52_1:RecordAudio("1107506012", var_55_9)
						arg_52_1:RecordAudio("1107506012", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506012", "story_v_side_new_1107506.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506012", "story_v_side_new_1107506.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_10 and arg_52_1.time_ < var_55_2 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1107506013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1107506013
		arg_56_1.duration_ = 3.77

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1107506014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_59_0 = 0
			local var_59_1 = 0.325

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(1107506013)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 13 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 13)

				if (13 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 13)) > 0 and var_59_1 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506013", "story_v_side_new_1107506.awb") ~= 0 then
					local var_59_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506013", "story_v_side_new_1107506.awb") / 1000

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end

					if var_59_2.prefab_name ~= "" and arg_56_1.actors_[var_59_2.prefab_name] ~= nil then
						local var_59_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_2.prefab_name].transform, "story_v_side_new_1107506", "1107506013", "story_v_side_new_1107506.awb")

						arg_56_1:RecordAudio("1107506013", var_59_7)
						arg_56_1:RecordAudio("1107506013", var_59_7)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506013", "story_v_side_new_1107506.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506013", "story_v_side_new_1107506.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1107506014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1107506014
		arg_60_1.duration_ = 6.49

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1107506015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if arg_60_1.bgs_.ST47 == nil then
				local var_63_0 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST47")
				var_63_0.name = "ST47"
				var_63_0.transform.parent = arg_60_1.stage_.transform
				var_63_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_.ST47 = var_63_0
			end

			if 2.46666666666667 < arg_60_1.time_ and arg_60_1.time_ <= 2.46666666666667 + arg_63_0 then
				local var_63_1 = arg_60_1.bgs_.ST47

				arg_60_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_63_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_2 = var_63_1:GetComponent("SpriteRenderer")

				if var_63_2 and var_63_2.sprite then
					local var_63_3 = 2 * (var_63_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_63_1.transform.localScale = Vector3.New(var_63_3 / var_63_2.sprite.bounds.size.y < var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x and var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x or var_63_3 / var_63_2.sprite.bounds.size.y, var_63_3 / var_63_2.sprite.bounds.size.y < var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x and var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x or var_63_3 / var_63_2.sprite.bounds.size.y, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "ST47" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_4 = 5.066666

			if 5.066666 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			if arg_60_1.time_ >= var_63_4 + 0.3 and arg_60_1.time_ < var_63_4 + 0.3 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_5 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_6 = 2.5

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 then
				local var_63_7 = Color.New(0, 0, 0)

				var_63_7.a = Mathf.Lerp(0, 1, (arg_60_1.time_ - var_63_5) / var_63_6)
				arg_60_1.mask_.color = var_63_7
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 then
				local var_63_8 = Color.New(0, 0, 0)

				var_63_8.a = 1
				arg_60_1.mask_.color = var_63_8
			end

			local var_63_9 = 2.5

			if 2.5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_10 = 2.566666

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 then
				local var_63_11 = Color.New(0, 0, 0)

				var_63_11.a = Mathf.Lerp(1, 0, (arg_60_1.time_ - var_63_9) / var_63_10)
				arg_60_1.mask_.color = var_63_11
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 then
				local var_63_12 = Color.New(0, 0, 0)

				arg_60_1.mask_.enabled = false
				var_63_12.a = 0
				arg_60_1.mask_.color = var_63_12
			end

			local var_63_13 = arg_60_1.actors_["1075ui_actor"].transform

			if 1.96599999815226 < arg_60_1.time_ and arg_60_1.time_ <= 1.96599999815226 + arg_63_0 then
				arg_60_1.var_.moveOldPos1075ui_actor = var_63_13.localPosition

				local var_63_14 = GameObjectTools.GetOrAddComponent(var_63_13.gameObject, typeof(DynamicBoneHelper))

				if var_63_14 then
					var_63_14:EnableDynamicBone(false)
				end
			end

			local var_63_15 = 0.001

			if 1.96599999815226 <= arg_60_1.time_ and arg_60_1.time_ < 1.96599999815226 + var_63_15 then
				var_63_13.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_60_1.time_ - 1.96599999815226) / var_63_15)
				var_63_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_13.position).x, (manager.ui.mainCamera.transform.position - var_63_13.position).y, (manager.ui.mainCamera.transform.position - var_63_13.position).z)
				var_63_13.localEulerAngles.z = 0
				var_63_13.localEulerAngles.x = 0
				var_63_13.localEulerAngles = var_63_13.localEulerAngles
			end

			if arg_60_1.time_ >= 1.96599999815226 + var_63_15 and arg_60_1.time_ < 1.96599999815226 + var_63_15 + arg_63_0 then
				var_63_13.localPosition = Vector3.New(0, 100, 0)
				var_63_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_13.position).x, (manager.ui.mainCamera.transform.position - var_63_13.position).y, (manager.ui.mainCamera.transform.position - var_63_13.position).z)
				var_63_13.localEulerAngles.z = 0
				var_63_13.localEulerAngles.x = 0
				var_63_13.localEulerAngles = var_63_13.localEulerAngles

				local var_63_16 = GameObjectTools.GetOrAddComponent(var_63_13.gameObject, typeof(DynamicBoneHelper))

				if var_63_16 then
					var_63_16:EnableDynamicBone(true)
				end
			end

			local var_63_17 = "10044ui_story"

			if arg_60_1.actors_["10044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10044ui_story"))) then
				local var_63_18 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_60_1.stage_.transform)

				var_63_18.name = var_63_17
				var_63_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_[var_63_17] = var_63_18

				local var_63_19 = var_63_18:GetComponentInChildren(typeof(CharacterEffect))

				var_63_19.enabled = true

				local var_63_20 = GameObjectTools.GetOrAddComponent(var_63_18, typeof(DynamicBoneHelper))

				if var_63_20 then
					var_63_20:EnableDynamicBone(false)
				end

				arg_60_1:ShowWeapon(var_63_19.transform, false)

				arg_60_1.var_[var_63_17 .. "Animator"] = var_63_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_60_1.var_[var_63_17 .. "Animator"].applyRootMotion = true
				arg_60_1.var_[var_63_17 .. "LipSync"] = var_63_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_63_21 = arg_60_1.actors_["10044ui_story"].transform

			if 3.8 < arg_60_1.time_ and arg_60_1.time_ <= 3.8 + arg_63_0 then
				arg_60_1.var_.moveOldPos10044ui_story = var_63_21.localPosition
			end

			local var_63_22 = 0.001

			if 3.8 <= arg_60_1.time_ and arg_60_1.time_ < 3.8 + var_63_22 then
				var_63_21.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10044ui_story, Vector3.New(0, -0.72, -6.3), (arg_60_1.time_ - 3.8) / var_63_22)
				var_63_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_21.position).x, (manager.ui.mainCamera.transform.position - var_63_21.position).y, (manager.ui.mainCamera.transform.position - var_63_21.position).z)
				var_63_21.localEulerAngles.z = 0
				var_63_21.localEulerAngles.x = 0
				var_63_21.localEulerAngles = var_63_21.localEulerAngles
			end

			if arg_60_1.time_ >= 3.8 + var_63_22 and arg_60_1.time_ < 3.8 + var_63_22 + arg_63_0 then
				var_63_21.localPosition = Vector3.New(0, -0.72, -6.3)
				var_63_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_21.position).x, (manager.ui.mainCamera.transform.position - var_63_21.position).y, (manager.ui.mainCamera.transform.position - var_63_21.position).z)
				var_63_21.localEulerAngles.z = 0
				var_63_21.localEulerAngles.x = 0
				var_63_21.localEulerAngles = var_63_21.localEulerAngles
			end

			local var_63_23 = arg_60_1.actors_["10044ui_story"]

			if 3.8 < arg_60_1.time_ and arg_60_1.time_ <= 3.8 + arg_63_0 and not isNil(var_63_23) and arg_60_1.var_.characterEffect10044ui_story == nil then
				arg_60_1.var_.characterEffect10044ui_story = var_63_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_24 = 0.200000002980232

			if 3.8 <= arg_60_1.time_ and arg_60_1.time_ < 3.8 + var_63_24 and not isNil(var_63_23) then
				if arg_60_1.var_.characterEffect10044ui_story and not isNil(var_63_23) then
					arg_60_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 3.8 + var_63_24 and arg_60_1.time_ < 3.8 + var_63_24 + arg_63_0 and not isNil(var_63_23) and arg_60_1.var_.characterEffect10044ui_story then
				arg_60_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_63_26 = arg_60_1.actors_["1075ui_actor"]

			if 1.98333333333333 < arg_60_1.time_ and arg_60_1.time_ <= 1.98333333333333 + arg_63_0 and not isNil(var_63_26) and arg_60_1.var_.characterEffect1075ui_actor == nil then
				arg_60_1.var_.characterEffect1075ui_actor = var_63_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_27 = 0.0166666666666666

			if 1.98333333333333 <= arg_60_1.time_ and arg_60_1.time_ < 1.98333333333333 + var_63_27 and not isNil(var_63_26) then
				if arg_60_1.var_.characterEffect1075ui_actor and not isNil(var_63_26) then
					arg_60_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_60_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 1.98333333333333) / var_63_27)
				end
			end

			if arg_60_1.time_ >= 1.98333333333333 + var_63_27 and arg_60_1.time_ < 1.98333333333333 + var_63_27 + arg_63_0 and not isNil(var_63_26) and arg_60_1.var_.characterEffect1075ui_actor then
				arg_60_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_60_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			if 3.8 < arg_60_1.time_ and arg_60_1.time_ <= 3.8 + arg_63_0 then
				arg_60_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 3.8 < arg_60_1.time_ and arg_60_1.time_ <= 3.8 + arg_63_0 then
				arg_60_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_63_28 = 2.5

			arg_60_1.isInRecall_ = false

			if var_63_28 < arg_60_1.time_ and arg_60_1.time_ <= var_63_28 + arg_63_0 then
				arg_60_1.screenFilterGo_:SetActive(true)

				arg_60_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_63_2, iter_63_3 in pairs(arg_60_1.actors_) do
					for iter_63_4, iter_63_5 in ipairs((iter_63_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_63_5.color = iter_63_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_63_29 = 0.0333333333333332

			if var_63_28 <= arg_60_1.time_ and arg_60_1.time_ < var_63_28 + var_63_29 then
				arg_60_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_60_1.time_ - var_63_28) / var_63_29)
			end

			if arg_60_1.time_ >= var_63_28 + var_63_29 and arg_60_1.time_ < var_63_28 + var_63_29 + arg_63_0 then
				arg_60_1.screenFilterEffect_.weight = 1
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_30 = 4.891666
			local var_63_31 = 0.175

			if 4.891666 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_32 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_32:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_33 = arg_60_1:GetWordFromCfg(1107506014)
				local var_63_34 = arg_60_1:FormatText(var_63_33.content)

				arg_60_1.text_.text = var_63_34

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_36 = 7 <= 0 and var_63_31 or var_63_31 * (utf8.len(var_63_34) / 7)

				if (7 <= 0 and var_63_31 or var_63_31 * (utf8.len(var_63_34) / 7)) > 0 and var_63_31 < var_63_36 then
					arg_60_1.talkMaxDuration = var_63_36
					var_63_30 = var_63_30 + 0.3

					if var_63_36 + var_63_30 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_36 + var_63_30
					end
				end

				arg_60_1.text_.text = var_63_34
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506014", "story_v_side_new_1107506.awb") ~= 0 then
					local var_63_37 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506014", "story_v_side_new_1107506.awb") / 1000

					if var_63_37 + var_63_30 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_37 + var_63_30
					end

					if var_63_33.prefab_name ~= "" and arg_60_1.actors_[var_63_33.prefab_name] ~= nil then
						local var_63_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_33.prefab_name].transform, "story_v_side_new_1107506", "1107506014", "story_v_side_new_1107506.awb")

						arg_60_1:RecordAudio("1107506014", var_63_38)
						arg_60_1:RecordAudio("1107506014", var_63_38)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506014", "story_v_side_new_1107506.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506014", "story_v_side_new_1107506.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_39 = var_63_30 + 0.3
			local var_63_40 = math.max(var_63_31, arg_60_1.talkMaxDuration)

			if var_63_30 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_39 + var_63_40 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_39) / var_63_40

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_39 + var_63_40 and arg_60_1.time_ < var_63_39 + var_63_40 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play1107506015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 1107506015
		arg_66_1.duration_ = 3.7

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play1107506016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos10044ui_story = arg_66_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_69_0 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 then
				arg_66_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10044ui_story, Vector3.New(-0.7, -0.72, -6.3), (arg_66_1.time_ - 0) / var_69_0)
				arg_66_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10044ui_story"].transform.position).z)
				arg_66_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["10044ui_story"].transform.localEulerAngles = arg_66_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 then
				arg_66_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(-0.7, -0.72, -6.3)
				arg_66_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10044ui_story"].transform.position).z)
				arg_66_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["10044ui_story"].transform.localEulerAngles = arg_66_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_69_1 = arg_66_1.actors_["1075ui_actor"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1075ui_actor = var_69_1.localPosition

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_1.gameObject, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end
			end

			local var_69_3 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 then
				var_69_1.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1075ui_actor, Vector3.New(0.7, -1.055, -6.16), (arg_66_1.time_ - 0) / var_69_3)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 then
				var_69_1.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles

				local var_69_4 = GameObjectTools.GetOrAddComponent(var_69_1.gameObject, typeof(DynamicBoneHelper))

				if var_69_4 then
					var_69_4:EnableDynamicBone(true)
				end
			end

			local var_69_5 = arg_66_1.actors_["1075ui_actor"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1075ui_actor == nil then
				arg_66_1.var_.characterEffect1075ui_actor = var_69_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_6 and not isNil(var_69_5) then
				if arg_66_1.var_.characterEffect1075ui_actor and not isNil(var_69_5) then
					arg_66_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_6 and arg_66_1.time_ < 0 + var_69_6 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1075ui_actor then
				arg_66_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_69_8 = arg_66_1.actors_["10044ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.characterEffect10044ui_story == nil then
				arg_66_1.var_.characterEffect10044ui_story = var_69_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_9 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_9 and not isNil(var_69_8) then
				if arg_66_1.var_.characterEffect10044ui_story and not isNil(var_69_8) then
					arg_66_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_66_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_9)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_9 and arg_66_1.time_ < 0 + var_69_9 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.characterEffect10044ui_story then
				arg_66_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_66_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_69_10 = 0
			local var_69_11 = 0.375

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_12 = arg_66_1:GetWordFromCfg(1107506015)
				local var_69_13 = arg_66_1:FormatText(var_69_12.content)

				arg_66_1.text_.text = var_69_13

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_15 = 15 <= 0 and var_69_11 or var_69_11 * (utf8.len(var_69_13) / 15)

				if (15 <= 0 and var_69_11 or var_69_11 * (utf8.len(var_69_13) / 15)) > 0 and var_69_11 < var_69_15 then
					arg_66_1.talkMaxDuration = var_69_15

					if var_69_15 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_15 + var_69_10
					end
				end

				arg_66_1.text_.text = var_69_13
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506015", "story_v_side_new_1107506.awb") ~= 0 then
					local var_69_16 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506015", "story_v_side_new_1107506.awb") / 1000

					if var_69_16 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_16 + var_69_10
					end

					if var_69_12.prefab_name ~= "" and arg_66_1.actors_[var_69_12.prefab_name] ~= nil then
						local var_69_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_12.prefab_name].transform, "story_v_side_new_1107506", "1107506015", "story_v_side_new_1107506.awb")

						arg_66_1:RecordAudio("1107506015", var_69_17)
						arg_66_1:RecordAudio("1107506015", var_69_17)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506015", "story_v_side_new_1107506.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506015", "story_v_side_new_1107506.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_18 = math.max(var_69_11, arg_66_1.talkMaxDuration)

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_18 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_10) / var_69_18

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_10 + var_69_18 and arg_66_1.time_ < var_69_10 + var_69_18 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play1107506016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 1107506016
		arg_70_1.duration_ = 5.77

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play1107506017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["10044ui_story"]) and arg_70_1.var_.characterEffect10044ui_story == nil then
				arg_70_1.var_.characterEffect10044ui_story = arg_70_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["10044ui_story"]) then
				if arg_70_1.var_.characterEffect10044ui_story and not isNil(arg_70_1.actors_["10044ui_story"]) then
					arg_70_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10044ui_story"]) and arg_70_1.var_.characterEffect10044ui_story then
				arg_70_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_73_2 = arg_70_1.actors_["1075ui_actor"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1075ui_actor == nil then
				arg_70_1.var_.characterEffect1075ui_actor = var_73_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_3 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.characterEffect1075ui_actor and not isNil(var_73_2) then
					arg_70_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_70_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_3)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1075ui_actor then
				arg_70_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_70_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action435")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_73_4 = 0
			local var_73_5 = 0.675

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_6 = arg_70_1:GetWordFromCfg(1107506016)
				local var_73_7 = arg_70_1:FormatText(var_73_6.content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 27 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 27)

				if (27 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 27)) > 0 and var_73_5 < var_73_9 then
					arg_70_1.talkMaxDuration = var_73_9

					if var_73_9 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_9 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506016", "story_v_side_new_1107506.awb") ~= 0 then
					local var_73_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506016", "story_v_side_new_1107506.awb") / 1000

					if var_73_10 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_4
					end

					if var_73_6.prefab_name ~= "" and arg_70_1.actors_[var_73_6.prefab_name] ~= nil then
						local var_73_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_6.prefab_name].transform, "story_v_side_new_1107506", "1107506016", "story_v_side_new_1107506.awb")

						arg_70_1:RecordAudio("1107506016", var_73_11)
						arg_70_1:RecordAudio("1107506016", var_73_11)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506016", "story_v_side_new_1107506.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506016", "story_v_side_new_1107506.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_12 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_12 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_12

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_12 and arg_70_1.time_ < var_73_4 + var_73_12 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play1107506017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 1107506017
		arg_74_1.duration_ = 8.1

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play1107506018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1075ui_actor"]) and arg_74_1.var_.characterEffect1075ui_actor == nil then
				arg_74_1.var_.characterEffect1075ui_actor = arg_74_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1075ui_actor"]) then
				if arg_74_1.var_.characterEffect1075ui_actor and not isNil(arg_74_1.actors_["1075ui_actor"]) then
					arg_74_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1075ui_actor"]) and arg_74_1.var_.characterEffect1075ui_actor then
				arg_74_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_77_2 = arg_74_1.actors_["10044ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect10044ui_story == nil then
				arg_74_1.var_.characterEffect10044ui_story = var_77_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_3 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 and not isNil(var_77_2) then
				if arg_74_1.var_.characterEffect10044ui_story and not isNil(var_77_2) then
					arg_74_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_74_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_3)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect10044ui_story then
				arg_74_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_74_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_77_4 = 0
			local var_77_5 = 0.825

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_6 = arg_74_1:GetWordFromCfg(1107506017)
				local var_77_7 = arg_74_1:FormatText(var_77_6.content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 33 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 33)

				if (33 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 33)) > 0 and var_77_5 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506017", "story_v_side_new_1107506.awb") ~= 0 then
					local var_77_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506017", "story_v_side_new_1107506.awb") / 1000

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end

					if var_77_6.prefab_name ~= "" and arg_74_1.actors_[var_77_6.prefab_name] ~= nil then
						local var_77_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_6.prefab_name].transform, "story_v_side_new_1107506", "1107506017", "story_v_side_new_1107506.awb")

						arg_74_1:RecordAudio("1107506017", var_77_11)
						arg_74_1:RecordAudio("1107506017", var_77_11)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506017", "story_v_side_new_1107506.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506017", "story_v_side_new_1107506.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_12 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_12 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_12

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_12 and arg_74_1.time_ < var_77_4 + var_77_12 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play1107506018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 1107506018
		arg_78_1.duration_ = 6.57

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play1107506019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["10044ui_story"]) and arg_78_1.var_.characterEffect10044ui_story == nil then
				arg_78_1.var_.characterEffect10044ui_story = arg_78_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["10044ui_story"]) then
				if arg_78_1.var_.characterEffect10044ui_story and not isNil(arg_78_1.actors_["10044ui_story"]) then
					arg_78_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["10044ui_story"]) and arg_78_1.var_.characterEffect10044ui_story then
				arg_78_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_81_2 = arg_78_1.actors_["1075ui_actor"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect1075ui_actor == nil then
				arg_78_1.var_.characterEffect1075ui_actor = var_81_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_3 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 and not isNil(var_81_2) then
				if arg_78_1.var_.characterEffect1075ui_actor and not isNil(var_81_2) then
					arg_78_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_78_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_3)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect1075ui_actor then
				arg_78_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_78_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_2")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_81_4 = 0
			local var_81_5 = 0.725

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_6 = arg_78_1:GetWordFromCfg(1107506018)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 29 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 29)

				if (29 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 29)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506018", "story_v_side_new_1107506.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506018", "story_v_side_new_1107506.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_side_new_1107506", "1107506018", "story_v_side_new_1107506.awb")

						arg_78_1:RecordAudio("1107506018", var_81_11)
						arg_78_1:RecordAudio("1107506018", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506018", "story_v_side_new_1107506.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506018", "story_v_side_new_1107506.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play1107506019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 1107506019
		arg_82_1.duration_ = 6.57

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play1107506020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_85_0 = 0
			local var_85_1 = 0.9

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_2 = arg_82_1:GetWordFromCfg(1107506019)
				local var_85_3 = arg_82_1:FormatText(var_85_2.content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 36 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 36)

				if (36 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 36)) > 0 and var_85_1 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506019", "story_v_side_new_1107506.awb") ~= 0 then
					local var_85_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506019", "story_v_side_new_1107506.awb") / 1000

					if var_85_6 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_0
					end

					if var_85_2.prefab_name ~= "" and arg_82_1.actors_[var_85_2.prefab_name] ~= nil then
						local var_85_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_2.prefab_name].transform, "story_v_side_new_1107506", "1107506019", "story_v_side_new_1107506.awb")

						arg_82_1:RecordAudio("1107506019", var_85_7)
						arg_82_1:RecordAudio("1107506019", var_85_7)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506019", "story_v_side_new_1107506.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506019", "story_v_side_new_1107506.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play1107506020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1107506020
		arg_86_1.duration_ = 3.37

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play1107506021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1075ui_actor"]) and arg_86_1.var_.characterEffect1075ui_actor == nil then
				arg_86_1.var_.characterEffect1075ui_actor = arg_86_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1075ui_actor"]) then
				if arg_86_1.var_.characterEffect1075ui_actor and not isNil(arg_86_1.actors_["1075ui_actor"]) then
					arg_86_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1075ui_actor"]) and arg_86_1.var_.characterEffect1075ui_actor then
				arg_86_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_89_2 = arg_86_1.actors_["10044ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect10044ui_story == nil then
				arg_86_1.var_.characterEffect10044ui_story = var_89_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_3 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 and not isNil(var_89_2) then
				if arg_86_1.var_.characterEffect10044ui_story and not isNil(var_89_2) then
					arg_86_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_3)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect10044ui_story then
				arg_86_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action454")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_89_4 = 0
			local var_89_5 = 0.3

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(1107506020)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 12 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 12)

				if (12 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 12)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506020", "story_v_side_new_1107506.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506020", "story_v_side_new_1107506.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_side_new_1107506", "1107506020", "story_v_side_new_1107506.awb")

						arg_86_1:RecordAudio("1107506020", var_89_11)
						arg_86_1:RecordAudio("1107506020", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506020", "story_v_side_new_1107506.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506020", "story_v_side_new_1107506.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_12 and arg_86_1.time_ < var_89_4 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play1107506021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1107506021
		arg_90_1.duration_ = 3.43

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play1107506022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["10044ui_story"]) and arg_90_1.var_.characterEffect10044ui_story == nil then
				arg_90_1.var_.characterEffect10044ui_story = arg_90_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["10044ui_story"]) then
				if arg_90_1.var_.characterEffect10044ui_story and not isNil(arg_90_1.actors_["10044ui_story"]) then
					arg_90_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10044ui_story"]) and arg_90_1.var_.characterEffect10044ui_story then
				arg_90_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_93_2 = arg_90_1.actors_["1075ui_actor"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1075ui_actor == nil then
				arg_90_1.var_.characterEffect1075ui_actor = var_93_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_3 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.characterEffect1075ui_actor and not isNil(var_93_2) then
					arg_90_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_90_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_3)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1075ui_actor then
				arg_90_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_90_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_93_4 = 0
			local var_93_5 = 0.375

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(1107506021)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 15 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 15)

				if (15 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 15)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506021", "story_v_side_new_1107506.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506021", "story_v_side_new_1107506.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_side_new_1107506", "1107506021", "story_v_side_new_1107506.awb")

						arg_90_1:RecordAudio("1107506021", var_93_11)
						arg_90_1:RecordAudio("1107506021", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506021", "story_v_side_new_1107506.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506021", "story_v_side_new_1107506.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play1107506022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1107506022
		arg_94_1.duration_ = 4.4

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1107506023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1075ui_actor"]) and arg_94_1.var_.characterEffect1075ui_actor == nil then
				arg_94_1.var_.characterEffect1075ui_actor = arg_94_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1075ui_actor"]) then
				if arg_94_1.var_.characterEffect1075ui_actor and not isNil(arg_94_1.actors_["1075ui_actor"]) then
					arg_94_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1075ui_actor"]) and arg_94_1.var_.characterEffect1075ui_actor then
				arg_94_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["10044ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect10044ui_story == nil then
				arg_94_1.var_.characterEffect10044ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect10044ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_94_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect10044ui_story then
				arg_94_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_94_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_97_4 = 0
			local var_97_5 = 0.3

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_6 = arg_94_1:GetWordFromCfg(1107506022)
				local var_97_7 = arg_94_1:FormatText(var_97_6.content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 12 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 12)

				if (12 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 12)) > 0 and var_97_5 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506022", "story_v_side_new_1107506.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506022", "story_v_side_new_1107506.awb") / 1000

					if var_97_10 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_4
					end

					if var_97_6.prefab_name ~= "" and arg_94_1.actors_[var_97_6.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_6.prefab_name].transform, "story_v_side_new_1107506", "1107506022", "story_v_side_new_1107506.awb")

						arg_94_1:RecordAudio("1107506022", var_97_11)
						arg_94_1:RecordAudio("1107506022", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506022", "story_v_side_new_1107506.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506022", "story_v_side_new_1107506.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_12 = math.max(var_97_5, arg_94_1.talkMaxDuration)

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_12 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_4) / var_97_12

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_4 + var_97_12 and arg_94_1.time_ < var_97_4 + var_97_12 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play1107506023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1107506023
		arg_98_1.duration_ = 9

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1107506024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 2 < arg_98_1.time_ and arg_98_1.time_ <= 2 + arg_101_0 then
				local var_101_0 = arg_98_1.bgs_.ST37a

				arg_98_1.bgs_.ST37a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_101_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_1 = var_101_0:GetComponent("SpriteRenderer")

				if var_101_1 and var_101_1.sprite then
					local var_101_2 = 2 * (var_101_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_101_0.transform.localScale = Vector3.New(var_101_2 / var_101_1.sprite.bounds.size.y < var_101_2 * manager.ui.mainCameraCom_.aspect / var_101_1.sprite.bounds.size.x and var_101_2 * manager.ui.mainCameraCom_.aspect / var_101_1.sprite.bounds.size.x or var_101_2 / var_101_1.sprite.bounds.size.y, var_101_2 / var_101_1.sprite.bounds.size.y < var_101_2 * manager.ui.mainCameraCom_.aspect / var_101_1.sprite.bounds.size.x and var_101_2 * manager.ui.mainCameraCom_.aspect / var_101_1.sprite.bounds.size.x or var_101_2 / var_101_1.sprite.bounds.size.y, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "ST37a" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_3 = 4

			if 4 < arg_98_1.time_ and arg_98_1.time_ <= var_101_3 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			if arg_98_1.time_ >= var_101_3 + 0.3 and arg_98_1.time_ < var_101_3 + 0.3 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_4 = 0

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_5 = 2

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_5 then
				local var_101_6 = Color.New(0, 0, 0)

				var_101_6.a = Mathf.Lerp(0, 1, (arg_98_1.time_ - var_101_4) / var_101_5)
				arg_98_1.mask_.color = var_101_6
			end

			if arg_98_1.time_ >= var_101_4 + var_101_5 and arg_98_1.time_ < var_101_4 + var_101_5 + arg_101_0 then
				local var_101_7 = Color.New(0, 0, 0)

				var_101_7.a = 1
				arg_98_1.mask_.color = var_101_7
			end

			local var_101_8 = 2

			if 2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_9 = 2

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_9 then
				local var_101_10 = Color.New(0, 0, 0)

				var_101_10.a = Mathf.Lerp(1, 0, (arg_98_1.time_ - var_101_8) / var_101_9)
				arg_98_1.mask_.color = var_101_10
			end

			if arg_98_1.time_ >= var_101_8 + var_101_9 and arg_98_1.time_ < var_101_8 + var_101_9 + arg_101_0 then
				local var_101_11 = Color.New(0, 0, 0)

				arg_98_1.mask_.enabled = false
				var_101_11.a = 0
				arg_98_1.mask_.color = var_101_11
			end

			local var_101_12 = arg_98_1.actors_["1075ui_actor"].transform

			if 1.96599999815226 < arg_98_1.time_ and arg_98_1.time_ <= 1.96599999815226 + arg_101_0 then
				arg_98_1.var_.moveOldPos1075ui_actor = var_101_12.localPosition

				local var_101_13 = GameObjectTools.GetOrAddComponent(var_101_12.gameObject, typeof(DynamicBoneHelper))

				if var_101_13 then
					var_101_13:EnableDynamicBone(false)
				end
			end

			local var_101_14 = 0.001

			if 1.96599999815226 <= arg_98_1.time_ and arg_98_1.time_ < 1.96599999815226 + var_101_14 then
				var_101_12.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_98_1.time_ - 1.96599999815226) / var_101_14)
				var_101_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_12.position).x, (manager.ui.mainCamera.transform.position - var_101_12.position).y, (manager.ui.mainCamera.transform.position - var_101_12.position).z)
				var_101_12.localEulerAngles.z = 0
				var_101_12.localEulerAngles.x = 0
				var_101_12.localEulerAngles = var_101_12.localEulerAngles
			end

			if arg_98_1.time_ >= 1.96599999815226 + var_101_14 and arg_98_1.time_ < 1.96599999815226 + var_101_14 + arg_101_0 then
				var_101_12.localPosition = Vector3.New(0, 100, 0)
				var_101_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_12.position).x, (manager.ui.mainCamera.transform.position - var_101_12.position).y, (manager.ui.mainCamera.transform.position - var_101_12.position).z)
				var_101_12.localEulerAngles.z = 0
				var_101_12.localEulerAngles.x = 0
				var_101_12.localEulerAngles = var_101_12.localEulerAngles

				local var_101_15 = GameObjectTools.GetOrAddComponent(var_101_12.gameObject, typeof(DynamicBoneHelper))

				if var_101_15 then
					var_101_15:EnableDynamicBone(true)
				end
			end

			local var_101_16 = arg_98_1.actors_["10044ui_story"].transform

			if 1.96599999815226 < arg_98_1.time_ and arg_98_1.time_ <= 1.96599999815226 + arg_101_0 then
				arg_98_1.var_.moveOldPos10044ui_story = var_101_16.localPosition
			end

			local var_101_17 = 0.001

			if 1.96599999815226 <= arg_98_1.time_ and arg_98_1.time_ < 1.96599999815226 + var_101_17 then
				var_101_16.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 1.96599999815226) / var_101_17)
				var_101_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_16.position).x, (manager.ui.mainCamera.transform.position - var_101_16.position).y, (manager.ui.mainCamera.transform.position - var_101_16.position).z)
				var_101_16.localEulerAngles.z = 0
				var_101_16.localEulerAngles.x = 0
				var_101_16.localEulerAngles = var_101_16.localEulerAngles
			end

			if arg_98_1.time_ >= 1.96599999815226 + var_101_17 and arg_98_1.time_ < 1.96599999815226 + var_101_17 + arg_101_0 then
				var_101_16.localPosition = Vector3.New(0, 100, 0)
				var_101_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_16.position).x, (manager.ui.mainCamera.transform.position - var_101_16.position).y, (manager.ui.mainCamera.transform.position - var_101_16.position).z)
				var_101_16.localEulerAngles.z = 0
				var_101_16.localEulerAngles.x = 0
				var_101_16.localEulerAngles = var_101_16.localEulerAngles
			end

			local var_101_18 = arg_98_1.actors_["1075ui_actor"]

			if 1.98333333333333 < arg_98_1.time_ and arg_98_1.time_ <= 1.98333333333333 + arg_101_0 and not isNil(var_101_18) and arg_98_1.var_.characterEffect1075ui_actor == nil then
				arg_98_1.var_.characterEffect1075ui_actor = var_101_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_19 = 0.0166666666666667

			if 1.98333333333333 <= arg_98_1.time_ and arg_98_1.time_ < 1.98333333333333 + var_101_19 and not isNil(var_101_18) then
				if arg_98_1.var_.characterEffect1075ui_actor and not isNil(var_101_18) then
					arg_98_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_98_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 1.98333333333333) / var_101_19)
				end
			end

			if arg_98_1.time_ >= 1.98333333333333 + var_101_19 and arg_98_1.time_ < 1.98333333333333 + var_101_19 + arg_101_0 and not isNil(var_101_18) and arg_98_1.var_.characterEffect1075ui_actor then
				arg_98_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_98_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_101_20 = 1.96666666666667

			arg_98_1.isInRecall_ = false

			if var_101_20 < arg_98_1.time_ and arg_98_1.time_ <= var_101_20 + arg_101_0 then
				arg_98_1.screenFilterGo_:SetActive(false)

				for iter_101_2, iter_101_3 in pairs(arg_98_1.actors_) do
					for iter_101_4, iter_101_5 in ipairs((iter_101_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_101_5.color = iter_101_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_101_21 = 0.0333333333333332

			if var_101_20 <= arg_98_1.time_ and arg_98_1.time_ < var_101_20 + var_101_21 then
				arg_98_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_98_1.time_ - var_101_20) / var_101_21)
			end

			if arg_98_1.time_ >= var_101_20 + var_101_21 and arg_98_1.time_ < var_101_20 + var_101_21 + arg_101_0 then
				arg_98_1.screenFilterEffect_.weight = 0
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_22 = 4
			local var_101_23 = 0.375

			if 4 < arg_98_1.time_ and arg_98_1.time_ <= var_101_22 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_24 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_24:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_25 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(1107506023).content)

				arg_98_1.text_.text = var_101_25

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_27 = 15 <= 0 and var_101_23 or var_101_23 * (utf8.len(var_101_25) / 15)

				if (15 <= 0 and var_101_23 or var_101_23 * (utf8.len(var_101_25) / 15)) > 0 and var_101_23 < var_101_27 then
					arg_98_1.talkMaxDuration = var_101_27
					var_101_22 = var_101_22 + 0.3

					if var_101_27 + var_101_22 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_27 + var_101_22
					end
				end

				arg_98_1.text_.text = var_101_25
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_28 = var_101_22 + 0.3
			local var_101_29 = math.max(var_101_23, arg_98_1.talkMaxDuration)

			if var_101_22 + 0.3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_28 + var_101_29 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_28) / var_101_29

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_28 + var_101_29 and arg_98_1.time_ < var_101_28 + var_101_29 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play1107506024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1107506024
		arg_104_1.duration_ = 7.83

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1107506025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1075ui_actor = arg_104_1.actors_["1075ui_actor"].transform.localPosition

				local var_107_0 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_0 then
					var_107_0:EnableDynamicBone(false)
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_104_1.time_ - 0) / var_107_1)
				arg_104_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1075ui_actor"].transform.position).z)
				arg_104_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_104_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_104_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1075ui_actor"].transform.position).z)
				arg_104_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_104_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_107_2 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(true)
				end
			end

			local var_107_3 = arg_104_1.actors_["1075ui_actor"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect1075ui_actor == nil then
				arg_104_1.var_.characterEffect1075ui_actor = var_107_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_4 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 and not isNil(var_107_3) then
				if arg_104_1.var_.characterEffect1075ui_actor and not isNil(var_107_3) then
					arg_104_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect1075ui_actor then
				arg_104_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_107_6 = 0
			local var_107_7 = 0.8

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:GetWordFromCfg(1107506024)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 32 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 32)

				if (32 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 32)) > 0 and var_107_7 < var_107_11 then
					arg_104_1.talkMaxDuration = var_107_11

					if var_107_11 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506024", "story_v_side_new_1107506.awb") ~= 0 then
					local var_107_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506024", "story_v_side_new_1107506.awb") / 1000

					if var_107_12 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_6
					end

					if var_107_8.prefab_name ~= "" and arg_104_1.actors_[var_107_8.prefab_name] ~= nil then
						local var_107_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_8.prefab_name].transform, "story_v_side_new_1107506", "1107506024", "story_v_side_new_1107506.awb")

						arg_104_1:RecordAudio("1107506024", var_107_13)
						arg_104_1:RecordAudio("1107506024", var_107_13)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506024", "story_v_side_new_1107506.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506024", "story_v_side_new_1107506.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play1107506025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1107506025
		arg_108_1.duration_ = 10.8

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1107506026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_111_0 = 0
			local var_111_1 = 1

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(1107506025)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 40 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 40)

				if (40 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 40)) > 0 and var_111_1 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506025", "story_v_side_new_1107506.awb") ~= 0 then
					local var_111_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506025", "story_v_side_new_1107506.awb") / 1000

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end

					if var_111_2.prefab_name ~= "" and arg_108_1.actors_[var_111_2.prefab_name] ~= nil then
						local var_111_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_2.prefab_name].transform, "story_v_side_new_1107506", "1107506025", "story_v_side_new_1107506.awb")

						arg_108_1:RecordAudio("1107506025", var_111_7)
						arg_108_1:RecordAudio("1107506025", var_111_7)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506025", "story_v_side_new_1107506.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506025", "story_v_side_new_1107506.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1107506026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1107506026
		arg_112_1.duration_ = 6.9

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1107506027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_115_0 = 0
			local var_115_1 = 0.825

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_2 = arg_112_1:GetWordFromCfg(1107506026)
				local var_115_3 = arg_112_1:FormatText(var_115_2.content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 33 <= 0 and var_115_1 or var_115_1 * (utf8.len(var_115_3) / 33)

				if (33 <= 0 and var_115_1 or var_115_1 * (utf8.len(var_115_3) / 33)) > 0 and var_115_1 < var_115_5 then
					arg_112_1.talkMaxDuration = var_115_5

					if var_115_5 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506026", "story_v_side_new_1107506.awb") ~= 0 then
					local var_115_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506026", "story_v_side_new_1107506.awb") / 1000

					if var_115_6 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_0
					end

					if var_115_2.prefab_name ~= "" and arg_112_1.actors_[var_115_2.prefab_name] ~= nil then
						local var_115_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_2.prefab_name].transform, "story_v_side_new_1107506", "1107506026", "story_v_side_new_1107506.awb")

						arg_112_1:RecordAudio("1107506026", var_115_7)
						arg_112_1:RecordAudio("1107506026", var_115_7)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506026", "story_v_side_new_1107506.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506026", "story_v_side_new_1107506.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_8 and arg_112_1.time_ < var_115_0 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1107506027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1107506027
		arg_116_1.duration_ = 4.43

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1107506028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_119_0 = 0
			local var_119_1 = 0.525

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_2 = arg_116_1:GetWordFromCfg(1107506027)
				local var_119_3 = arg_116_1:FormatText(var_119_2.content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 21 <= 0 and var_119_1 or var_119_1 * (utf8.len(var_119_3) / 21)

				if (21 <= 0 and var_119_1 or var_119_1 * (utf8.len(var_119_3) / 21)) > 0 and var_119_1 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506027", "story_v_side_new_1107506.awb") ~= 0 then
					local var_119_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506027", "story_v_side_new_1107506.awb") / 1000

					if var_119_6 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_0
					end

					if var_119_2.prefab_name ~= "" and arg_116_1.actors_[var_119_2.prefab_name] ~= nil then
						local var_119_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_2.prefab_name].transform, "story_v_side_new_1107506", "1107506027", "story_v_side_new_1107506.awb")

						arg_116_1:RecordAudio("1107506027", var_119_7)
						arg_116_1:RecordAudio("1107506027", var_119_7)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506027", "story_v_side_new_1107506.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506027", "story_v_side_new_1107506.awb")
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
	Play1107506028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1107506028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1107506029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1075ui_actor"]) and arg_120_1.var_.characterEffect1075ui_actor == nil then
				arg_120_1.var_.characterEffect1075ui_actor = arg_120_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1075ui_actor"]) then
				if arg_120_1.var_.characterEffect1075ui_actor and not isNil(arg_120_1.actors_["1075ui_actor"]) then
					arg_120_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_120_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1075ui_actor"]) and arg_120_1.var_.characterEffect1075ui_actor then
				arg_120_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_120_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_123_1 = 0
			local var_123_2 = 0.225

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(1107506028).content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 9 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 9)

				if (9 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 9)) > 0 and var_123_2 < var_123_5 then
					arg_120_1.talkMaxDuration = var_123_5

					if var_123_5 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + var_123_1
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_6 = math.max(var_123_2, arg_120_1.talkMaxDuration)

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_6 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_1) / var_123_6

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_1 + var_123_6 and arg_120_1.time_ < var_123_1 + var_123_6 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1107506029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1107506029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1107506030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1075ui_actor = arg_124_1.actors_["1075ui_actor"].transform.localPosition

				local var_127_0 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_0 then
					var_127_0:EnableDynamicBone(false)
				end
			end

			local var_127_1 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 then
				arg_124_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_124_1.time_ - 0) / var_127_1)
				arg_124_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1075ui_actor"].transform.position).z)
				arg_124_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_124_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 then
				arg_124_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1075ui_actor"].transform.position).z)
				arg_124_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_124_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_127_2 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(true)
				end
			end

			local var_127_3 = 0
			local var_127_4 = 0.475

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_3 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_5 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(1107506029).content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 19 <= 0 and var_127_4 or var_127_4 * (utf8.len(var_127_5) / 19)

				if (19 <= 0 and var_127_4 or var_127_4 * (utf8.len(var_127_5) / 19)) > 0 and var_127_4 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_3 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_3
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_4, arg_124_1.talkMaxDuration)

			if var_127_3 <= arg_124_1.time_ and arg_124_1.time_ < var_127_3 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_3) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_3 + var_127_8 and arg_124_1.time_ < var_127_3 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play1107506030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1107506030
		arg_128_1.duration_ = 7.43

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1107506031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1075ui_actor = arg_128_1.actors_["1075ui_actor"].transform.localPosition

				local var_131_0 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_0 then
					var_131_0:EnableDynamicBone(false)
				end
			end

			local var_131_1 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 then
				arg_128_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_128_1.time_ - 0) / var_131_1)
				arg_128_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1075ui_actor"].transform.position).z)
				arg_128_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_128_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 then
				arg_128_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_128_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1075ui_actor"].transform.position).z)
				arg_128_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_128_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_131_2 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(true)
				end
			end

			local var_131_3 = arg_128_1.actors_["1075ui_actor"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1075ui_actor == nil then
				arg_128_1.var_.characterEffect1075ui_actor = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect1075ui_actor and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1075ui_actor then
				arg_128_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_131_6 = 0
			local var_131_7 = 0.775

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:GetWordFromCfg(1107506030)
				local var_131_9 = arg_128_1:FormatText(var_131_8.content)

				arg_128_1.text_.text = var_131_9

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 31 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 31)

				if (31 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 31)) > 0 and var_131_7 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_9
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506030", "story_v_side_new_1107506.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506030", "story_v_side_new_1107506.awb") / 1000

					if var_131_12 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_6
					end

					if var_131_8.prefab_name ~= "" and arg_128_1.actors_[var_131_8.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_8.prefab_name].transform, "story_v_side_new_1107506", "1107506030", "story_v_side_new_1107506.awb")

						arg_128_1:RecordAudio("1107506030", var_131_13)
						arg_128_1:RecordAudio("1107506030", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506030", "story_v_side_new_1107506.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506030", "story_v_side_new_1107506.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_14 and arg_128_1.time_ < var_131_6 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play1107506031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1107506031
		arg_132_1.duration_ = 14.13

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1107506032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_135_0 = 0
			local var_135_1 = 1.25

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_2 = arg_132_1:GetWordFromCfg(1107506031)
				local var_135_3 = arg_132_1:FormatText(var_135_2.content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 50 <= 0 and var_135_1 or var_135_1 * (utf8.len(var_135_3) / 50)

				if (50 <= 0 and var_135_1 or var_135_1 * (utf8.len(var_135_3) / 50)) > 0 and var_135_1 < var_135_5 then
					arg_132_1.talkMaxDuration = var_135_5

					if var_135_5 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506031", "story_v_side_new_1107506.awb") ~= 0 then
					local var_135_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506031", "story_v_side_new_1107506.awb") / 1000

					if var_135_6 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_0
					end

					if var_135_2.prefab_name ~= "" and arg_132_1.actors_[var_135_2.prefab_name] ~= nil then
						local var_135_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_2.prefab_name].transform, "story_v_side_new_1107506", "1107506031", "story_v_side_new_1107506.awb")

						arg_132_1:RecordAudio("1107506031", var_135_7)
						arg_132_1:RecordAudio("1107506031", var_135_7)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506031", "story_v_side_new_1107506.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506031", "story_v_side_new_1107506.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_8 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_8 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_8

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_8 and arg_132_1.time_ < var_135_0 + var_135_8 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1107506032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1107506032
		arg_136_1.duration_ = 6.8

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1107506033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.65

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:GetWordFromCfg(1107506032)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 26 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 26)

				if (26 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 26)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506032", "story_v_side_new_1107506.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506032", "story_v_side_new_1107506.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_side_new_1107506", "1107506032", "story_v_side_new_1107506.awb")

						arg_136_1:RecordAudio("1107506032", var_139_6)
						arg_136_1:RecordAudio("1107506032", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506032", "story_v_side_new_1107506.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506032", "story_v_side_new_1107506.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1107506033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1107506033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1107506034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1075ui_actor"]) and arg_140_1.var_.characterEffect1075ui_actor == nil then
				arg_140_1.var_.characterEffect1075ui_actor = arg_140_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1075ui_actor"]) then
				if arg_140_1.var_.characterEffect1075ui_actor and not isNil(arg_140_1.actors_["1075ui_actor"]) then
					arg_140_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_140_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1075ui_actor"]) and arg_140_1.var_.characterEffect1075ui_actor then
				arg_140_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_140_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 0.375

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(1107506033).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 15 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 15)

				if (15 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 15)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1107506034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1107506034
		arg_144_1.duration_ = 8.13

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1107506035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1075ui_actor"]) and arg_144_1.var_.characterEffect1075ui_actor == nil then
				arg_144_1.var_.characterEffect1075ui_actor = arg_144_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1075ui_actor"]) then
				if arg_144_1.var_.characterEffect1075ui_actor and not isNil(arg_144_1.actors_["1075ui_actor"]) then
					arg_144_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1075ui_actor"]) and arg_144_1.var_.characterEffect1075ui_actor then
				arg_144_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_147_2 = 0
			local var_147_3 = 0.7

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(1107506034)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 28 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 28)

				if (28 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 28)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506034", "story_v_side_new_1107506.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506034", "story_v_side_new_1107506.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_side_new_1107506", "1107506034", "story_v_side_new_1107506.awb")

						arg_144_1:RecordAudio("1107506034", var_147_9)
						arg_144_1:RecordAudio("1107506034", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506034", "story_v_side_new_1107506.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506034", "story_v_side_new_1107506.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1107506035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1107506035
		arg_148_1.duration_ = 8.4

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1107506036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.925

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:GetWordFromCfg(1107506035)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 37 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 37)

				if (37 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 37)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506035", "story_v_side_new_1107506.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506035", "story_v_side_new_1107506.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_side_new_1107506", "1107506035", "story_v_side_new_1107506.awb")

						arg_148_1:RecordAudio("1107506035", var_151_6)
						arg_148_1:RecordAudio("1107506035", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506035", "story_v_side_new_1107506.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506035", "story_v_side_new_1107506.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play1107506036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1107506036
		arg_152_1.duration_ = 10.67

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1107506037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action453")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_155_0 = 0
			local var_155_1 = 0.775

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_2 = arg_152_1:GetWordFromCfg(1107506036)
				local var_155_3 = arg_152_1:FormatText(var_155_2.content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 31 <= 0 and var_155_1 or var_155_1 * (utf8.len(var_155_3) / 31)

				if (31 <= 0 and var_155_1 or var_155_1 * (utf8.len(var_155_3) / 31)) > 0 and var_155_1 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506036", "story_v_side_new_1107506.awb") ~= 0 then
					local var_155_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506036", "story_v_side_new_1107506.awb") / 1000

					if var_155_6 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_0
					end

					if var_155_2.prefab_name ~= "" and arg_152_1.actors_[var_155_2.prefab_name] ~= nil then
						local var_155_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_2.prefab_name].transform, "story_v_side_new_1107506", "1107506036", "story_v_side_new_1107506.awb")

						arg_152_1:RecordAudio("1107506036", var_155_7)
						arg_152_1:RecordAudio("1107506036", var_155_7)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506036", "story_v_side_new_1107506.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506036", "story_v_side_new_1107506.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_8 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_8 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_8

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_8 and arg_152_1.time_ < var_155_0 + var_155_8 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1107506037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1107506037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1107506038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1075ui_actor"]) and arg_156_1.var_.characterEffect1075ui_actor == nil then
				arg_156_1.var_.characterEffect1075ui_actor = arg_156_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1075ui_actor"]) then
				if arg_156_1.var_.characterEffect1075ui_actor and not isNil(arg_156_1.actors_["1075ui_actor"]) then
					arg_156_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_156_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1075ui_actor"]) and arg_156_1.var_.characterEffect1075ui_actor then
				arg_156_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_156_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.625

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(1107506037).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 25 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 25)

				if (25 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 25)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play1107506038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1107506038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1107506039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1075ui_actor = arg_160_1.actors_["1075ui_actor"].transform.localPosition

				local var_163_0 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_0 then
					var_163_0:EnableDynamicBone(false)
				end
			end

			local var_163_1 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 then
				arg_160_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_1)
				arg_160_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1075ui_actor"].transform.position).z)
				arg_160_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_160_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 then
				arg_160_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1075ui_actor"].transform.position).z)
				arg_160_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_160_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_163_2 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(true)
				end
			end

			local var_163_3 = 0
			local var_163_4 = 1.05

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_3 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_5 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(1107506038).content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 42 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_5) / 42)

				if (42 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_5) / 42)) > 0 and var_163_4 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_3 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_3
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_8 = math.max(var_163_4, arg_160_1.talkMaxDuration)

			if var_163_3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_3 + var_163_8 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_3) / var_163_8

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_3 + var_163_8 and arg_160_1.time_ < var_163_3 + var_163_8 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play1107506039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1107506039
		arg_164_1.duration_ = 6.9

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1107506040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1075ui_actor = arg_164_1.actors_["1075ui_actor"].transform.localPosition

				local var_167_0 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_0 then
					var_167_0:EnableDynamicBone(false)
				end
			end

			local var_167_1 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_1 then
				arg_164_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_164_1.time_ - 0) / var_167_1)
				arg_164_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1075ui_actor"].transform.position).z)
				arg_164_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_164_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_1 and arg_164_1.time_ < 0 + var_167_1 + arg_167_0 then
				arg_164_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_164_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1075ui_actor"].transform.position).z)
				arg_164_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_164_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_167_2 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_2 then
					var_167_2:EnableDynamicBone(true)
				end
			end

			local var_167_3 = arg_164_1.actors_["1075ui_actor"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1075ui_actor == nil then
				arg_164_1.var_.characterEffect1075ui_actor = var_167_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_4 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 and not isNil(var_167_3) then
				if arg_164_1.var_.characterEffect1075ui_actor and not isNil(var_167_3) then
					arg_164_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1075ui_actor then
				arg_164_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action432")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_167_6 = 0
			local var_167_7 = 0.675

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_8 = arg_164_1:GetWordFromCfg(1107506039)
				local var_167_9 = arg_164_1:FormatText(var_167_8.content)

				arg_164_1.text_.text = var_167_9

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 27 <= 0 and var_167_7 or var_167_7 * (utf8.len(var_167_9) / 27)

				if (27 <= 0 and var_167_7 or var_167_7 * (utf8.len(var_167_9) / 27)) > 0 and var_167_7 < var_167_11 then
					arg_164_1.talkMaxDuration = var_167_11

					if var_167_11 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_9
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506039", "story_v_side_new_1107506.awb") ~= 0 then
					local var_167_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506039", "story_v_side_new_1107506.awb") / 1000

					if var_167_12 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_12 + var_167_6
					end

					if var_167_8.prefab_name ~= "" and arg_164_1.actors_[var_167_8.prefab_name] ~= nil then
						local var_167_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_8.prefab_name].transform, "story_v_side_new_1107506", "1107506039", "story_v_side_new_1107506.awb")

						arg_164_1:RecordAudio("1107506039", var_167_13)
						arg_164_1:RecordAudio("1107506039", var_167_13)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506039", "story_v_side_new_1107506.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506039", "story_v_side_new_1107506.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_14 and arg_164_1.time_ < var_167_6 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play1107506040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1107506040
		arg_168_1.duration_ = 9.33

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1107506041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_171_0 = 0
			local var_171_1 = 0.825

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_2 = arg_168_1:GetWordFromCfg(1107506040)
				local var_171_3 = arg_168_1:FormatText(var_171_2.content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 33 <= 0 and var_171_1 or var_171_1 * (utf8.len(var_171_3) / 33)

				if (33 <= 0 and var_171_1 or var_171_1 * (utf8.len(var_171_3) / 33)) > 0 and var_171_1 < var_171_5 then
					arg_168_1.talkMaxDuration = var_171_5

					if var_171_5 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506040", "story_v_side_new_1107506.awb") ~= 0 then
					local var_171_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506040", "story_v_side_new_1107506.awb") / 1000

					if var_171_6 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_6 + var_171_0
					end

					if var_171_2.prefab_name ~= "" and arg_168_1.actors_[var_171_2.prefab_name] ~= nil then
						local var_171_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_2.prefab_name].transform, "story_v_side_new_1107506", "1107506040", "story_v_side_new_1107506.awb")

						arg_168_1:RecordAudio("1107506040", var_171_7)
						arg_168_1:RecordAudio("1107506040", var_171_7)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506040", "story_v_side_new_1107506.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506040", "story_v_side_new_1107506.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_8 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_8 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_8

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_8 and arg_168_1.time_ < var_171_0 + var_171_8 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1107506041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1107506041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1107506042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1075ui_actor"]) and arg_172_1.var_.characterEffect1075ui_actor == nil then
				arg_172_1.var_.characterEffect1075ui_actor = arg_172_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1075ui_actor"]) then
				if arg_172_1.var_.characterEffect1075ui_actor and not isNil(arg_172_1.actors_["1075ui_actor"]) then
					arg_172_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_172_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1075ui_actor"]) and arg_172_1.var_.characterEffect1075ui_actor then
				arg_172_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_172_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 0.3

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(1107506041).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 12 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 12)

				if (12 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 12)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play1107506042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1107506042
		arg_176_1.duration_ = 5.2

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1107506043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1075ui_actor"]) and arg_176_1.var_.characterEffect1075ui_actor == nil then
				arg_176_1.var_.characterEffect1075ui_actor = arg_176_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1075ui_actor"]) then
				if arg_176_1.var_.characterEffect1075ui_actor and not isNil(arg_176_1.actors_["1075ui_actor"]) then
					arg_176_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1075ui_actor"]) and arg_176_1.var_.characterEffect1075ui_actor then
				arg_176_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_179_2 = 0
			local var_179_3 = 0.425

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:GetWordFromCfg(1107506042)
				local var_179_5 = arg_176_1:FormatText(var_179_4.content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 17 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 17)

				if (17 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 17)) > 0 and var_179_3 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506042", "story_v_side_new_1107506.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506042", "story_v_side_new_1107506.awb") / 1000

					if var_179_8 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_2
					end

					if var_179_4.prefab_name ~= "" and arg_176_1.actors_[var_179_4.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_4.prefab_name].transform, "story_v_side_new_1107506", "1107506042", "story_v_side_new_1107506.awb")

						arg_176_1:RecordAudio("1107506042", var_179_9)
						arg_176_1:RecordAudio("1107506042", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506042", "story_v_side_new_1107506.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506042", "story_v_side_new_1107506.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_10 and arg_176_1.time_ < var_179_2 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1107506043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1107506043
		arg_180_1.duration_ = 4.1

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1107506044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_183_0 = 0
			local var_183_1 = 0.45

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_2 = arg_180_1:GetWordFromCfg(1107506043)
				local var_183_3 = arg_180_1:FormatText(var_183_2.content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 18 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_3) / 18)

				if (18 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_3) / 18)) > 0 and var_183_1 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506043", "story_v_side_new_1107506.awb") ~= 0 then
					local var_183_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506043", "story_v_side_new_1107506.awb") / 1000

					if var_183_6 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_0
					end

					if var_183_2.prefab_name ~= "" and arg_180_1.actors_[var_183_2.prefab_name] ~= nil then
						local var_183_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_2.prefab_name].transform, "story_v_side_new_1107506", "1107506043", "story_v_side_new_1107506.awb")

						arg_180_1:RecordAudio("1107506043", var_183_7)
						arg_180_1:RecordAudio("1107506043", var_183_7)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506043", "story_v_side_new_1107506.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506043", "story_v_side_new_1107506.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_8 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_8 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_8

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_8 and arg_180_1.time_ < var_183_0 + var_183_8 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1107506044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1107506044
		arg_184_1.duration_ = 4.3

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1107506045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if arg_184_1.bgs_.STblack == nil then
				local var_187_0 = Object.Instantiate(arg_184_1.paintGo_)

				var_187_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_187_0.name = "STblack"
				var_187_0.transform.parent = arg_184_1.stage_.transform
				var_187_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_184_1.bgs_.STblack = var_187_0
			end

			if 1.999999999999 < arg_184_1.time_ and arg_184_1.time_ <= 1.999999999999 + arg_187_0 then
				local var_187_1 = arg_184_1.bgs_.STblack

				arg_184_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_187_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_187_2 = var_187_1:GetComponent("SpriteRenderer")

				if var_187_2 and var_187_2.sprite then
					local var_187_3 = 2 * (var_187_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_187_1.transform.localScale = Vector3.New(var_187_3 / var_187_2.sprite.bounds.size.y < var_187_3 * manager.ui.mainCameraCom_.aspect / var_187_2.sprite.bounds.size.x and var_187_3 * manager.ui.mainCameraCom_.aspect / var_187_2.sprite.bounds.size.x or var_187_3 / var_187_2.sprite.bounds.size.y, var_187_3 / var_187_2.sprite.bounds.size.y < var_187_3 * manager.ui.mainCameraCom_.aspect / var_187_2.sprite.bounds.size.x and var_187_3 * manager.ui.mainCameraCom_.aspect / var_187_2.sprite.bounds.size.x or var_187_3 / var_187_2.sprite.bounds.size.y, 0)
				end

				for iter_187_0, iter_187_1 in pairs(arg_184_1.bgs_) do
					if iter_187_0 ~= "STblack" then
						iter_187_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_187_4 = 3.999999999999

			if 3.999999999999 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.allBtn_.enabled = false
			end

			if arg_184_1.time_ >= var_187_4 + 0.3 and arg_184_1.time_ < var_187_4 + 0.3 + arg_187_0 then
				arg_184_1.allBtn_.enabled = true
			end

			local var_187_5 = 0

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.mask_.enabled = true
				arg_184_1.mask_.raycastTarget = true

				arg_184_1:SetGaussion(false)
			end

			local var_187_6 = 2

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_6 then
				local var_187_7 = Color.New(0, 0, 0)

				var_187_7.a = Mathf.Lerp(0, 1, (arg_184_1.time_ - var_187_5) / var_187_6)
				arg_184_1.mask_.color = var_187_7
			end

			if arg_184_1.time_ >= var_187_5 + var_187_6 and arg_184_1.time_ < var_187_5 + var_187_6 + arg_187_0 then
				local var_187_8 = Color.New(0, 0, 0)

				var_187_8.a = 1
				arg_184_1.mask_.color = var_187_8
			end

			local var_187_9 = 2

			if 2 < arg_184_1.time_ and arg_184_1.time_ <= var_187_9 + arg_187_0 then
				arg_184_1.mask_.enabled = true
				arg_184_1.mask_.raycastTarget = true

				arg_184_1:SetGaussion(false)
			end

			local var_187_10 = 2

			if var_187_9 <= arg_184_1.time_ and arg_184_1.time_ < var_187_9 + var_187_10 then
				local var_187_11 = Color.New(0, 0, 0)

				var_187_11.a = Mathf.Lerp(1, 0, (arg_184_1.time_ - var_187_9) / var_187_10)
				arg_184_1.mask_.color = var_187_11
			end

			if arg_184_1.time_ >= var_187_9 + var_187_10 and arg_184_1.time_ < var_187_9 + var_187_10 + arg_187_0 then
				local var_187_12 = Color.New(0, 0, 0)

				arg_184_1.mask_.enabled = false
				var_187_12.a = 0
				arg_184_1.mask_.color = var_187_12
			end

			local var_187_13 = arg_184_1.actors_["1075ui_actor"].transform

			if 1.96599999815226 < arg_184_1.time_ and arg_184_1.time_ <= 1.96599999815226 + arg_187_0 then
				arg_184_1.var_.moveOldPos1075ui_actor = var_187_13.localPosition

				local var_187_14 = GameObjectTools.GetOrAddComponent(var_187_13.gameObject, typeof(DynamicBoneHelper))

				if var_187_14 then
					var_187_14:EnableDynamicBone(false)
				end
			end

			local var_187_15 = 0.001

			if 1.96599999815226 <= arg_184_1.time_ and arg_184_1.time_ < 1.96599999815226 + var_187_15 then
				var_187_13.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_184_1.time_ - 1.96599999815226) / var_187_15)
				var_187_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_13.position).x, (manager.ui.mainCamera.transform.position - var_187_13.position).y, (manager.ui.mainCamera.transform.position - var_187_13.position).z)
				var_187_13.localEulerAngles.z = 0
				var_187_13.localEulerAngles.x = 0
				var_187_13.localEulerAngles = var_187_13.localEulerAngles
			end

			if arg_184_1.time_ >= 1.96599999815226 + var_187_15 and arg_184_1.time_ < 1.96599999815226 + var_187_15 + arg_187_0 then
				var_187_13.localPosition = Vector3.New(0, 100, 0)
				var_187_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_13.position).x, (manager.ui.mainCamera.transform.position - var_187_13.position).y, (manager.ui.mainCamera.transform.position - var_187_13.position).z)
				var_187_13.localEulerAngles.z = 0
				var_187_13.localEulerAngles.x = 0
				var_187_13.localEulerAngles = var_187_13.localEulerAngles

				local var_187_16 = GameObjectTools.GetOrAddComponent(var_187_13.gameObject, typeof(DynamicBoneHelper))

				if var_187_16 then
					var_187_16:EnableDynamicBone(true)
				end
			end

			local var_187_17 = arg_184_1.actors_["1075ui_actor"]

			if 1.96599999815226 < arg_184_1.time_ and arg_184_1.time_ <= 1.96599999815226 + arg_187_0 and not isNil(var_187_17) and arg_184_1.var_.characterEffect1075ui_actor == nil then
				arg_184_1.var_.characterEffect1075ui_actor = var_187_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_18 = 0.034000001847744

			if 1.96599999815226 <= arg_184_1.time_ and arg_184_1.time_ < 1.96599999815226 + var_187_18 and not isNil(var_187_17) then
				if arg_184_1.var_.characterEffect1075ui_actor and not isNil(var_187_17) then
					arg_184_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_184_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 1.96599999815226) / var_187_18)
				end
			end

			if arg_184_1.time_ >= 1.96599999815226 + var_187_18 and arg_184_1.time_ < 1.96599999815226 + var_187_18 + arg_187_0 and not isNil(var_187_17) and arg_184_1.var_.characterEffect1075ui_actor then
				arg_184_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_184_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			if 2 < arg_184_1.time_ and arg_184_1.time_ <= 2 + arg_187_0 then
				arg_184_1.fswbg_:SetActive(true)
				arg_184_1.dialog_:SetActive(false)

				arg_184_1.fswtw_.percent = 0
				arg_184_1.fswt_.text = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(1107506044).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.fswt_)

				arg_184_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_184_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_184_1.fswtw_:SetDirty()

				arg_184_1.typewritterCharCountI18N = 0

				SetActive(arg_184_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_184_1:ShowNextGo(false)
			end

			local var_187_19 = 2.03400000184774

			if 2.03400000184774 < arg_184_1.time_ and arg_184_1.time_ <= var_187_19 + arg_187_0 then
				arg_184_1.var_.oldValueTypewriter = arg_184_1.fswtw_.percent

				SetActive(arg_184_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_184_1:ShowNextGo(false)
			end

			local var_187_20 = 24
			local var_187_21 = 1.6
			local var_187_22, var_187_23 = arg_184_1:GetPercentByPara(arg_184_1:FormatText(arg_184_1:GetWordFromCfg(1107506044).content), 1)

			if var_187_19 < arg_184_1.time_ and arg_184_1.time_ <= var_187_19 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				local var_187_24 = var_187_20 <= 0 and var_187_21 or var_187_21 * ((var_187_23 - arg_184_1.typewritterCharCountI18N) / var_187_20)

				if (var_187_20 <= 0 and var_187_21 or var_187_21 * ((var_187_23 - arg_184_1.typewritterCharCountI18N) / var_187_20)) > 0 and var_187_21 < var_187_24 then
					arg_184_1.talkMaxDuration = var_187_24

					if var_187_24 + var_187_19 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_24 + var_187_19
					end
				end
			end

			local var_187_25 = math.max(1.6, arg_184_1.talkMaxDuration)

			if var_187_19 <= arg_184_1.time_ and arg_184_1.time_ < var_187_19 + var_187_25 then
				arg_184_1.fswtw_.percent = Mathf.Lerp(arg_184_1.var_.oldValueTypewriter, var_187_22, (arg_184_1.time_ - var_187_19) / var_187_25)
				arg_184_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_184_1.fswtw_:SetDirty()
			end

			if arg_184_1.time_ >= var_187_19 + var_187_25 and arg_184_1.time_ < var_187_19 + var_187_25 + arg_187_0 then
				arg_184_1.fswtw_.percent = var_187_22

				arg_184_1.fswtw_:SetDirty()
				arg_184_1:ShowNextGo(true)

				arg_184_1.typewritterCharCountI18N = var_187_23
			end

			if 2.1 < arg_184_1.time_ and arg_184_1.time_ <= 2.1 + arg_187_0 then
				local var_187_26 = arg_184_1.fswbg_.transform:Find("textbox/adapt/content") or arg_184_1.fswbg_.transform:Find("textbox/content")
				local var_187_27 = arg_184_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_187_28 = var_187_26:GetComponent("RectTransform")

				var_187_26:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_187_28.offsetMin = Vector2.New(0, 0)
				var_187_28.offsetMax = Vector2.New(0, 0)
			end

			local var_187_29 = 2.03400000184774
			local var_187_30 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506044", "") / 1000

			if var_187_30 > 0 and 1 < var_187_30 and var_187_30 + var_187_29 > arg_184_1.duration_ then
				arg_184_1.duration_ = var_187_30 + var_187_29
			end

			if var_187_29 < arg_184_1.time_ and arg_184_1.time_ <= var_187_29 + arg_187_0 then
				arg_184_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506044", "")
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play1107506045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1107506045
		arg_188_1.duration_ = 1.7

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1107506046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.fswbg_:SetActive(true)
				arg_188_1.dialog_:SetActive(false)

				arg_188_1.fswtw_.percent = 0
				arg_188_1.fswt_.text = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(1107506045).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.fswt_)

				arg_188_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_188_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_188_1.fswtw_:SetDirty()

				arg_188_1.typewritterCharCountI18N = 0

				SetActive(arg_188_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_188_1:ShowNextGo(false)
			end

			local var_191_0 = 0.1

			if 0.1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.var_.oldValueTypewriter = arg_188_1.fswtw_.percent

				SetActive(arg_188_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_188_1:ShowNextGo(false)
			end

			local var_191_1 = 24
			local var_191_2 = 1.6
			local var_191_3, var_191_4 = arg_188_1:GetPercentByPara(arg_188_1:FormatText(arg_188_1:GetWordFromCfg(1107506045).content), 1)

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				local var_191_5 = var_191_1 <= 0 and var_191_2 or var_191_2 * ((var_191_4 - arg_188_1.typewritterCharCountI18N) / var_191_1)

				if (var_191_1 <= 0 and var_191_2 or var_191_2 * ((var_191_4 - arg_188_1.typewritterCharCountI18N) / var_191_1)) > 0 and var_191_2 < var_191_5 then
					arg_188_1.talkMaxDuration = var_191_5

					if var_191_5 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + var_191_0
					end
				end
			end

			local var_191_6 = math.max(1.6, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_6 then
				arg_188_1.fswtw_.percent = Mathf.Lerp(arg_188_1.var_.oldValueTypewriter, var_191_3, (arg_188_1.time_ - var_191_0) / var_191_6)
				arg_188_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_188_1.fswtw_:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_6 and arg_188_1.time_ < var_191_0 + var_191_6 + arg_191_0 then
				arg_188_1.fswtw_.percent = var_191_3

				arg_188_1.fswtw_:SetDirty()
				arg_188_1:ShowNextGo(true)

				arg_188_1.typewritterCharCountI18N = var_191_4
			end

			local var_191_7 = 0.1
			local var_191_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506045", "") / 1000

			if var_191_8 > 0 and 1 < var_191_8 and var_191_8 + var_191_7 > arg_188_1.duration_ then
				arg_188_1.duration_ = var_191_8 + var_191_7
			end

			if var_191_7 < arg_188_1.time_ and arg_188_1.time_ <= var_191_7 + arg_191_0 then
				arg_188_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506045", "")
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1107506046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1107506046
		arg_192_1.duration_ = 1.73

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1107506047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.fswbg_:SetActive(true)
				arg_192_1.dialog_:SetActive(false)

				arg_192_1.fswtw_.percent = 0
				arg_192_1.fswt_.text = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(1107506046).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.fswt_)

				arg_192_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_192_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_192_1.fswtw_:SetDirty()

				arg_192_1.typewritterCharCountI18N = 0

				SetActive(arg_192_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_192_1:ShowNextGo(false)
			end

			local var_195_0 = 0.134000001847744

			if 0.134000001847744 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.var_.oldValueTypewriter = arg_192_1.fswtw_.percent

				SetActive(arg_192_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_192_1:ShowNextGo(false)
			end

			local var_195_1 = 24
			local var_195_2 = 1.6
			local var_195_3, var_195_4 = arg_192_1:GetPercentByPara(arg_192_1:FormatText(arg_192_1:GetWordFromCfg(1107506046).content), 1)

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				local var_195_5 = var_195_1 <= 0 and var_195_2 or var_195_2 * ((var_195_4 - arg_192_1.typewritterCharCountI18N) / var_195_1)

				if (var_195_1 <= 0 and var_195_2 or var_195_2 * ((var_195_4 - arg_192_1.typewritterCharCountI18N) / var_195_1)) > 0 and var_195_2 < var_195_5 then
					arg_192_1.talkMaxDuration = var_195_5

					if var_195_5 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + var_195_0
					end
				end
			end

			local var_195_6 = math.max(1.6, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_6 then
				arg_192_1.fswtw_.percent = Mathf.Lerp(arg_192_1.var_.oldValueTypewriter, var_195_3, (arg_192_1.time_ - var_195_0) / var_195_6)
				arg_192_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_192_1.fswtw_:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_6 and arg_192_1.time_ < var_195_0 + var_195_6 + arg_195_0 then
				arg_192_1.fswtw_.percent = var_195_3

				arg_192_1.fswtw_:SetDirty()
				arg_192_1:ShowNextGo(true)

				arg_192_1.typewritterCharCountI18N = var_195_4
			end

			local var_195_7 = 0.134000001847744
			local var_195_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506046", "") / 1000

			if var_195_8 > 0 and 1 < var_195_8 and var_195_8 + var_195_7 > arg_192_1.duration_ then
				arg_192_1.duration_ = var_195_8 + var_195_7
			end

			if var_195_7 < arg_192_1.time_ and arg_192_1.time_ <= var_195_7 + arg_195_0 then
				arg_192_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506046", "")
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play1107506047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1107506047
		arg_196_1.duration_ = 1.47

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1107506048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.fswbg_:SetActive(true)
				arg_196_1.dialog_:SetActive(false)

				arg_196_1.fswtw_.percent = 0
				arg_196_1.fswt_.text = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(1107506047).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.fswt_)

				arg_196_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_196_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_196_1.fswtw_:SetDirty()

				arg_196_1.typewritterCharCountI18N = 0

				SetActive(arg_196_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_196_1:ShowNextGo(false)
			end

			local var_199_0 = 0.134000001847744

			if 0.134000001847744 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.var_.oldValueTypewriter = arg_196_1.fswtw_.percent

				SetActive(arg_196_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_196_1:ShowNextGo(false)
			end

			local var_199_1 = 20
			local var_199_2 = 1.33333333333333
			local var_199_3, var_199_4 = arg_196_1:GetPercentByPara(arg_196_1:FormatText(arg_196_1:GetWordFromCfg(1107506047).content), 1)

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0

				local var_199_5 = var_199_1 <= 0 and var_199_2 or var_199_2 * ((var_199_4 - arg_196_1.typewritterCharCountI18N) / var_199_1)

				if (var_199_1 <= 0 and var_199_2 or var_199_2 * ((var_199_4 - arg_196_1.typewritterCharCountI18N) / var_199_1)) > 0 and var_199_2 < var_199_5 then
					arg_196_1.talkMaxDuration = var_199_5

					if var_199_5 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + var_199_0
					end
				end
			end

			local var_199_6 = math.max(1.33333333333333, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_6 then
				arg_196_1.fswtw_.percent = Mathf.Lerp(arg_196_1.var_.oldValueTypewriter, var_199_3, (arg_196_1.time_ - var_199_0) / var_199_6)
				arg_196_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_196_1.fswtw_:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_6 and arg_196_1.time_ < var_199_0 + var_199_6 + arg_199_0 then
				arg_196_1.fswtw_.percent = var_199_3

				arg_196_1.fswtw_:SetDirty()
				arg_196_1:ShowNextGo(true)

				arg_196_1.typewritterCharCountI18N = var_199_4
			end

			local var_199_7 = 0.134000001847744
			local var_199_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506047", "") / 1000

			if var_199_8 > 0 and 1 < var_199_8 and var_199_8 + var_199_7 > arg_196_1.duration_ then
				arg_196_1.duration_ = var_199_8 + var_199_7
			end

			if var_199_7 < arg_196_1.time_ and arg_196_1.time_ <= var_199_7 + arg_199_0 then
				arg_196_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506047", "")
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1107506048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1107506048
		arg_200_1.duration_ = 1.6

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1107506049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.fswbg_:SetActive(true)
				arg_200_1.dialog_:SetActive(false)

				arg_200_1.fswtw_.percent = 0
				arg_200_1.fswt_.text = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(1107506048).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.fswt_)

				arg_200_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_200_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_200_1.fswtw_:SetDirty()

				arg_200_1.typewritterCharCountI18N = 0

				SetActive(arg_200_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_200_1:ShowNextGo(false)
			end

			local var_203_0 = 0.134000001847744

			if 0.134000001847744 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.var_.oldValueTypewriter = arg_200_1.fswtw_.percent

				SetActive(arg_200_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_200_1:ShowNextGo(false)
			end

			local var_203_1 = 22
			local var_203_2 = 1.46666666666667
			local var_203_3, var_203_4 = arg_200_1:GetPercentByPara(arg_200_1:FormatText(arg_200_1:GetWordFromCfg(1107506048).content), 1)

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				local var_203_5 = var_203_1 <= 0 and var_203_2 or var_203_2 * ((var_203_4 - arg_200_1.typewritterCharCountI18N) / var_203_1)

				if (var_203_1 <= 0 and var_203_2 or var_203_2 * ((var_203_4 - arg_200_1.typewritterCharCountI18N) / var_203_1)) > 0 and var_203_2 < var_203_5 then
					arg_200_1.talkMaxDuration = var_203_5

					if var_203_5 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + var_203_0
					end
				end
			end

			local var_203_6 = math.max(1.46666666666667, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_6 then
				arg_200_1.fswtw_.percent = Mathf.Lerp(arg_200_1.var_.oldValueTypewriter, var_203_3, (arg_200_1.time_ - var_203_0) / var_203_6)
				arg_200_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_200_1.fswtw_:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_6 and arg_200_1.time_ < var_203_0 + var_203_6 + arg_203_0 then
				arg_200_1.fswtw_.percent = var_203_3

				arg_200_1.fswtw_:SetDirty()
				arg_200_1:ShowNextGo(true)

				arg_200_1.typewritterCharCountI18N = var_203_4
			end

			local var_203_7 = 0.134000001847744
			local var_203_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506048", "") / 1000

			if var_203_8 > 0 and 1 < var_203_8 and var_203_8 + var_203_7 > arg_200_1.duration_ then
				arg_200_1.duration_ = var_203_8 + var_203_7
			end

			if var_203_7 < arg_200_1.time_ and arg_200_1.time_ <= var_203_7 + arg_203_0 then
				arg_200_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506048", "")
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1107506049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1107506049
		arg_204_1.duration_ = 10.8

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1107506050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 2.00000000298023 < arg_204_1.time_ and arg_204_1.time_ <= 2.00000000298023 + arg_207_0 then
				local var_207_0 = arg_204_1.bgs_.ST47

				arg_204_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_207_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_207_1 = var_207_0:GetComponent("SpriteRenderer")

				if var_207_1 and var_207_1.sprite then
					local var_207_2 = 2 * (var_207_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_207_0.transform.localScale = Vector3.New(var_207_2 / var_207_1.sprite.bounds.size.y < var_207_2 * manager.ui.mainCameraCom_.aspect / var_207_1.sprite.bounds.size.x and var_207_2 * manager.ui.mainCameraCom_.aspect / var_207_1.sprite.bounds.size.x or var_207_2 / var_207_1.sprite.bounds.size.y, var_207_2 / var_207_1.sprite.bounds.size.y < var_207_2 * manager.ui.mainCameraCom_.aspect / var_207_1.sprite.bounds.size.x and var_207_2 * manager.ui.mainCameraCom_.aspect / var_207_1.sprite.bounds.size.x or var_207_2 / var_207_1.sprite.bounds.size.y, 0)
				end

				for iter_207_0, iter_207_1 in pairs(arg_204_1.bgs_) do
					if iter_207_0 ~= "ST47" then
						iter_207_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_207_3 = 4.00000000298023

			if 4.00000000298023 < arg_204_1.time_ and arg_204_1.time_ <= var_207_3 + arg_207_0 then
				arg_204_1.allBtn_.enabled = false
			end

			if arg_204_1.time_ >= var_207_3 + 0.3 and arg_204_1.time_ < var_207_3 + 0.3 + arg_207_0 then
				arg_204_1.allBtn_.enabled = true
			end

			local var_207_4 = 0

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_5 = 2

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_5 then
				local var_207_6 = Color.New(0, 0, 0)

				var_207_6.a = Mathf.Lerp(0, 1, (arg_204_1.time_ - var_207_4) / var_207_5)
				arg_204_1.mask_.color = var_207_6
			end

			if arg_204_1.time_ >= var_207_4 + var_207_5 and arg_204_1.time_ < var_207_4 + var_207_5 + arg_207_0 then
				local var_207_7 = Color.New(0, 0, 0)

				var_207_7.a = 1
				arg_204_1.mask_.color = var_207_7
			end

			local var_207_8 = 2

			if 2 < arg_204_1.time_ and arg_204_1.time_ <= var_207_8 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_9 = 2

			if var_207_8 <= arg_204_1.time_ and arg_204_1.time_ < var_207_8 + var_207_9 then
				local var_207_10 = Color.New(0, 0, 0)

				var_207_10.a = Mathf.Lerp(1, 0, (arg_204_1.time_ - var_207_8) / var_207_9)
				arg_204_1.mask_.color = var_207_10
			end

			if arg_204_1.time_ >= var_207_8 + var_207_9 and arg_204_1.time_ < var_207_8 + var_207_9 + arg_207_0 then
				local var_207_11 = Color.New(0, 0, 0)

				arg_204_1.mask_.enabled = false
				var_207_11.a = 0
				arg_204_1.mask_.color = var_207_11
			end

			local var_207_12 = arg_204_1.actors_["10044ui_story"].transform

			if 3.8 < arg_204_1.time_ and arg_204_1.time_ <= 3.8 + arg_207_0 then
				arg_204_1.var_.moveOldPos10044ui_story = var_207_12.localPosition
			end

			local var_207_13 = 0.001

			if 3.8 <= arg_204_1.time_ and arg_204_1.time_ < 3.8 + var_207_13 then
				var_207_12.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10044ui_story, Vector3.New(0, -0.72, -6.3), (arg_204_1.time_ - 3.8) / var_207_13)
				var_207_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_12.position).x, (manager.ui.mainCamera.transform.position - var_207_12.position).y, (manager.ui.mainCamera.transform.position - var_207_12.position).z)
				var_207_12.localEulerAngles.z = 0
				var_207_12.localEulerAngles.x = 0
				var_207_12.localEulerAngles = var_207_12.localEulerAngles
			end

			if arg_204_1.time_ >= 3.8 + var_207_13 and arg_204_1.time_ < 3.8 + var_207_13 + arg_207_0 then
				var_207_12.localPosition = Vector3.New(0, -0.72, -6.3)
				var_207_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_12.position).x, (manager.ui.mainCamera.transform.position - var_207_12.position).y, (manager.ui.mainCamera.transform.position - var_207_12.position).z)
				var_207_12.localEulerAngles.z = 0
				var_207_12.localEulerAngles.x = 0
				var_207_12.localEulerAngles = var_207_12.localEulerAngles
			end

			local var_207_14 = arg_204_1.actors_["10044ui_story"]

			if 3.8 < arg_204_1.time_ and arg_204_1.time_ <= 3.8 + arg_207_0 and not isNil(var_207_14) and arg_204_1.var_.characterEffect10044ui_story == nil then
				arg_204_1.var_.characterEffect10044ui_story = var_207_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_15 = 0.200000002980232

			if 3.8 <= arg_204_1.time_ and arg_204_1.time_ < 3.8 + var_207_15 and not isNil(var_207_14) then
				if arg_204_1.var_.characterEffect10044ui_story and not isNil(var_207_14) then
					arg_204_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 3.8 + var_207_15 and arg_204_1.time_ < 3.8 + var_207_15 + arg_207_0 and not isNil(var_207_14) and arg_204_1.var_.characterEffect10044ui_story then
				arg_204_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 3.8 < arg_204_1.time_ and arg_204_1.time_ <= 3.8 + arg_207_0 then
				arg_204_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			if 3.8 < arg_204_1.time_ and arg_204_1.time_ <= 3.8 + arg_207_0 then
				arg_204_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.95 < arg_204_1.time_ and arg_204_1.time_ <= 1.95 + arg_207_0 then
				arg_204_1.fswbg_:SetActive(false)
				arg_204_1.dialog_:SetActive(false)
				SetActive(arg_204_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_204_1:ShowNextGo(false)
			end

			local var_207_17 = 2.00000000298023

			arg_204_1.isInRecall_ = false

			if var_207_17 < arg_204_1.time_ and arg_204_1.time_ <= var_207_17 + arg_207_0 then
				arg_204_1.screenFilterGo_:SetActive(true)

				arg_204_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_207_2, iter_207_3 in pairs(arg_204_1.actors_) do
					for iter_207_4, iter_207_5 in ipairs((iter_207_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_207_5.color = iter_207_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_207_18 = 0.0333333333333332

			if var_207_17 <= arg_204_1.time_ and arg_204_1.time_ < var_207_17 + var_207_18 then
				arg_204_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_204_1.time_ - var_207_17) / var_207_18)
			end

			if arg_204_1.time_ >= var_207_17 + var_207_18 and arg_204_1.time_ < var_207_17 + var_207_18 + arg_207_0 then
				arg_204_1.screenFilterEffect_.weight = 1
			end

			if arg_204_1.frameCnt_ <= 1 then
				arg_204_1.dialog_:SetActive(false)
			end

			local var_207_19 = 4.00000000298023
			local var_207_20 = 0.8

			if 4.00000000298023 < arg_204_1.time_ and arg_204_1.time_ <= var_207_19 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0

				arg_204_1.dialog_:SetActive(true)

				arg_204_1.dialogCg_.alpha = 0

				local var_207_21 = LeanTween.value(arg_204_1.dialog_, 0, 1, 0.3)

				var_207_21:setOnUpdate(LuaHelper.FloatAction(function(arg_208_0)
					arg_204_1.dialogCg_.alpha = arg_208_0
				end))
				var_207_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_204_1.dialog_)
					var_207_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_204_1.duration_ = arg_204_1.duration_ + 0.3

				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_22 = arg_204_1:GetWordFromCfg(1107506049)
				local var_207_23 = arg_204_1:FormatText(var_207_22.content)

				arg_204_1.text_.text = var_207_23

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_25 = 32 <= 0 and var_207_20 or var_207_20 * (utf8.len(var_207_23) / 32)

				if (32 <= 0 and var_207_20 or var_207_20 * (utf8.len(var_207_23) / 32)) > 0 and var_207_20 < var_207_25 then
					arg_204_1.talkMaxDuration = var_207_25
					var_207_19 = var_207_19 + 0.3

					if var_207_25 + var_207_19 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_25 + var_207_19
					end
				end

				arg_204_1.text_.text = var_207_23
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506049", "story_v_side_new_1107506.awb") ~= 0 then
					local var_207_26 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506049", "story_v_side_new_1107506.awb") / 1000

					if var_207_26 + var_207_19 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_26 + var_207_19
					end

					if var_207_22.prefab_name ~= "" and arg_204_1.actors_[var_207_22.prefab_name] ~= nil then
						local var_207_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_22.prefab_name].transform, "story_v_side_new_1107506", "1107506049", "story_v_side_new_1107506.awb")

						arg_204_1:RecordAudio("1107506049", var_207_27)
						arg_204_1:RecordAudio("1107506049", var_207_27)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506049", "story_v_side_new_1107506.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506049", "story_v_side_new_1107506.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_28 = var_207_19 + 0.3
			local var_207_29 = math.max(var_207_20, arg_204_1.talkMaxDuration)

			if var_207_19 + 0.3 <= arg_204_1.time_ and arg_204_1.time_ < var_207_28 + var_207_29 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_28) / var_207_29

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_28 + var_207_29 and arg_204_1.time_ < var_207_28 + var_207_29 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play1107506050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1107506050
		arg_210_1.duration_ = 4.5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1107506051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos10044ui_story = arg_210_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10044ui_story, Vector3.New(-0.7, -0.72, -6.3), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10044ui_story"].transform.position).z)
				arg_210_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["10044ui_story"].transform.localEulerAngles = arg_210_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(-0.7, -0.72, -6.3)
				arg_210_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10044ui_story"].transform.position).z)
				arg_210_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["10044ui_story"].transform.localEulerAngles = arg_210_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_213_1 = arg_210_1.actors_["1075ui_actor"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1075ui_actor = var_213_1.localPosition

				local var_213_2 = GameObjectTools.GetOrAddComponent(var_213_1.gameObject, typeof(DynamicBoneHelper))

				if var_213_2 then
					var_213_2:EnableDynamicBone(false)
				end
			end

			local var_213_3 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 then
				var_213_1.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1075ui_actor, Vector3.New(0.7, -1.055, -6.16), (arg_210_1.time_ - 0) / var_213_3)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 then
				var_213_1.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles

				local var_213_4 = GameObjectTools.GetOrAddComponent(var_213_1.gameObject, typeof(DynamicBoneHelper))

				if var_213_4 then
					var_213_4:EnableDynamicBone(true)
				end
			end

			local var_213_5 = arg_210_1.actors_["1075ui_actor"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_5) and arg_210_1.var_.characterEffect1075ui_actor == nil then
				arg_210_1.var_.characterEffect1075ui_actor = var_213_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_6 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_6 and not isNil(var_213_5) then
				if arg_210_1.var_.characterEffect1075ui_actor and not isNil(var_213_5) then
					arg_210_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_6 and arg_210_1.time_ < 0 + var_213_6 + arg_213_0 and not isNil(var_213_5) and arg_210_1.var_.characterEffect1075ui_actor then
				arg_210_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_213_8 = arg_210_1.actors_["10044ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.characterEffect10044ui_story == nil then
				arg_210_1.var_.characterEffect10044ui_story = var_213_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_9 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_9 and not isNil(var_213_8) then
				if arg_210_1.var_.characterEffect10044ui_story and not isNil(var_213_8) then
					arg_210_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_210_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_9)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_9 and arg_210_1.time_ < 0 + var_213_9 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.characterEffect10044ui_story then
				arg_210_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_210_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_213_10 = 0
			local var_213_11 = 0.4

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_12 = arg_210_1:GetWordFromCfg(1107506050)
				local var_213_13 = arg_210_1:FormatText(var_213_12.content)

				arg_210_1.text_.text = var_213_13

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_15 = 16 <= 0 and var_213_11 or var_213_11 * (utf8.len(var_213_13) / 16)

				if (16 <= 0 and var_213_11 or var_213_11 * (utf8.len(var_213_13) / 16)) > 0 and var_213_11 < var_213_15 then
					arg_210_1.talkMaxDuration = var_213_15

					if var_213_15 + var_213_10 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_15 + var_213_10
					end
				end

				arg_210_1.text_.text = var_213_13
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506050", "story_v_side_new_1107506.awb") ~= 0 then
					local var_213_16 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506050", "story_v_side_new_1107506.awb") / 1000

					if var_213_16 + var_213_10 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_16 + var_213_10
					end

					if var_213_12.prefab_name ~= "" and arg_210_1.actors_[var_213_12.prefab_name] ~= nil then
						local var_213_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_12.prefab_name].transform, "story_v_side_new_1107506", "1107506050", "story_v_side_new_1107506.awb")

						arg_210_1:RecordAudio("1107506050", var_213_17)
						arg_210_1:RecordAudio("1107506050", var_213_17)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506050", "story_v_side_new_1107506.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506050", "story_v_side_new_1107506.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_18 = math.max(var_213_11, arg_210_1.talkMaxDuration)

			if var_213_10 <= arg_210_1.time_ and arg_210_1.time_ < var_213_10 + var_213_18 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_10) / var_213_18

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_10 + var_213_18 and arg_210_1.time_ < var_213_10 + var_213_18 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play1107506051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1107506051
		arg_214_1.duration_ = 5.6

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1107506052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10044ui_story"]) and arg_214_1.var_.characterEffect10044ui_story == nil then
				arg_214_1.var_.characterEffect10044ui_story = arg_214_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["10044ui_story"]) then
				if arg_214_1.var_.characterEffect10044ui_story and not isNil(arg_214_1.actors_["10044ui_story"]) then
					arg_214_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["10044ui_story"]) and arg_214_1.var_.characterEffect10044ui_story then
				arg_214_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_217_2 = arg_214_1.actors_["1075ui_actor"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.characterEffect1075ui_actor == nil then
				arg_214_1.var_.characterEffect1075ui_actor = var_217_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_3 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 and not isNil(var_217_2) then
				if arg_214_1.var_.characterEffect1075ui_actor and not isNil(var_217_2) then
					arg_214_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_214_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_3)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.characterEffect1075ui_actor then
				arg_214_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_214_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_217_4 = 0
			local var_217_5 = 0.575

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_6 = arg_214_1:GetWordFromCfg(1107506051)
				local var_217_7 = arg_214_1:FormatText(var_217_6.content)

				arg_214_1.text_.text = var_217_7

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 23 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 23)

				if (23 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 23)) > 0 and var_217_5 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_7
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506051", "story_v_side_new_1107506.awb") ~= 0 then
					local var_217_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506051", "story_v_side_new_1107506.awb") / 1000

					if var_217_10 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_4
					end

					if var_217_6.prefab_name ~= "" and arg_214_1.actors_[var_217_6.prefab_name] ~= nil then
						local var_217_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_6.prefab_name].transform, "story_v_side_new_1107506", "1107506051", "story_v_side_new_1107506.awb")

						arg_214_1:RecordAudio("1107506051", var_217_11)
						arg_214_1:RecordAudio("1107506051", var_217_11)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506051", "story_v_side_new_1107506.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506051", "story_v_side_new_1107506.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_12 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_12 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_12

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_12 and arg_214_1.time_ < var_217_4 + var_217_12 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1107506052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1107506052
		arg_218_1.duration_ = 7.3

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1107506053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1075ui_actor"]) and arg_218_1.var_.characterEffect1075ui_actor == nil then
				arg_218_1.var_.characterEffect1075ui_actor = arg_218_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1075ui_actor"]) then
				if arg_218_1.var_.characterEffect1075ui_actor and not isNil(arg_218_1.actors_["1075ui_actor"]) then
					arg_218_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1075ui_actor"]) and arg_218_1.var_.characterEffect1075ui_actor then
				arg_218_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_221_2 = arg_218_1.actors_["10044ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect10044ui_story == nil then
				arg_218_1.var_.characterEffect10044ui_story = var_221_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_3 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 and not isNil(var_221_2) then
				if arg_218_1.var_.characterEffect10044ui_story and not isNil(var_221_2) then
					arg_218_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_3)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect10044ui_story then
				arg_218_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_221_4 = 0
			local var_221_5 = 0.575

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(1107506052)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 23 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 23)

				if (23 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 23)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506052", "story_v_side_new_1107506.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506052", "story_v_side_new_1107506.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_side_new_1107506", "1107506052", "story_v_side_new_1107506.awb")

						arg_218_1:RecordAudio("1107506052", var_221_11)
						arg_218_1:RecordAudio("1107506052", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506052", "story_v_side_new_1107506.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506052", "story_v_side_new_1107506.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1107506053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1107506053
		arg_222_1.duration_ = 4.27

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1107506054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["10044ui_story"]) and arg_222_1.var_.characterEffect10044ui_story == nil then
				arg_222_1.var_.characterEffect10044ui_story = arg_222_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["10044ui_story"]) then
				if arg_222_1.var_.characterEffect10044ui_story and not isNil(arg_222_1.actors_["10044ui_story"]) then
					arg_222_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["10044ui_story"]) and arg_222_1.var_.characterEffect10044ui_story then
				arg_222_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_225_2 = arg_222_1.actors_["1075ui_actor"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.characterEffect1075ui_actor == nil then
				arg_222_1.var_.characterEffect1075ui_actor = var_225_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_3 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 and not isNil(var_225_2) then
				if arg_222_1.var_.characterEffect1075ui_actor and not isNil(var_225_2) then
					arg_222_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_222_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_3)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.characterEffect1075ui_actor then
				arg_222_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_222_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_225_4 = 0
			local var_225_5 = 0.35

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_6 = arg_222_1:GetWordFromCfg(1107506053)
				local var_225_7 = arg_222_1:FormatText(var_225_6.content)

				arg_222_1.text_.text = var_225_7

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 14 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 14)

				if (14 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 14)) > 0 and var_225_5 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_4
					end
				end

				arg_222_1.text_.text = var_225_7
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506053", "story_v_side_new_1107506.awb") ~= 0 then
					local var_225_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506053", "story_v_side_new_1107506.awb") / 1000

					if var_225_10 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_4
					end

					if var_225_6.prefab_name ~= "" and arg_222_1.actors_[var_225_6.prefab_name] ~= nil then
						local var_225_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_6.prefab_name].transform, "story_v_side_new_1107506", "1107506053", "story_v_side_new_1107506.awb")

						arg_222_1:RecordAudio("1107506053", var_225_11)
						arg_222_1:RecordAudio("1107506053", var_225_11)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506053", "story_v_side_new_1107506.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506053", "story_v_side_new_1107506.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_12 = math.max(var_225_5, arg_222_1.talkMaxDuration)

			if var_225_4 <= arg_222_1.time_ and arg_222_1.time_ < var_225_4 + var_225_12 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_4) / var_225_12

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_4 + var_225_12 and arg_222_1.time_ < var_225_4 + var_225_12 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1107506054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1107506054
		arg_226_1.duration_ = 6.23

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1107506055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1075ui_actor"]) and arg_226_1.var_.characterEffect1075ui_actor == nil then
				arg_226_1.var_.characterEffect1075ui_actor = arg_226_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1075ui_actor"]) then
				if arg_226_1.var_.characterEffect1075ui_actor and not isNil(arg_226_1.actors_["1075ui_actor"]) then
					arg_226_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1075ui_actor"]) and arg_226_1.var_.characterEffect1075ui_actor then
				arg_226_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_229_2 = arg_226_1.actors_["10044ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.characterEffect10044ui_story == nil then
				arg_226_1.var_.characterEffect10044ui_story = var_229_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_3 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.characterEffect10044ui_story and not isNil(var_229_2) then
					arg_226_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_226_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_3)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.characterEffect10044ui_story then
				arg_226_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_226_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action423")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_229_4 = 0
			local var_229_5 = 0.625

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:GetWordFromCfg(1107506054)
				local var_229_7 = arg_226_1:FormatText(var_229_6.content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 25 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 25)

				if (25 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 25)) > 0 and var_229_5 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506054", "story_v_side_new_1107506.awb") ~= 0 then
					local var_229_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506054", "story_v_side_new_1107506.awb") / 1000

					if var_229_10 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_4
					end

					if var_229_6.prefab_name ~= "" and arg_226_1.actors_[var_229_6.prefab_name] ~= nil then
						local var_229_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_6.prefab_name].transform, "story_v_side_new_1107506", "1107506054", "story_v_side_new_1107506.awb")

						arg_226_1:RecordAudio("1107506054", var_229_11)
						arg_226_1:RecordAudio("1107506054", var_229_11)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506054", "story_v_side_new_1107506.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506054", "story_v_side_new_1107506.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_12 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_12 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_12

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_12 and arg_226_1.time_ < var_229_4 + var_229_12 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play1107506055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1107506055
		arg_230_1.duration_ = 7.4

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1107506056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10044ui_story"]) and arg_230_1.var_.characterEffect10044ui_story == nil then
				arg_230_1.var_.characterEffect10044ui_story = arg_230_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10044ui_story"]) then
				if arg_230_1.var_.characterEffect10044ui_story and not isNil(arg_230_1.actors_["10044ui_story"]) then
					arg_230_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10044ui_story"]) and arg_230_1.var_.characterEffect10044ui_story then
				arg_230_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_233_2 = arg_230_1.actors_["1075ui_actor"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.characterEffect1075ui_actor == nil then
				arg_230_1.var_.characterEffect1075ui_actor = var_233_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_3 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_3 and not isNil(var_233_2) then
				if arg_230_1.var_.characterEffect1075ui_actor and not isNil(var_233_2) then
					arg_230_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_230_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_3)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_3 and arg_230_1.time_ < 0 + var_233_3 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.characterEffect1075ui_actor then
				arg_230_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_230_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_233_4 = 0
			local var_233_5 = 0.9

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_6 = arg_230_1:GetWordFromCfg(1107506055)
				local var_233_7 = arg_230_1:FormatText(var_233_6.content)

				arg_230_1.text_.text = var_233_7

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 36 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 36)

				if (36 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 36)) > 0 and var_233_5 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_7
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506055", "story_v_side_new_1107506.awb") ~= 0 then
					local var_233_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506055", "story_v_side_new_1107506.awb") / 1000

					if var_233_10 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_4
					end

					if var_233_6.prefab_name ~= "" and arg_230_1.actors_[var_233_6.prefab_name] ~= nil then
						local var_233_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_6.prefab_name].transform, "story_v_side_new_1107506", "1107506055", "story_v_side_new_1107506.awb")

						arg_230_1:RecordAudio("1107506055", var_233_11)
						arg_230_1:RecordAudio("1107506055", var_233_11)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506055", "story_v_side_new_1107506.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506055", "story_v_side_new_1107506.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_12 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_12 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_4) / var_233_12

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_4 + var_233_12 and arg_230_1.time_ < var_233_4 + var_233_12 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1107506056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1107506056
		arg_234_1.duration_ = 2

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1107506057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1075ui_actor"]) and arg_234_1.var_.characterEffect1075ui_actor == nil then
				arg_234_1.var_.characterEffect1075ui_actor = arg_234_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1075ui_actor"]) then
				if arg_234_1.var_.characterEffect1075ui_actor and not isNil(arg_234_1.actors_["1075ui_actor"]) then
					arg_234_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1075ui_actor"]) and arg_234_1.var_.characterEffect1075ui_actor then
				arg_234_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_237_2 = arg_234_1.actors_["10044ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.characterEffect10044ui_story == nil then
				arg_234_1.var_.characterEffect10044ui_story = var_237_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_3 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_3 and not isNil(var_237_2) then
				if arg_234_1.var_.characterEffect10044ui_story and not isNil(var_237_2) then
					arg_234_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_234_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_3)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_3 and arg_234_1.time_ < 0 + var_237_3 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.characterEffect10044ui_story then
				arg_234_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_234_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_237_4 = 0
			local var_237_5 = 0.15

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_6 = arg_234_1:GetWordFromCfg(1107506056)
				local var_237_7 = arg_234_1:FormatText(var_237_6.content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 6 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 6)

				if (6 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 6)) > 0 and var_237_5 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506056", "story_v_side_new_1107506.awb") ~= 0 then
					local var_237_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506056", "story_v_side_new_1107506.awb") / 1000

					if var_237_10 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_4
					end

					if var_237_6.prefab_name ~= "" and arg_234_1.actors_[var_237_6.prefab_name] ~= nil then
						local var_237_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_6.prefab_name].transform, "story_v_side_new_1107506", "1107506056", "story_v_side_new_1107506.awb")

						arg_234_1:RecordAudio("1107506056", var_237_11)
						arg_234_1:RecordAudio("1107506056", var_237_11)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506056", "story_v_side_new_1107506.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506056", "story_v_side_new_1107506.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_12 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_12 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_12

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_12 and arg_234_1.time_ < var_237_4 + var_237_12 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1107506057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1107506057
		arg_238_1.duration_ = 9

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1107506058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 2 < arg_238_1.time_ and arg_238_1.time_ <= 2 + arg_241_0 then
				local var_241_0 = arg_238_1.bgs_.ST37a

				arg_238_1.bgs_.ST37a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_241_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_1 = var_241_0:GetComponent("SpriteRenderer")

				if var_241_1 and var_241_1.sprite then
					local var_241_2 = 2 * (var_241_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_241_0.transform.localScale = Vector3.New(var_241_2 / var_241_1.sprite.bounds.size.y < var_241_2 * manager.ui.mainCameraCom_.aspect / var_241_1.sprite.bounds.size.x and var_241_2 * manager.ui.mainCameraCom_.aspect / var_241_1.sprite.bounds.size.x or var_241_2 / var_241_1.sprite.bounds.size.y, var_241_2 / var_241_1.sprite.bounds.size.y < var_241_2 * manager.ui.mainCameraCom_.aspect / var_241_1.sprite.bounds.size.x and var_241_2 * manager.ui.mainCameraCom_.aspect / var_241_1.sprite.bounds.size.x or var_241_2 / var_241_1.sprite.bounds.size.y, 0)
				end

				for iter_241_0, iter_241_1 in pairs(arg_238_1.bgs_) do
					if iter_241_0 ~= "ST37a" then
						iter_241_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_3 = 3.999999999999

			if 3.999999999999 < arg_238_1.time_ and arg_238_1.time_ <= var_241_3 + arg_241_0 then
				arg_238_1.allBtn_.enabled = false
			end

			if arg_238_1.time_ >= var_241_3 + 0.3 and arg_238_1.time_ < var_241_3 + 0.3 + arg_241_0 then
				arg_238_1.allBtn_.enabled = true
			end

			local var_241_4 = 0

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_5 = 2

			if var_241_4 <= arg_238_1.time_ and arg_238_1.time_ < var_241_4 + var_241_5 then
				local var_241_6 = Color.New(0, 0, 0)

				var_241_6.a = Mathf.Lerp(0, 1, (arg_238_1.time_ - var_241_4) / var_241_5)
				arg_238_1.mask_.color = var_241_6
			end

			if arg_238_1.time_ >= var_241_4 + var_241_5 and arg_238_1.time_ < var_241_4 + var_241_5 + arg_241_0 then
				local var_241_7 = Color.New(0, 0, 0)

				var_241_7.a = 1
				arg_238_1.mask_.color = var_241_7
			end

			local var_241_8 = 2

			if 2 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_9 = 2

			if var_241_8 <= arg_238_1.time_ and arg_238_1.time_ < var_241_8 + var_241_9 then
				local var_241_10 = Color.New(0, 0, 0)

				var_241_10.a = Mathf.Lerp(1, 0, (arg_238_1.time_ - var_241_8) / var_241_9)
				arg_238_1.mask_.color = var_241_10
			end

			if arg_238_1.time_ >= var_241_8 + var_241_9 and arg_238_1.time_ < var_241_8 + var_241_9 + arg_241_0 then
				local var_241_11 = Color.New(0, 0, 0)

				arg_238_1.mask_.enabled = false
				var_241_11.a = 0
				arg_238_1.mask_.color = var_241_11
			end

			local var_241_12 = arg_238_1.actors_["10044ui_story"].transform

			if 1.96599999815226 < arg_238_1.time_ and arg_238_1.time_ <= 1.96599999815226 + arg_241_0 then
				arg_238_1.var_.moveOldPos10044ui_story = var_241_12.localPosition
			end

			local var_241_13 = 0.001

			if 1.96599999815226 <= arg_238_1.time_ and arg_238_1.time_ < 1.96599999815226 + var_241_13 then
				var_241_12.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 1.96599999815226) / var_241_13)
				var_241_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_12.position).x, (manager.ui.mainCamera.transform.position - var_241_12.position).y, (manager.ui.mainCamera.transform.position - var_241_12.position).z)
				var_241_12.localEulerAngles.z = 0
				var_241_12.localEulerAngles.x = 0
				var_241_12.localEulerAngles = var_241_12.localEulerAngles
			end

			if arg_238_1.time_ >= 1.96599999815226 + var_241_13 and arg_238_1.time_ < 1.96599999815226 + var_241_13 + arg_241_0 then
				var_241_12.localPosition = Vector3.New(0, 100, 0)
				var_241_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_12.position).x, (manager.ui.mainCamera.transform.position - var_241_12.position).y, (manager.ui.mainCamera.transform.position - var_241_12.position).z)
				var_241_12.localEulerAngles.z = 0
				var_241_12.localEulerAngles.x = 0
				var_241_12.localEulerAngles = var_241_12.localEulerAngles
			end

			local var_241_14 = arg_238_1.actors_["1075ui_actor"].transform

			if 1.96599999815226 < arg_238_1.time_ and arg_238_1.time_ <= 1.96599999815226 + arg_241_0 then
				arg_238_1.var_.moveOldPos1075ui_actor = var_241_14.localPosition

				local var_241_15 = GameObjectTools.GetOrAddComponent(var_241_14.gameObject, typeof(DynamicBoneHelper))

				if var_241_15 then
					var_241_15:EnableDynamicBone(false)
				end
			end

			local var_241_16 = 0.001

			if 1.96599999815226 <= arg_238_1.time_ and arg_238_1.time_ < 1.96599999815226 + var_241_16 then
				var_241_14.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_238_1.time_ - 1.96599999815226) / var_241_16)
				var_241_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_14.position).x, (manager.ui.mainCamera.transform.position - var_241_14.position).y, (manager.ui.mainCamera.transform.position - var_241_14.position).z)
				var_241_14.localEulerAngles.z = 0
				var_241_14.localEulerAngles.x = 0
				var_241_14.localEulerAngles = var_241_14.localEulerAngles
			end

			if arg_238_1.time_ >= 1.96599999815226 + var_241_16 and arg_238_1.time_ < 1.96599999815226 + var_241_16 + arg_241_0 then
				var_241_14.localPosition = Vector3.New(0, 100, 0)
				var_241_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_14.position).x, (manager.ui.mainCamera.transform.position - var_241_14.position).y, (manager.ui.mainCamera.transform.position - var_241_14.position).z)
				var_241_14.localEulerAngles.z = 0
				var_241_14.localEulerAngles.x = 0
				var_241_14.localEulerAngles = var_241_14.localEulerAngles

				local var_241_17 = GameObjectTools.GetOrAddComponent(var_241_14.gameObject, typeof(DynamicBoneHelper))

				if var_241_17 then
					var_241_17:EnableDynamicBone(true)
				end
			end

			local var_241_18 = arg_238_1.actors_["1075ui_actor"]

			if 1.96599999815226 < arg_238_1.time_ and arg_238_1.time_ <= 1.96599999815226 + arg_241_0 and not isNil(var_241_18) and arg_238_1.var_.characterEffect1075ui_actor == nil then
				arg_238_1.var_.characterEffect1075ui_actor = var_241_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_19 = 0.034000001847744

			if 1.96599999815226 <= arg_238_1.time_ and arg_238_1.time_ < 1.96599999815226 + var_241_19 and not isNil(var_241_18) then
				if arg_238_1.var_.characterEffect1075ui_actor and not isNil(var_241_18) then
					arg_238_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_238_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 1.96599999815226) / var_241_19)
				end
			end

			if arg_238_1.time_ >= 1.96599999815226 + var_241_19 and arg_238_1.time_ < 1.96599999815226 + var_241_19 + arg_241_0 and not isNil(var_241_18) and arg_238_1.var_.characterEffect1075ui_actor then
				arg_238_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_238_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_241_20 = 1.96666666666667

			arg_238_1.isInRecall_ = false

			if var_241_20 < arg_238_1.time_ and arg_238_1.time_ <= var_241_20 + arg_241_0 then
				arg_238_1.screenFilterGo_:SetActive(false)

				for iter_241_2, iter_241_3 in pairs(arg_238_1.actors_) do
					for iter_241_4, iter_241_5 in ipairs((iter_241_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_241_5.color = iter_241_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_241_21 = 0.0333333333333332

			if var_241_20 <= arg_238_1.time_ and arg_238_1.time_ < var_241_20 + var_241_21 then
				arg_238_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_238_1.time_ - var_241_20) / var_241_21)
			end

			if arg_238_1.time_ >= var_241_20 + var_241_21 and arg_238_1.time_ < var_241_20 + var_241_21 + arg_241_0 then
				arg_238_1.screenFilterEffect_.weight = 0
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_241_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_24 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_24

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_24
						arg_238_1.bgmTxt2_.text = var_241_24
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.66666666666667 < arg_238_1.time_ and arg_238_1.time_ <= 1.66666666666667 + arg_241_0 then
				arg_238_1:AudioAction("play", "music", "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_241_27 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if "" ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_27 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_27

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_27
						arg_238_1.bgmTxt2_.text = var_241_27
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.76666666666667 < arg_238_1.time_ and arg_238_1.time_ <= 1.76666666666667 + arg_241_0 then
				arg_238_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_rain_inside01", "")
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_29 = 4
			local var_241_30 = 0.575

			if 4 < arg_238_1.time_ and arg_238_1.time_ <= var_241_29 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_31 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_31:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_238_1.dialogCg_.alpha = arg_244_0
				end))
				var_241_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_32 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(1107506057).content)

				arg_238_1.text_.text = var_241_32

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_34 = 23 <= 0 and var_241_30 or var_241_30 * (utf8.len(var_241_32) / 23)

				if (23 <= 0 and var_241_30 or var_241_30 * (utf8.len(var_241_32) / 23)) > 0 and var_241_30 < var_241_34 then
					arg_238_1.talkMaxDuration = var_241_34
					var_241_29 = var_241_29 + 0.3

					if var_241_34 + var_241_29 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_34 + var_241_29
					end
				end

				arg_238_1.text_.text = var_241_32
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_35 = var_241_29 + 0.3
			local var_241_36 = math.max(var_241_30, arg_238_1.talkMaxDuration)

			if var_241_29 + 0.3 <= arg_238_1.time_ and arg_238_1.time_ < var_241_35 + var_241_36 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_35) / var_241_36

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_35 + var_241_36 and arg_238_1.time_ < var_241_35 + var_241_36 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play1107506058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1107506058
		arg_246_1.duration_ = 5.8

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1107506059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1075ui_actor = arg_246_1.actors_["1075ui_actor"].transform.localPosition

				local var_249_0 = GameObjectTools.GetOrAddComponent(arg_246_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_249_0 then
					var_249_0:EnableDynamicBone(false)
				end
			end

			local var_249_1 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_1 then
				arg_246_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_246_1.time_ - 0) / var_249_1)
				arg_246_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1075ui_actor"].transform.position).z)
				arg_246_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_246_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_1 and arg_246_1.time_ < 0 + var_249_1 + arg_249_0 then
				arg_246_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_246_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1075ui_actor"].transform.position).z)
				arg_246_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_246_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_249_2 = GameObjectTools.GetOrAddComponent(arg_246_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_249_2 then
					var_249_2:EnableDynamicBone(true)
				end
			end

			local var_249_3 = arg_246_1.actors_["1075ui_actor"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_3) and arg_246_1.var_.characterEffect1075ui_actor == nil then
				arg_246_1.var_.characterEffect1075ui_actor = var_249_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_4 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 and not isNil(var_249_3) then
				if arg_246_1.var_.characterEffect1075ui_actor and not isNil(var_249_3) then
					arg_246_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 and not isNil(var_249_3) and arg_246_1.var_.characterEffect1075ui_actor then
				arg_246_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_249_6 = 0
			local var_249_7 = 0.55

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_8 = arg_246_1:GetWordFromCfg(1107506058)
				local var_249_9 = arg_246_1:FormatText(var_249_8.content)

				arg_246_1.text_.text = var_249_9

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_11 = 22 <= 0 and var_249_7 or var_249_7 * (utf8.len(var_249_9) / 22)

				if (22 <= 0 and var_249_7 or var_249_7 * (utf8.len(var_249_9) / 22)) > 0 and var_249_7 < var_249_11 then
					arg_246_1.talkMaxDuration = var_249_11

					if var_249_11 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_11 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_9
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506058", "story_v_side_new_1107506.awb") ~= 0 then
					local var_249_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506058", "story_v_side_new_1107506.awb") / 1000

					if var_249_12 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_12 + var_249_6
					end

					if var_249_8.prefab_name ~= "" and arg_246_1.actors_[var_249_8.prefab_name] ~= nil then
						local var_249_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_8.prefab_name].transform, "story_v_side_new_1107506", "1107506058", "story_v_side_new_1107506.awb")

						arg_246_1:RecordAudio("1107506058", var_249_13)
						arg_246_1:RecordAudio("1107506058", var_249_13)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506058", "story_v_side_new_1107506.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506058", "story_v_side_new_1107506.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_14 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_14 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_14

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_14 and arg_246_1.time_ < var_249_6 + var_249_14 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play1107506059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1107506059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1107506060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1075ui_actor"]) and arg_250_1.var_.characterEffect1075ui_actor == nil then
				arg_250_1.var_.characterEffect1075ui_actor = arg_250_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1075ui_actor"]) then
				if arg_250_1.var_.characterEffect1075ui_actor and not isNil(arg_250_1.actors_["1075ui_actor"]) then
					arg_250_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_250_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_0)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1075ui_actor"]) and arg_250_1.var_.characterEffect1075ui_actor then
				arg_250_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_250_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_253_1 = 0
			local var_253_2 = 0.425

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(1107506059).content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 17 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 17)

				if (17 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 17)) > 0 and var_253_2 < var_253_5 then
					arg_250_1.talkMaxDuration = var_253_5

					if var_253_5 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_6 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_6 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_6

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_6 and arg_250_1.time_ < var_253_1 + var_253_6 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1107506060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1107506060
		arg_254_1.duration_ = 2.67

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1107506061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1075ui_actor"]) and arg_254_1.var_.characterEffect1075ui_actor == nil then
				arg_254_1.var_.characterEffect1075ui_actor = arg_254_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1075ui_actor"]) then
				if arg_254_1.var_.characterEffect1075ui_actor and not isNil(arg_254_1.actors_["1075ui_actor"]) then
					arg_254_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1075ui_actor"]) and arg_254_1.var_.characterEffect1075ui_actor then
				arg_254_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_257_2 = 0
			local var_257_3 = 0.25

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_2 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_4 = arg_254_1:GetWordFromCfg(1107506060)
				local var_257_5 = arg_254_1:FormatText(var_257_4.content)

				arg_254_1.text_.text = var_257_5

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_7 = 10 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_5) / 10)

				if (10 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_5) / 10)) > 0 and var_257_3 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_2
					end
				end

				arg_254_1.text_.text = var_257_5
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506060", "story_v_side_new_1107506.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506060", "story_v_side_new_1107506.awb") / 1000

					if var_257_8 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_2
					end

					if var_257_4.prefab_name ~= "" and arg_254_1.actors_[var_257_4.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_4.prefab_name].transform, "story_v_side_new_1107506", "1107506060", "story_v_side_new_1107506.awb")

						arg_254_1:RecordAudio("1107506060", var_257_9)
						arg_254_1:RecordAudio("1107506060", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506060", "story_v_side_new_1107506.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506060", "story_v_side_new_1107506.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_3, arg_254_1.talkMaxDuration)

			if var_257_2 <= arg_254_1.time_ and arg_254_1.time_ < var_257_2 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_2) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_2 + var_257_10 and arg_254_1.time_ < var_257_2 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1107506061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1107506061
		arg_258_1.duration_ = 7.53

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1107506062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.775

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:GetWordFromCfg(1107506061)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 31 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 31)

				if (31 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 31)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506061", "story_v_side_new_1107506.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506061", "story_v_side_new_1107506.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_side_new_1107506", "1107506061", "story_v_side_new_1107506.awb")

						arg_258_1:RecordAudio("1107506061", var_261_6)
						arg_258_1:RecordAudio("1107506061", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506061", "story_v_side_new_1107506.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506061", "story_v_side_new_1107506.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1107506062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1107506062
		arg_262_1.duration_ = 5.47

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1107506063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.625

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_1 = arg_262_1:GetWordFromCfg(1107506062)
				local var_265_2 = arg_262_1:FormatText(var_265_1.content)

				arg_262_1.text_.text = var_265_2

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 25 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 25)

				if (25 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 25)) > 0 and var_265_0 < var_265_4 then
					arg_262_1.talkMaxDuration = var_265_4

					if var_265_4 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_4 + 0
					end
				end

				arg_262_1.text_.text = var_265_2
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506062", "story_v_side_new_1107506.awb") ~= 0 then
					local var_265_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506062", "story_v_side_new_1107506.awb") / 1000

					if var_265_5 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + 0
					end

					if var_265_1.prefab_name ~= "" and arg_262_1.actors_[var_265_1.prefab_name] ~= nil then
						local var_265_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_1.prefab_name].transform, "story_v_side_new_1107506", "1107506062", "story_v_side_new_1107506.awb")

						arg_262_1:RecordAudio("1107506062", var_265_6)
						arg_262_1:RecordAudio("1107506062", var_265_6)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506062", "story_v_side_new_1107506.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506062", "story_v_side_new_1107506.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1107506063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1107506063
		arg_266_1.duration_ = 6.23

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1107506064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action434")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_269_0 = 0
			local var_269_1 = 0.575

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_2 = arg_266_1:GetWordFromCfg(1107506063)
				local var_269_3 = arg_266_1:FormatText(var_269_2.content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 23 <= 0 and var_269_1 or var_269_1 * (utf8.len(var_269_3) / 23)

				if (23 <= 0 and var_269_1 or var_269_1 * (utf8.len(var_269_3) / 23)) > 0 and var_269_1 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506063", "story_v_side_new_1107506.awb") ~= 0 then
					local var_269_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506063", "story_v_side_new_1107506.awb") / 1000

					if var_269_6 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_0
					end

					if var_269_2.prefab_name ~= "" and arg_266_1.actors_[var_269_2.prefab_name] ~= nil then
						local var_269_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_2.prefab_name].transform, "story_v_side_new_1107506", "1107506063", "story_v_side_new_1107506.awb")

						arg_266_1:RecordAudio("1107506063", var_269_7)
						arg_266_1:RecordAudio("1107506063", var_269_7)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506063", "story_v_side_new_1107506.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506063", "story_v_side_new_1107506.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_8 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_8 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_8

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_8 and arg_266_1.time_ < var_269_0 + var_269_8 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1107506064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1107506064
		arg_270_1.duration_ = 1

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"

			SetActive(arg_270_1.choicesGo_, true)

			for iter_271_0, iter_271_1 in ipairs(arg_270_1.choices_) do
				SetActive(iter_271_1.go, iter_271_0 <= 2)
			end

			arg_270_1.choices_[1].txt.text = arg_270_1:FormatText(StoryChoiceCfg[1167].name)
			arg_270_1.choices_[2].txt.text = arg_270_1:FormatText(StoryChoiceCfg[1168].name)
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1107506065(arg_270_1)
			end

			if arg_272_0 == 2 then
				arg_270_0:Play1107506065(arg_270_1)
			end

			arg_270_1:RecordChoiceLog(1107506064, 1167, 1168)
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1075ui_actor"]) and arg_270_1.var_.characterEffect1075ui_actor == nil then
				arg_270_1.var_.characterEffect1075ui_actor = arg_270_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1075ui_actor"]) then
				if arg_270_1.var_.characterEffect1075ui_actor and not isNil(arg_270_1.actors_["1075ui_actor"]) then
					arg_270_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_270_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_0)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1075ui_actor"]) and arg_270_1.var_.characterEffect1075ui_actor then
				arg_270_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_270_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_273_1 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			if arg_270_1.time_ >= var_273_1 + 0.6 and arg_270_1.time_ < var_273_1 + 0.6 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1107506065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1107506065
		arg_274_1.duration_ = 7.73

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1107506066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1075ui_actor"]) and arg_274_1.var_.characterEffect1075ui_actor == nil then
				arg_274_1.var_.characterEffect1075ui_actor = arg_274_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1075ui_actor"]) then
				if arg_274_1.var_.characterEffect1075ui_actor and not isNil(arg_274_1.actors_["1075ui_actor"]) then
					arg_274_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1075ui_actor"]) and arg_274_1.var_.characterEffect1075ui_actor then
				arg_274_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_277_2 = "1075ui_actor"

			if arg_274_1.actors_["1075ui_actor"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_actor"))) then
				local var_277_3 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_274_1.stage_.transform)

				var_277_3.name = var_277_2
				var_277_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.actors_[var_277_2] = var_277_3

				local var_277_4 = var_277_3:GetComponentInChildren(typeof(CharacterEffect))

				var_277_4.enabled = true

				local var_277_5 = GameObjectTools.GetOrAddComponent(var_277_3, typeof(DynamicBoneHelper))

				if var_277_5 then
					var_277_5:EnableDynamicBone(false)
				end

				arg_274_1:ShowWeapon(var_277_4.transform, false)

				arg_274_1.var_[var_277_2 .. "Animator"] = var_277_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_274_1.var_[var_277_2 .. "Animator"].applyRootMotion = true
				arg_274_1.var_[var_277_2 .. "LipSync"] = var_277_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_277_6 = "1075ui_actor"

			if arg_274_1.actors_["1075ui_actor"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_actor"))) then
				local var_277_7 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_274_1.stage_.transform)

				var_277_7.name = var_277_6
				var_277_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.actors_[var_277_6] = var_277_7

				local var_277_8 = var_277_7:GetComponentInChildren(typeof(CharacterEffect))

				var_277_8.enabled = true

				local var_277_9 = GameObjectTools.GetOrAddComponent(var_277_7, typeof(DynamicBoneHelper))

				if var_277_9 then
					var_277_9:EnableDynamicBone(false)
				end

				arg_274_1:ShowWeapon(var_277_8.transform, false)

				arg_274_1.var_[var_277_6 .. "Animator"] = var_277_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_274_1.var_[var_277_6 .. "Animator"].applyRootMotion = true
				arg_274_1.var_[var_277_6 .. "LipSync"] = var_277_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_277_10 = 0
			local var_277_11 = 0.675

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_12 = arg_274_1:GetWordFromCfg(1107506065)
				local var_277_13 = arg_274_1:FormatText(var_277_12.content)

				arg_274_1.text_.text = var_277_13

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_15 = 27 <= 0 and var_277_11 or var_277_11 * (utf8.len(var_277_13) / 27)

				if (27 <= 0 and var_277_11 or var_277_11 * (utf8.len(var_277_13) / 27)) > 0 and var_277_11 < var_277_15 then
					arg_274_1.talkMaxDuration = var_277_15

					if var_277_15 + var_277_10 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_15 + var_277_10
					end
				end

				arg_274_1.text_.text = var_277_13
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506065", "story_v_side_new_1107506.awb") ~= 0 then
					local var_277_16 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506065", "story_v_side_new_1107506.awb") / 1000

					if var_277_16 + var_277_10 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_16 + var_277_10
					end

					if var_277_12.prefab_name ~= "" and arg_274_1.actors_[var_277_12.prefab_name] ~= nil then
						local var_277_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_12.prefab_name].transform, "story_v_side_new_1107506", "1107506065", "story_v_side_new_1107506.awb")

						arg_274_1:RecordAudio("1107506065", var_277_17)
						arg_274_1:RecordAudio("1107506065", var_277_17)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506065", "story_v_side_new_1107506.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506065", "story_v_side_new_1107506.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_18 = math.max(var_277_11, arg_274_1.talkMaxDuration)

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_18 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_10) / var_277_18

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_10 + var_277_18 and arg_274_1.time_ < var_277_10 + var_277_18 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1107506066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1107506066
		arg_278_1.duration_ = 6.37

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1107506067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.65

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:GetWordFromCfg(1107506066)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.text_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 26 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 26)

				if (26 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 26)) > 0 and var_281_0 < var_281_4 then
					arg_278_1.talkMaxDuration = var_281_4

					if var_281_4 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_4 + 0
					end
				end

				arg_278_1.text_.text = var_281_2
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506066", "story_v_side_new_1107506.awb") ~= 0 then
					local var_281_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506066", "story_v_side_new_1107506.awb") / 1000

					if var_281_5 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + 0
					end

					if var_281_1.prefab_name ~= "" and arg_278_1.actors_[var_281_1.prefab_name] ~= nil then
						local var_281_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_1.prefab_name].transform, "story_v_side_new_1107506", "1107506066", "story_v_side_new_1107506.awb")

						arg_278_1:RecordAudio("1107506066", var_281_6)
						arg_278_1:RecordAudio("1107506066", var_281_6)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506066", "story_v_side_new_1107506.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506066", "story_v_side_new_1107506.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play1107506067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1107506067
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1107506068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1075ui_actor"]) and arg_282_1.var_.characterEffect1075ui_actor == nil then
				arg_282_1.var_.characterEffect1075ui_actor = arg_282_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1075ui_actor"]) then
				if arg_282_1.var_.characterEffect1075ui_actor and not isNil(arg_282_1.actors_["1075ui_actor"]) then
					arg_282_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_282_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_0)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1075ui_actor"]) and arg_282_1.var_.characterEffect1075ui_actor then
				arg_282_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_282_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_285_1 = 0
			local var_285_2 = 0.825

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_3 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(1107506067).content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 33 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 33)

				if (33 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 33)) > 0 and var_285_2 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_1
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_6 = math.max(var_285_2, arg_282_1.talkMaxDuration)

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_6 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_1) / var_285_6

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_1 + var_285_6 and arg_282_1.time_ < var_285_1 + var_285_6 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play1107506068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1107506068
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1107506069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.65

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_1 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(1107506068).content)

				arg_286_1.text_.text = var_289_1

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_3 = 26 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 26)

				if (26 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 26)) > 0 and var_289_0 < var_289_3 then
					arg_286_1.talkMaxDuration = var_289_3

					if var_289_3 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_3 + 0
					end
				end

				arg_286_1.text_.text = var_289_1
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_4 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_4

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1107506069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1107506069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1107506070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.875

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_1 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(1107506069).content)

				arg_290_1.text_.text = var_293_1

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_3 = 35 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 35)

				if (35 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 35)) > 0 and var_293_0 < var_293_3 then
					arg_290_1.talkMaxDuration = var_293_3

					if var_293_3 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_3 + 0
					end
				end

				arg_290_1.text_.text = var_293_1
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_4 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_4

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1107506070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1107506070
		arg_294_1.duration_ = 2.37

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1107506071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1075ui_actor"]) and arg_294_1.var_.characterEffect1075ui_actor == nil then
				arg_294_1.var_.characterEffect1075ui_actor = arg_294_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1075ui_actor"]) then
				if arg_294_1.var_.characterEffect1075ui_actor and not isNil(arg_294_1.actors_["1075ui_actor"]) then
					arg_294_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1075ui_actor"]) and arg_294_1.var_.characterEffect1075ui_actor then
				arg_294_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_297_2 = 0
			local var_297_3 = 0.275

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_2 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_4 = arg_294_1:GetWordFromCfg(1107506070)
				local var_297_5 = arg_294_1:FormatText(var_297_4.content)

				arg_294_1.text_.text = var_297_5

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_7 = 11 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 11)

				if (11 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 11)) > 0 and var_297_3 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_2
					end
				end

				arg_294_1.text_.text = var_297_5
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506070", "story_v_side_new_1107506.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506070", "story_v_side_new_1107506.awb") / 1000

					if var_297_8 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_2
					end

					if var_297_4.prefab_name ~= "" and arg_294_1.actors_[var_297_4.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_4.prefab_name].transform, "story_v_side_new_1107506", "1107506070", "story_v_side_new_1107506.awb")

						arg_294_1:RecordAudio("1107506070", var_297_9)
						arg_294_1:RecordAudio("1107506070", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506070", "story_v_side_new_1107506.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506070", "story_v_side_new_1107506.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_3, arg_294_1.talkMaxDuration)

			if var_297_2 <= arg_294_1.time_ and arg_294_1.time_ < var_297_2 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_2) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_2 + var_297_10 and arg_294_1.time_ < var_297_2 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1107506071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1107506071
		arg_298_1.duration_ = 7.77

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1107506072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.85

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:GetWordFromCfg(1107506071)
				local var_301_2 = arg_298_1:FormatText(var_301_1.content)

				arg_298_1.text_.text = var_301_2

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 34 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 34)

				if (34 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 34)) > 0 and var_301_0 < var_301_4 then
					arg_298_1.talkMaxDuration = var_301_4

					if var_301_4 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_4 + 0
					end
				end

				arg_298_1.text_.text = var_301_2
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506071", "story_v_side_new_1107506.awb") ~= 0 then
					local var_301_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506071", "story_v_side_new_1107506.awb") / 1000

					if var_301_5 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + 0
					end

					if var_301_1.prefab_name ~= "" and arg_298_1.actors_[var_301_1.prefab_name] ~= nil then
						local var_301_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_1.prefab_name].transform, "story_v_side_new_1107506", "1107506071", "story_v_side_new_1107506.awb")

						arg_298_1:RecordAudio("1107506071", var_301_6)
						arg_298_1:RecordAudio("1107506071", var_301_6)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506071", "story_v_side_new_1107506.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506071", "story_v_side_new_1107506.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_7 and arg_298_1.time_ < 0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play1107506072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1107506072
		arg_302_1.duration_ = 9.53

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1107506073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_305_0 = 0
			local var_305_1 = 0.8

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_2 = arg_302_1:GetWordFromCfg(1107506072)
				local var_305_3 = arg_302_1:FormatText(var_305_2.content)

				arg_302_1.text_.text = var_305_3

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_5 = 32 <= 0 and var_305_1 or var_305_1 * (utf8.len(var_305_3) / 32)

				if (32 <= 0 and var_305_1 or var_305_1 * (utf8.len(var_305_3) / 32)) > 0 and var_305_1 < var_305_5 then
					arg_302_1.talkMaxDuration = var_305_5

					if var_305_5 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_5 + var_305_0
					end
				end

				arg_302_1.text_.text = var_305_3
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506072", "story_v_side_new_1107506.awb") ~= 0 then
					local var_305_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506072", "story_v_side_new_1107506.awb") / 1000

					if var_305_6 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_6 + var_305_0
					end

					if var_305_2.prefab_name ~= "" and arg_302_1.actors_[var_305_2.prefab_name] ~= nil then
						local var_305_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_2.prefab_name].transform, "story_v_side_new_1107506", "1107506072", "story_v_side_new_1107506.awb")

						arg_302_1:RecordAudio("1107506072", var_305_7)
						arg_302_1:RecordAudio("1107506072", var_305_7)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506072", "story_v_side_new_1107506.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506072", "story_v_side_new_1107506.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_8 = math.max(var_305_1, arg_302_1.talkMaxDuration)

			if var_305_0 <= arg_302_1.time_ and arg_302_1.time_ < var_305_0 + var_305_8 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_0) / var_305_8

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_0 + var_305_8 and arg_302_1.time_ < var_305_0 + var_305_8 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play1107506073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1107506073
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1107506074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1075ui_actor"]) and arg_306_1.var_.characterEffect1075ui_actor == nil then
				arg_306_1.var_.characterEffect1075ui_actor = arg_306_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1075ui_actor"]) then
				if arg_306_1.var_.characterEffect1075ui_actor and not isNil(arg_306_1.actors_["1075ui_actor"]) then
					arg_306_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_306_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1075ui_actor"]) and arg_306_1.var_.characterEffect1075ui_actor then
				arg_306_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_306_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_309_1 = 0
			local var_309_2 = 0.8

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(1107506073).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 32 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 32)

				if (32 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 32)) > 0 and var_309_2 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_6 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_6 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_6

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_6 and arg_306_1.time_ < var_309_1 + var_309_6 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play1107506074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1107506074
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1107506075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0.775

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_1 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(1107506074).content)

				arg_310_1.text_.text = var_313_1

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_3 = 31 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 31)

				if (31 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 31)) > 0 and var_313_0 < var_313_3 then
					arg_310_1.talkMaxDuration = var_313_3

					if var_313_3 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_3 + 0
					end
				end

				arg_310_1.text_.text = var_313_1
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_4 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_4

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1107506075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1107506075
		arg_314_1.duration_ = 15.67

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1107506076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1075ui_actor"]) and arg_314_1.var_.characterEffect1075ui_actor == nil then
				arg_314_1.var_.characterEffect1075ui_actor = arg_314_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1075ui_actor"]) then
				if arg_314_1.var_.characterEffect1075ui_actor and not isNil(arg_314_1.actors_["1075ui_actor"]) then
					arg_314_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1075ui_actor"]) and arg_314_1.var_.characterEffect1075ui_actor then
				arg_314_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_317_2 = 0
			local var_317_3 = 1.375

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_2 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_4 = arg_314_1:GetWordFromCfg(1107506075)
				local var_317_5 = arg_314_1:FormatText(var_317_4.content)

				arg_314_1.text_.text = var_317_5

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_7 = 55 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_5) / 55)

				if (55 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_5) / 55)) > 0 and var_317_3 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_2
					end
				end

				arg_314_1.text_.text = var_317_5
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506075", "story_v_side_new_1107506.awb") ~= 0 then
					local var_317_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506075", "story_v_side_new_1107506.awb") / 1000

					if var_317_8 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_8 + var_317_2
					end

					if var_317_4.prefab_name ~= "" and arg_314_1.actors_[var_317_4.prefab_name] ~= nil then
						local var_317_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_4.prefab_name].transform, "story_v_side_new_1107506", "1107506075", "story_v_side_new_1107506.awb")

						arg_314_1:RecordAudio("1107506075", var_317_9)
						arg_314_1:RecordAudio("1107506075", var_317_9)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506075", "story_v_side_new_1107506.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506075", "story_v_side_new_1107506.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_3, arg_314_1.talkMaxDuration)

			if var_317_2 <= arg_314_1.time_ and arg_314_1.time_ < var_317_2 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_2) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_2 + var_317_10 and arg_314_1.time_ < var_317_2 + var_317_10 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1107506076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1107506076
		arg_318_1.duration_ = 4.87

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1107506077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.575

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_1 = arg_318_1:GetWordFromCfg(1107506076)
				local var_321_2 = arg_318_1:FormatText(var_321_1.content)

				arg_318_1.text_.text = var_321_2

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 23 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 23)

				if (23 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 23)) > 0 and var_321_0 < var_321_4 then
					arg_318_1.talkMaxDuration = var_321_4

					if var_321_4 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_4 + 0
					end
				end

				arg_318_1.text_.text = var_321_2
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506076", "story_v_side_new_1107506.awb") ~= 0 then
					local var_321_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506076", "story_v_side_new_1107506.awb") / 1000

					if var_321_5 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + 0
					end

					if var_321_1.prefab_name ~= "" and arg_318_1.actors_[var_321_1.prefab_name] ~= nil then
						local var_321_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_1.prefab_name].transform, "story_v_side_new_1107506", "1107506076", "story_v_side_new_1107506.awb")

						arg_318_1:RecordAudio("1107506076", var_321_6)
						arg_318_1:RecordAudio("1107506076", var_321_6)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506076", "story_v_side_new_1107506.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506076", "story_v_side_new_1107506.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play1107506077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1107506077
		arg_322_1.duration_ = 7.67

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1107506078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_325_0 = 0
			local var_325_1 = 0.65

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_2 = arg_322_1:GetWordFromCfg(1107506077)
				local var_325_3 = arg_322_1:FormatText(var_325_2.content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 26 <= 0 and var_325_1 or var_325_1 * (utf8.len(var_325_3) / 26)

				if (26 <= 0 and var_325_1 or var_325_1 * (utf8.len(var_325_3) / 26)) > 0 and var_325_1 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506077", "story_v_side_new_1107506.awb") ~= 0 then
					local var_325_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506077", "story_v_side_new_1107506.awb") / 1000

					if var_325_6 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_0
					end

					if var_325_2.prefab_name ~= "" and arg_322_1.actors_[var_325_2.prefab_name] ~= nil then
						local var_325_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_2.prefab_name].transform, "story_v_side_new_1107506", "1107506077", "story_v_side_new_1107506.awb")

						arg_322_1:RecordAudio("1107506077", var_325_7)
						arg_322_1:RecordAudio("1107506077", var_325_7)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506077", "story_v_side_new_1107506.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506077", "story_v_side_new_1107506.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_8 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_8 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_8

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_8 and arg_322_1.time_ < var_325_0 + var_325_8 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1107506078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1107506078
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1107506079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos10044ui_story = arg_326_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_329_0 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				arg_326_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10044ui_story"].transform.position).z)
				arg_326_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["10044ui_story"].transform.localEulerAngles = arg_326_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				arg_326_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10044ui_story"].transform.position).z)
				arg_326_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["10044ui_story"].transform.localEulerAngles = arg_326_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_329_1 = arg_326_1.actors_["1075ui_actor"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect1075ui_actor == nil then
				arg_326_1.var_.characterEffect1075ui_actor = var_329_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_2 and not isNil(var_329_1) then
				if arg_326_1.var_.characterEffect1075ui_actor and not isNil(var_329_1) then
					arg_326_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_326_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_2)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_2 and arg_326_1.time_ < 0 + var_329_2 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect1075ui_actor then
				arg_326_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_326_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_329_3 = 0
			local var_329_4 = 1.075

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_3 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_5 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(1107506078).content)

				arg_326_1.text_.text = var_329_5

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_7 = 43 <= 0 and var_329_4 or var_329_4 * (utf8.len(var_329_5) / 43)

				if (43 <= 0 and var_329_4 or var_329_4 * (utf8.len(var_329_5) / 43)) > 0 and var_329_4 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_3 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_3
					end
				end

				arg_326_1.text_.text = var_329_5
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_8 = math.max(var_329_4, arg_326_1.talkMaxDuration)

			if var_329_3 <= arg_326_1.time_ and arg_326_1.time_ < var_329_3 + var_329_8 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_3) / var_329_8

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_3 + var_329_8 and arg_326_1.time_ < var_329_3 + var_329_8 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play1107506079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1107506079
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1107506080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.675

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(1107506079).content)

				arg_330_1.text_.text = var_333_1

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_3 = 27 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 27)

				if (27 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 27)) > 0 and var_333_0 < var_333_3 then
					arg_330_1.talkMaxDuration = var_333_3

					if var_333_3 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_3 + 0
					end
				end

				arg_330_1.text_.text = var_333_1
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_4 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_4

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1107506080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1107506080
		arg_334_1.duration_ = 7.93

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1107506081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1075ui_actor = arg_334_1.actors_["1075ui_actor"].transform.localPosition

				local var_337_0 = GameObjectTools.GetOrAddComponent(arg_334_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_337_0 then
					var_337_0:EnableDynamicBone(false)
				end
			end

			local var_337_1 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_1 then
				arg_334_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_334_1.time_ - 0) / var_337_1)
				arg_334_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1075ui_actor"].transform.position).z)
				arg_334_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_334_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_1 and arg_334_1.time_ < 0 + var_337_1 + arg_337_0 then
				arg_334_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_334_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1075ui_actor"].transform.position).z)
				arg_334_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_334_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_337_2 = GameObjectTools.GetOrAddComponent(arg_334_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_337_2 then
					var_337_2:EnableDynamicBone(true)
				end
			end

			local var_337_3 = arg_334_1.actors_["1075ui_actor"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_3) and arg_334_1.var_.characterEffect1075ui_actor == nil then
				arg_334_1.var_.characterEffect1075ui_actor = var_337_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_4 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 and not isNil(var_337_3) then
				if arg_334_1.var_.characterEffect1075ui_actor and not isNil(var_337_3) then
					arg_334_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 and not isNil(var_337_3) and arg_334_1.var_.characterEffect1075ui_actor then
				arg_334_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_337_6 = 0
			local var_337_7 = 0.95

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_8 = arg_334_1:GetWordFromCfg(1107506080)
				local var_337_9 = arg_334_1:FormatText(var_337_8.content)

				arg_334_1.text_.text = var_337_9

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_11 = 38 <= 0 and var_337_7 or var_337_7 * (utf8.len(var_337_9) / 38)

				if (38 <= 0 and var_337_7 or var_337_7 * (utf8.len(var_337_9) / 38)) > 0 and var_337_7 < var_337_11 then
					arg_334_1.talkMaxDuration = var_337_11

					if var_337_11 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_11 + var_337_6
					end
				end

				arg_334_1.text_.text = var_337_9
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506080", "story_v_side_new_1107506.awb") ~= 0 then
					local var_337_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506080", "story_v_side_new_1107506.awb") / 1000

					if var_337_12 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_12 + var_337_6
					end

					if var_337_8.prefab_name ~= "" and arg_334_1.actors_[var_337_8.prefab_name] ~= nil then
						local var_337_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_8.prefab_name].transform, "story_v_side_new_1107506", "1107506080", "story_v_side_new_1107506.awb")

						arg_334_1:RecordAudio("1107506080", var_337_13)
						arg_334_1:RecordAudio("1107506080", var_337_13)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506080", "story_v_side_new_1107506.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506080", "story_v_side_new_1107506.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_14 = math.max(var_337_7, arg_334_1.talkMaxDuration)

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_14 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_6) / var_337_14

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_6 + var_337_14 and arg_334_1.time_ < var_337_6 + var_337_14 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play1107506081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1107506081
		arg_338_1.duration_ = 1

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"

			SetActive(arg_338_1.choicesGo_, true)

			for iter_339_0, iter_339_1 in ipairs(arg_338_1.choices_) do
				SetActive(iter_339_1.go, iter_339_0 <= 1)
			end

			arg_338_1.choices_[1].txt.text = arg_338_1:FormatText(StoryChoiceCfg[1169].name)
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1107506082(arg_338_1)
			end

			arg_338_1:RecordChoiceLog(1107506081, 1169)
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1075ui_actor"]) and arg_338_1.var_.characterEffect1075ui_actor == nil then
				arg_338_1.var_.characterEffect1075ui_actor = arg_338_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1075ui_actor"]) then
				if arg_338_1.var_.characterEffect1075ui_actor and not isNil(arg_338_1.actors_["1075ui_actor"]) then
					arg_338_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_338_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_0)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1075ui_actor"]) and arg_338_1.var_.characterEffect1075ui_actor then
				arg_338_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_338_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_341_1 = 0

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.allBtn_.enabled = false
			end

			if arg_338_1.time_ >= var_341_1 + 0.5 and arg_338_1.time_ < var_341_1 + 0.5 + arg_341_0 then
				arg_338_1.allBtn_.enabled = true
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1107506082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1107506082
		arg_342_1.duration_ = 2

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1107506083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1075ui_actor"]) and arg_342_1.var_.characterEffect1075ui_actor == nil then
				arg_342_1.var_.characterEffect1075ui_actor = arg_342_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1075ui_actor"]) then
				if arg_342_1.var_.characterEffect1075ui_actor and not isNil(arg_342_1.actors_["1075ui_actor"]) then
					arg_342_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1075ui_actor"]) and arg_342_1.var_.characterEffect1075ui_actor then
				arg_342_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_345_2 = 0
			local var_345_3 = 0.125

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_2 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_4 = arg_342_1:GetWordFromCfg(1107506082)
				local var_345_5 = arg_342_1:FormatText(var_345_4.content)

				arg_342_1.text_.text = var_345_5

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_7 = 5 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_5) / 5)

				if (5 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_5) / 5)) > 0 and var_345_3 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_2
					end
				end

				arg_342_1.text_.text = var_345_5
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506082", "story_v_side_new_1107506.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506082", "story_v_side_new_1107506.awb") / 1000

					if var_345_8 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_2
					end

					if var_345_4.prefab_name ~= "" and arg_342_1.actors_[var_345_4.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_4.prefab_name].transform, "story_v_side_new_1107506", "1107506082", "story_v_side_new_1107506.awb")

						arg_342_1:RecordAudio("1107506082", var_345_9)
						arg_342_1:RecordAudio("1107506082", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506082", "story_v_side_new_1107506.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506082", "story_v_side_new_1107506.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_3, arg_342_1.talkMaxDuration)

			if var_345_2 <= arg_342_1.time_ and arg_342_1.time_ < var_345_2 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_2) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_2 + var_345_10 and arg_342_1.time_ < var_345_2 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1107506083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1107506083
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1107506084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1075ui_actor"]) and arg_346_1.var_.characterEffect1075ui_actor == nil then
				arg_346_1.var_.characterEffect1075ui_actor = arg_346_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1075ui_actor"]) then
				if arg_346_1.var_.characterEffect1075ui_actor and not isNil(arg_346_1.actors_["1075ui_actor"]) then
					arg_346_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_346_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_0)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1075ui_actor"]) and arg_346_1.var_.characterEffect1075ui_actor then
				arg_346_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_346_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_349_1 = 0
			local var_349_2 = 0.75

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_3 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(1107506083).content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 30 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 30)

				if (30 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 30)) > 0 and var_349_2 < var_349_5 then
					arg_346_1.talkMaxDuration = var_349_5

					if var_349_5 + var_349_1 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + var_349_1
					end
				end

				arg_346_1.text_.text = var_349_3
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_6 = math.max(var_349_2, arg_346_1.talkMaxDuration)

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_6 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_1) / var_349_6

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_1 + var_349_6 and arg_346_1.time_ < var_349_1 + var_349_6 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1107506084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1107506084
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1107506085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.85

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_1 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(1107506084).content)

				arg_350_1.text_.text = var_353_1

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_3 = 34 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 34)

				if (34 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 34)) > 0 and var_353_0 < var_353_3 then
					arg_350_1.talkMaxDuration = var_353_3

					if var_353_3 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_3 + 0
					end
				end

				arg_350_1.text_.text = var_353_1
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_4 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_4

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play1107506085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1107506085
		arg_354_1.duration_ = 8.6

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1107506086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["1075ui_actor"]) and arg_354_1.var_.characterEffect1075ui_actor == nil then
				arg_354_1.var_.characterEffect1075ui_actor = arg_354_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["1075ui_actor"]) then
				if arg_354_1.var_.characterEffect1075ui_actor and not isNil(arg_354_1.actors_["1075ui_actor"]) then
					arg_354_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["1075ui_actor"]) and arg_354_1.var_.characterEffect1075ui_actor then
				arg_354_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_357_2 = 0
			local var_357_3 = 0.9

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_4 = arg_354_1:GetWordFromCfg(1107506085)
				local var_357_5 = arg_354_1:FormatText(var_357_4.content)

				arg_354_1.text_.text = var_357_5

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_7 = 36 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 36)

				if (36 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 36)) > 0 and var_357_3 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_2
					end
				end

				arg_354_1.text_.text = var_357_5
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506085", "story_v_side_new_1107506.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506085", "story_v_side_new_1107506.awb") / 1000

					if var_357_8 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_2
					end

					if var_357_4.prefab_name ~= "" and arg_354_1.actors_[var_357_4.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_4.prefab_name].transform, "story_v_side_new_1107506", "1107506085", "story_v_side_new_1107506.awb")

						arg_354_1:RecordAudio("1107506085", var_357_9)
						arg_354_1:RecordAudio("1107506085", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506085", "story_v_side_new_1107506.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506085", "story_v_side_new_1107506.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_3, arg_354_1.talkMaxDuration)

			if var_357_2 <= arg_354_1.time_ and arg_354_1.time_ < var_357_2 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_2) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_2 + var_357_10 and arg_354_1.time_ < var_357_2 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1107506086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1107506086
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1107506087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1075ui_actor"]) and arg_358_1.var_.characterEffect1075ui_actor == nil then
				arg_358_1.var_.characterEffect1075ui_actor = arg_358_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1075ui_actor"]) then
				if arg_358_1.var_.characterEffect1075ui_actor and not isNil(arg_358_1.actors_["1075ui_actor"]) then
					arg_358_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_358_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_0)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1075ui_actor"]) and arg_358_1.var_.characterEffect1075ui_actor then
				arg_358_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_358_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_rain_inside01", "")
			end

			if 0.1 < arg_358_1.time_ and arg_358_1.time_ <= 0.1 + arg_361_0 then
				arg_358_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_rain_inside02", "")
			end

			local var_361_3 = 0
			local var_361_4 = 1

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_3 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_5 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(1107506086).content)

				arg_358_1.text_.text = var_361_5

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_7 = 40 <= 0 and var_361_4 or var_361_4 * (utf8.len(var_361_5) / 40)

				if (40 <= 0 and var_361_4 or var_361_4 * (utf8.len(var_361_5) / 40)) > 0 and var_361_4 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_3 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_3
					end
				end

				arg_358_1.text_.text = var_361_5
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_8 = math.max(var_361_4, arg_358_1.talkMaxDuration)

			if var_361_3 <= arg_358_1.time_ and arg_358_1.time_ < var_361_3 + var_361_8 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_3) / var_361_8

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_3 + var_361_8 and arg_358_1.time_ < var_361_3 + var_361_8 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1107506087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1107506087
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1107506088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.825

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_1 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(1107506087).content)

				arg_362_1.text_.text = var_365_1

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_3 = 33 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_1) / 33)

				if (33 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_1) / 33)) > 0 and var_365_0 < var_365_3 then
					arg_362_1.talkMaxDuration = var_365_3

					if var_365_3 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_3 + 0
					end
				end

				arg_362_1.text_.text = var_365_1
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_4 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_4 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_4

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_4 and arg_362_1.time_ < 0 + var_365_4 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1107506088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1107506088
		arg_366_1.duration_ = 3.63

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1107506089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1075ui_actor"]) and arg_366_1.var_.characterEffect1075ui_actor == nil then
				arg_366_1.var_.characterEffect1075ui_actor = arg_366_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1075ui_actor"]) then
				if arg_366_1.var_.characterEffect1075ui_actor and not isNil(arg_366_1.actors_["1075ui_actor"]) then
					arg_366_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1075ui_actor"]) and arg_366_1.var_.characterEffect1075ui_actor then
				arg_366_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_369_2 = 0
			local var_369_3 = 0.55

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_2 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_4 = arg_366_1:GetWordFromCfg(1107506088)
				local var_369_5 = arg_366_1:FormatText(var_369_4.content)

				arg_366_1.text_.text = var_369_5

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_7 = 22 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 22)

				if (22 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 22)) > 0 and var_369_3 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_2
					end
				end

				arg_366_1.text_.text = var_369_5
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506088", "story_v_side_new_1107506.awb") ~= 0 then
					local var_369_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506088", "story_v_side_new_1107506.awb") / 1000

					if var_369_8 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_2
					end

					if var_369_4.prefab_name ~= "" and arg_366_1.actors_[var_369_4.prefab_name] ~= nil then
						local var_369_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_4.prefab_name].transform, "story_v_side_new_1107506", "1107506088", "story_v_side_new_1107506.awb")

						arg_366_1:RecordAudio("1107506088", var_369_9)
						arg_366_1:RecordAudio("1107506088", var_369_9)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506088", "story_v_side_new_1107506.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506088", "story_v_side_new_1107506.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_10 = math.max(var_369_3, arg_366_1.talkMaxDuration)

			if var_369_2 <= arg_366_1.time_ and arg_366_1.time_ < var_369_2 + var_369_10 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_2) / var_369_10

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_2 + var_369_10 and arg_366_1.time_ < var_369_2 + var_369_10 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1107506089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1107506089
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1107506090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1075ui_actor"]) and arg_370_1.var_.characterEffect1075ui_actor == nil then
				arg_370_1.var_.characterEffect1075ui_actor = arg_370_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1075ui_actor"]) then
				if arg_370_1.var_.characterEffect1075ui_actor and not isNil(arg_370_1.actors_["1075ui_actor"]) then
					arg_370_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_370_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_0)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1075ui_actor"]) and arg_370_1.var_.characterEffect1075ui_actor then
				arg_370_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_370_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_373_1 = 0
			local var_373_2 = 0.625

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(1107506089).content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 25 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 25)

				if (25 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 25)) > 0 and var_373_2 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_6 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_6 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_6

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_6 and arg_370_1.time_ < var_373_1 + var_373_6 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1107506090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1107506090
		arg_374_1.duration_ = 3.03

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1107506091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["1075ui_actor"]) and arg_374_1.var_.characterEffect1075ui_actor == nil then
				arg_374_1.var_.characterEffect1075ui_actor = arg_374_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_0 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["1075ui_actor"]) then
				if arg_374_1.var_.characterEffect1075ui_actor and not isNil(arg_374_1.actors_["1075ui_actor"]) then
					arg_374_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["1075ui_actor"]) and arg_374_1.var_.characterEffect1075ui_actor then
				arg_374_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_377_2 = 0
			local var_377_3 = 0.2

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_2 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_4 = arg_374_1:GetWordFromCfg(1107506090)
				local var_377_5 = arg_374_1:FormatText(var_377_4.content)

				arg_374_1.text_.text = var_377_5

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_7 = 8 <= 0 and var_377_3 or var_377_3 * (utf8.len(var_377_5) / 8)

				if (8 <= 0 and var_377_3 or var_377_3 * (utf8.len(var_377_5) / 8)) > 0 and var_377_3 < var_377_7 then
					arg_374_1.talkMaxDuration = var_377_7

					if var_377_7 + var_377_2 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_2
					end
				end

				arg_374_1.text_.text = var_377_5
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506090", "story_v_side_new_1107506.awb") ~= 0 then
					local var_377_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506090", "story_v_side_new_1107506.awb") / 1000

					if var_377_8 + var_377_2 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_8 + var_377_2
					end

					if var_377_4.prefab_name ~= "" and arg_374_1.actors_[var_377_4.prefab_name] ~= nil then
						local var_377_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_4.prefab_name].transform, "story_v_side_new_1107506", "1107506090", "story_v_side_new_1107506.awb")

						arg_374_1:RecordAudio("1107506090", var_377_9)
						arg_374_1:RecordAudio("1107506090", var_377_9)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506090", "story_v_side_new_1107506.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506090", "story_v_side_new_1107506.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_10 = math.max(var_377_3, arg_374_1.talkMaxDuration)

			if var_377_2 <= arg_374_1.time_ and arg_374_1.time_ < var_377_2 + var_377_10 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_2) / var_377_10

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_2 + var_377_10 and arg_374_1.time_ < var_377_2 + var_377_10 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1107506091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1107506091
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1107506092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1075ui_actor"]) and arg_378_1.var_.characterEffect1075ui_actor == nil then
				arg_378_1.var_.characterEffect1075ui_actor = arg_378_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1075ui_actor"]) then
				if arg_378_1.var_.characterEffect1075ui_actor and not isNil(arg_378_1.actors_["1075ui_actor"]) then
					arg_378_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_378_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_0)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1075ui_actor"]) and arg_378_1.var_.characterEffect1075ui_actor then
				arg_378_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_378_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_381_1 = 0
			local var_381_2 = 1.025

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_3 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(1107506091).content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 41 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 41)

				if (41 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 41)) > 0 and var_381_2 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_1
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_6 = math.max(var_381_2, arg_378_1.talkMaxDuration)

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_6 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_1) / var_381_6

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_1 + var_381_6 and arg_378_1.time_ < var_381_1 + var_381_6 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1107506092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1107506092
		arg_382_1.duration_ = 4.17

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1107506093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1075ui_actor"]) and arg_382_1.var_.characterEffect1075ui_actor == nil then
				arg_382_1.var_.characterEffect1075ui_actor = arg_382_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1075ui_actor"]) then
				if arg_382_1.var_.characterEffect1075ui_actor and not isNil(arg_382_1.actors_["1075ui_actor"]) then
					arg_382_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1075ui_actor"]) and arg_382_1.var_.characterEffect1075ui_actor then
				arg_382_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_385_2 = 0
			local var_385_3 = 0.425

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_2 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_4 = arg_382_1:GetWordFromCfg(1107506092)
				local var_385_5 = arg_382_1:FormatText(var_385_4.content)

				arg_382_1.text_.text = var_385_5

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_7 = 17 <= 0 and var_385_3 or var_385_3 * (utf8.len(var_385_5) / 17)

				if (17 <= 0 and var_385_3 or var_385_3 * (utf8.len(var_385_5) / 17)) > 0 and var_385_3 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_2 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_2
					end
				end

				arg_382_1.text_.text = var_385_5
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506092", "story_v_side_new_1107506.awb") ~= 0 then
					local var_385_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506092", "story_v_side_new_1107506.awb") / 1000

					if var_385_8 + var_385_2 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_8 + var_385_2
					end

					if var_385_4.prefab_name ~= "" and arg_382_1.actors_[var_385_4.prefab_name] ~= nil then
						local var_385_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_4.prefab_name].transform, "story_v_side_new_1107506", "1107506092", "story_v_side_new_1107506.awb")

						arg_382_1:RecordAudio("1107506092", var_385_9)
						arg_382_1:RecordAudio("1107506092", var_385_9)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506092", "story_v_side_new_1107506.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506092", "story_v_side_new_1107506.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_10 = math.max(var_385_3, arg_382_1.talkMaxDuration)

			if var_385_2 <= arg_382_1.time_ and arg_382_1.time_ < var_385_2 + var_385_10 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_2) / var_385_10

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_2 + var_385_10 and arg_382_1.time_ < var_385_2 + var_385_10 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1107506093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1107506093
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1107506094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1075ui_actor"]) and arg_386_1.var_.characterEffect1075ui_actor == nil then
				arg_386_1.var_.characterEffect1075ui_actor = arg_386_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1075ui_actor"]) then
				if arg_386_1.var_.characterEffect1075ui_actor and not isNil(arg_386_1.actors_["1075ui_actor"]) then
					arg_386_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_386_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 0) / var_389_0)
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1075ui_actor"]) and arg_386_1.var_.characterEffect1075ui_actor then
				arg_386_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_386_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_389_1 = 0
			local var_389_2 = 0.825

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_3 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(1107506093).content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 33 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 33)

				if (33 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 33)) > 0 and var_389_2 < var_389_5 then
					arg_386_1.talkMaxDuration = var_389_5

					if var_389_5 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + var_389_1
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_6 = math.max(var_389_2, arg_386_1.talkMaxDuration)

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_6 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_1) / var_389_6

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_1 + var_389_6 and arg_386_1.time_ < var_389_1 + var_389_6 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1107506094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1107506094
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1107506095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.925

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_1 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(1107506094).content)

				arg_390_1.text_.text = var_393_1

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_3 = 37 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 37)

				if (37 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 37)) > 0 and var_393_0 < var_393_3 then
					arg_390_1.talkMaxDuration = var_393_3

					if var_393_3 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_3 + 0
					end
				end

				arg_390_1.text_.text = var_393_1
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_4 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_4

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1107506095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1107506095
		arg_394_1.duration_ = 4.9

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1107506096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1075ui_actor"]) and arg_394_1.var_.characterEffect1075ui_actor == nil then
				arg_394_1.var_.characterEffect1075ui_actor = arg_394_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1075ui_actor"]) then
				if arg_394_1.var_.characterEffect1075ui_actor and not isNil(arg_394_1.actors_["1075ui_actor"]) then
					arg_394_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1075ui_actor"]) and arg_394_1.var_.characterEffect1075ui_actor then
				arg_394_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_397_2 = 0
			local var_397_3 = 0.5

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_2 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_4 = arg_394_1:GetWordFromCfg(1107506095)
				local var_397_5 = arg_394_1:FormatText(var_397_4.content)

				arg_394_1.text_.text = var_397_5

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_7 = 20 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_5) / 20)

				if (20 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_5) / 20)) > 0 and var_397_3 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_2 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_2
					end
				end

				arg_394_1.text_.text = var_397_5
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506095", "story_v_side_new_1107506.awb") ~= 0 then
					local var_397_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506095", "story_v_side_new_1107506.awb") / 1000

					if var_397_8 + var_397_2 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_8 + var_397_2
					end

					if var_397_4.prefab_name ~= "" and arg_394_1.actors_[var_397_4.prefab_name] ~= nil then
						local var_397_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_4.prefab_name].transform, "story_v_side_new_1107506", "1107506095", "story_v_side_new_1107506.awb")

						arg_394_1:RecordAudio("1107506095", var_397_9)
						arg_394_1:RecordAudio("1107506095", var_397_9)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506095", "story_v_side_new_1107506.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506095", "story_v_side_new_1107506.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = math.max(var_397_3, arg_394_1.talkMaxDuration)

			if var_397_2 <= arg_394_1.time_ and arg_394_1.time_ < var_397_2 + var_397_10 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_2) / var_397_10

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_2 + var_397_10 and arg_394_1.time_ < var_397_2 + var_397_10 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1107506096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1107506096
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1107506097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1075ui_actor"]) and arg_398_1.var_.characterEffect1075ui_actor == nil then
				arg_398_1.var_.characterEffect1075ui_actor = arg_398_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_0 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1075ui_actor"]) then
				if arg_398_1.var_.characterEffect1075ui_actor and not isNil(arg_398_1.actors_["1075ui_actor"]) then
					arg_398_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_398_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_398_1.time_ - 0) / var_401_0)
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1075ui_actor"]) and arg_398_1.var_.characterEffect1075ui_actor then
				arg_398_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_398_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_401_1 = 0
			local var_401_2 = 0.55

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_3 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(1107506096).content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 22 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_3) / 22)

				if (22 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_3) / 22)) > 0 and var_401_2 < var_401_5 then
					arg_398_1.talkMaxDuration = var_401_5

					if var_401_5 + var_401_1 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + var_401_1
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_6 = math.max(var_401_2, arg_398_1.talkMaxDuration)

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_6 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_1) / var_401_6

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_1 + var_401_6 and arg_398_1.time_ < var_401_1 + var_401_6 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1107506097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1107506097
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1107506098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.55

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_1 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(1107506097).content)

				arg_402_1.text_.text = var_405_1

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_3 = 22 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 22)

				if (22 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 22)) > 0 and var_405_0 < var_405_3 then
					arg_402_1.talkMaxDuration = var_405_3

					if var_405_3 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_3 + 0
					end
				end

				arg_402_1.text_.text = var_405_1
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_4 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_4 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_4

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_4 and arg_402_1.time_ < 0 + var_405_4 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1107506098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1107506098
		arg_406_1.duration_ = 9

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1107506099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 2 < arg_406_1.time_ and arg_406_1.time_ <= 2 + arg_409_0 then
				local var_409_0 = arg_406_1.bgs_.ST37a

				arg_406_1.bgs_.ST37a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_409_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_409_1 = var_409_0:GetComponent("SpriteRenderer")

				if var_409_1 and var_409_1.sprite then
					local var_409_2 = 2 * (var_409_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_409_0.transform.localScale = Vector3.New(var_409_2 / var_409_1.sprite.bounds.size.y < var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x and var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x or var_409_2 / var_409_1.sprite.bounds.size.y, var_409_2 / var_409_1.sprite.bounds.size.y < var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x and var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x or var_409_2 / var_409_1.sprite.bounds.size.y, 0)
				end

				for iter_409_0, iter_409_1 in pairs(arg_406_1.bgs_) do
					if iter_409_0 ~= "ST37a" then
						iter_409_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_409_3 = 3.999999999999

			if 3.999999999999 < arg_406_1.time_ and arg_406_1.time_ <= var_409_3 + arg_409_0 then
				arg_406_1.allBtn_.enabled = false
			end

			if arg_406_1.time_ >= var_409_3 + 0.3 and arg_406_1.time_ < var_409_3 + 0.3 + arg_409_0 then
				arg_406_1.allBtn_.enabled = true
			end

			local var_409_4 = 0

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_5 = 2

			if var_409_4 <= arg_406_1.time_ and arg_406_1.time_ < var_409_4 + var_409_5 then
				local var_409_6 = Color.New(0, 0, 0)

				var_409_6.a = Mathf.Lerp(0, 1, (arg_406_1.time_ - var_409_4) / var_409_5)
				arg_406_1.mask_.color = var_409_6
			end

			if arg_406_1.time_ >= var_409_4 + var_409_5 and arg_406_1.time_ < var_409_4 + var_409_5 + arg_409_0 then
				local var_409_7 = Color.New(0, 0, 0)

				var_409_7.a = 1
				arg_406_1.mask_.color = var_409_7
			end

			local var_409_8 = 2

			if 2 < arg_406_1.time_ and arg_406_1.time_ <= var_409_8 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_9 = 2

			if var_409_8 <= arg_406_1.time_ and arg_406_1.time_ < var_409_8 + var_409_9 then
				local var_409_10 = Color.New(0, 0, 0)

				var_409_10.a = Mathf.Lerp(1, 0, (arg_406_1.time_ - var_409_8) / var_409_9)
				arg_406_1.mask_.color = var_409_10
			end

			if arg_406_1.time_ >= var_409_8 + var_409_9 and arg_406_1.time_ < var_409_8 + var_409_9 + arg_409_0 then
				local var_409_11 = Color.New(0, 0, 0)

				arg_406_1.mask_.enabled = false
				var_409_11.a = 0
				arg_406_1.mask_.color = var_409_11
			end

			local var_409_12 = arg_406_1.actors_["1075ui_actor"].transform

			if 1.96599999815226 < arg_406_1.time_ and arg_406_1.time_ <= 1.96599999815226 + arg_409_0 then
				arg_406_1.var_.moveOldPos1075ui_actor = var_409_12.localPosition

				local var_409_13 = GameObjectTools.GetOrAddComponent(var_409_12.gameObject, typeof(DynamicBoneHelper))

				if var_409_13 then
					var_409_13:EnableDynamicBone(false)
				end
			end

			local var_409_14 = 0.001

			if 1.96599999815226 <= arg_406_1.time_ and arg_406_1.time_ < 1.96599999815226 + var_409_14 then
				var_409_12.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_406_1.time_ - 1.96599999815226) / var_409_14)
				var_409_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_409_12.position).x, (manager.ui.mainCamera.transform.position - var_409_12.position).y, (manager.ui.mainCamera.transform.position - var_409_12.position).z)
				var_409_12.localEulerAngles.z = 0
				var_409_12.localEulerAngles.x = 0
				var_409_12.localEulerAngles = var_409_12.localEulerAngles
			end

			if arg_406_1.time_ >= 1.96599999815226 + var_409_14 and arg_406_1.time_ < 1.96599999815226 + var_409_14 + arg_409_0 then
				var_409_12.localPosition = Vector3.New(0, 100, 0)
				var_409_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_409_12.position).x, (manager.ui.mainCamera.transform.position - var_409_12.position).y, (manager.ui.mainCamera.transform.position - var_409_12.position).z)
				var_409_12.localEulerAngles.z = 0
				var_409_12.localEulerAngles.x = 0
				var_409_12.localEulerAngles = var_409_12.localEulerAngles

				local var_409_15 = GameObjectTools.GetOrAddComponent(var_409_12.gameObject, typeof(DynamicBoneHelper))

				if var_409_15 then
					var_409_15:EnableDynamicBone(true)
				end
			end

			if arg_406_1.frameCnt_ <= 1 then
				arg_406_1.dialog_:SetActive(false)
			end

			local var_409_16 = 4
			local var_409_17 = 0.6

			if 4 < arg_406_1.time_ and arg_406_1.time_ <= var_409_16 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0

				arg_406_1.dialog_:SetActive(true)

				arg_406_1.dialogCg_.alpha = 0

				local var_409_18 = LeanTween.value(arg_406_1.dialog_, 0, 1, 0.3)

				var_409_18:setOnUpdate(LuaHelper.FloatAction(function(arg_410_0)
					arg_406_1.dialogCg_.alpha = arg_410_0
				end))
				var_409_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_406_1.dialog_)
					var_409_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_406_1.duration_ = arg_406_1.duration_ + 0.3

				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_19 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(1107506098).content)

				arg_406_1.text_.text = var_409_19

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_21 = 24 <= 0 and var_409_17 or var_409_17 * (utf8.len(var_409_19) / 24)

				if (24 <= 0 and var_409_17 or var_409_17 * (utf8.len(var_409_19) / 24)) > 0 and var_409_17 < var_409_21 then
					arg_406_1.talkMaxDuration = var_409_21
					var_409_16 = var_409_16 + 0.3

					if var_409_21 + var_409_16 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_21 + var_409_16
					end
				end

				arg_406_1.text_.text = var_409_19
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_22 = var_409_16 + 0.3
			local var_409_23 = math.max(var_409_17, arg_406_1.talkMaxDuration)

			if var_409_16 + 0.3 <= arg_406_1.time_ and arg_406_1.time_ < var_409_22 + var_409_23 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_22) / var_409_23

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_22 + var_409_23 and arg_406_1.time_ < var_409_22 + var_409_23 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play1107506099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1107506099
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1107506100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 1.075

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_1 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(1107506099).content)

				arg_412_1.text_.text = var_415_1

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_3 = 43 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 43)

				if (43 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 43)) > 0 and var_415_0 < var_415_3 then
					arg_412_1.talkMaxDuration = var_415_3

					if var_415_3 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_3 + 0
					end
				end

				arg_412_1.text_.text = var_415_1
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_4 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_4 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_4

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_4 and arg_412_1.time_ < 0 + var_415_4 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1107506100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1107506100
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1107506101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.6

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(1107506100).content)

				arg_416_1.text_.text = var_419_1

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_3 = 24 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 24)

				if (24 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 24)) > 0 and var_419_0 < var_419_3 then
					arg_416_1.talkMaxDuration = var_419_3

					if var_419_3 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_3 + 0
					end
				end

				arg_416_1.text_.text = var_419_1
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_4 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_4

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1107506101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1107506101
		arg_420_1.duration_ = 7.33

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1107506102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos1075ui_actor = arg_420_1.actors_["1075ui_actor"].transform.localPosition

				local var_423_0 = GameObjectTools.GetOrAddComponent(arg_420_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_423_0 then
					var_423_0:EnableDynamicBone(false)
				end
			end

			local var_423_1 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_1 then
				arg_420_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_420_1.time_ - 0) / var_423_1)
				arg_420_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1075ui_actor"].transform.position).z)
				arg_420_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_420_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_1 and arg_420_1.time_ < 0 + var_423_1 + arg_423_0 then
				arg_420_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_420_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1075ui_actor"].transform.position).z)
				arg_420_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_420_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_423_2 = GameObjectTools.GetOrAddComponent(arg_420_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_423_2 then
					var_423_2:EnableDynamicBone(true)
				end
			end

			local var_423_3 = arg_420_1.actors_["1075ui_actor"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_3) and arg_420_1.var_.characterEffect1075ui_actor == nil then
				arg_420_1.var_.characterEffect1075ui_actor = var_423_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_4 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_4 and not isNil(var_423_3) then
				if arg_420_1.var_.characterEffect1075ui_actor and not isNil(var_423_3) then
					arg_420_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_4 and arg_420_1.time_ < 0 + var_423_4 + arg_423_0 and not isNil(var_423_3) and arg_420_1.var_.characterEffect1075ui_actor then
				arg_420_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_423_6 = 0
			local var_423_7 = 0.875

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_8 = arg_420_1:GetWordFromCfg(1107506101)
				local var_423_9 = arg_420_1:FormatText(var_423_8.content)

				arg_420_1.text_.text = var_423_9

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_11 = 35 <= 0 and var_423_7 or var_423_7 * (utf8.len(var_423_9) / 35)

				if (35 <= 0 and var_423_7 or var_423_7 * (utf8.len(var_423_9) / 35)) > 0 and var_423_7 < var_423_11 then
					arg_420_1.talkMaxDuration = var_423_11

					if var_423_11 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_11 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_9
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506101", "story_v_side_new_1107506.awb") ~= 0 then
					local var_423_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506101", "story_v_side_new_1107506.awb") / 1000

					if var_423_12 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_12 + var_423_6
					end

					if var_423_8.prefab_name ~= "" and arg_420_1.actors_[var_423_8.prefab_name] ~= nil then
						local var_423_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_8.prefab_name].transform, "story_v_side_new_1107506", "1107506101", "story_v_side_new_1107506.awb")

						arg_420_1:RecordAudio("1107506101", var_423_13)
						arg_420_1:RecordAudio("1107506101", var_423_13)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506101", "story_v_side_new_1107506.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506101", "story_v_side_new_1107506.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_14 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_14 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_14

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_14 and arg_420_1.time_ < var_423_6 + var_423_14 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play1107506102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1107506102
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1107506103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(arg_424_1.actors_["1075ui_actor"]) and arg_424_1.var_.characterEffect1075ui_actor == nil then
				arg_424_1.var_.characterEffect1075ui_actor = arg_424_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_0 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 and not isNil(arg_424_1.actors_["1075ui_actor"]) then
				if arg_424_1.var_.characterEffect1075ui_actor and not isNil(arg_424_1.actors_["1075ui_actor"]) then
					arg_424_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_424_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_0)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 and not isNil(arg_424_1.actors_["1075ui_actor"]) and arg_424_1.var_.characterEffect1075ui_actor then
				arg_424_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_424_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_427_1 = 0
			local var_427_2 = 0.75

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_3 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(1107506102).content)

				arg_424_1.text_.text = var_427_3

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 30 <= 0 and var_427_2 or var_427_2 * (utf8.len(var_427_3) / 30)

				if (30 <= 0 and var_427_2 or var_427_2 * (utf8.len(var_427_3) / 30)) > 0 and var_427_2 < var_427_5 then
					arg_424_1.talkMaxDuration = var_427_5

					if var_427_5 + var_427_1 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_5 + var_427_1
					end
				end

				arg_424_1.text_.text = var_427_3
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_6 = math.max(var_427_2, arg_424_1.talkMaxDuration)

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_6 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_1) / var_427_6

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_1 + var_427_6 and arg_424_1.time_ < var_427_1 + var_427_6 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1107506103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1107506103
		arg_428_1.duration_ = 7.53

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1107506104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(arg_428_1.actors_["1075ui_actor"]) and arg_428_1.var_.characterEffect1075ui_actor == nil then
				arg_428_1.var_.characterEffect1075ui_actor = arg_428_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_0 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 and not isNil(arg_428_1.actors_["1075ui_actor"]) then
				if arg_428_1.var_.characterEffect1075ui_actor and not isNil(arg_428_1.actors_["1075ui_actor"]) then
					arg_428_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 and not isNil(arg_428_1.actors_["1075ui_actor"]) and arg_428_1.var_.characterEffect1075ui_actor then
				arg_428_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_431_2 = 0
			local var_431_3 = 0.8

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_2 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_4 = arg_428_1:GetWordFromCfg(1107506103)
				local var_431_5 = arg_428_1:FormatText(var_431_4.content)

				arg_428_1.text_.text = var_431_5

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_7 = 32 <= 0 and var_431_3 or var_431_3 * (utf8.len(var_431_5) / 32)

				if (32 <= 0 and var_431_3 or var_431_3 * (utf8.len(var_431_5) / 32)) > 0 and var_431_3 < var_431_7 then
					arg_428_1.talkMaxDuration = var_431_7

					if var_431_7 + var_431_2 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_2
					end
				end

				arg_428_1.text_.text = var_431_5
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506103", "story_v_side_new_1107506.awb") ~= 0 then
					local var_431_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506103", "story_v_side_new_1107506.awb") / 1000

					if var_431_8 + var_431_2 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_8 + var_431_2
					end

					if var_431_4.prefab_name ~= "" and arg_428_1.actors_[var_431_4.prefab_name] ~= nil then
						local var_431_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_4.prefab_name].transform, "story_v_side_new_1107506", "1107506103", "story_v_side_new_1107506.awb")

						arg_428_1:RecordAudio("1107506103", var_431_9)
						arg_428_1:RecordAudio("1107506103", var_431_9)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506103", "story_v_side_new_1107506.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506103", "story_v_side_new_1107506.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_10 = math.max(var_431_3, arg_428_1.talkMaxDuration)

			if var_431_2 <= arg_428_1.time_ and arg_428_1.time_ < var_431_2 + var_431_10 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_2) / var_431_10

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_2 + var_431_10 and arg_428_1.time_ < var_431_2 + var_431_10 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1107506104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1107506104
		arg_432_1.duration_ = 1

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"

			SetActive(arg_432_1.choicesGo_, true)

			for iter_433_0, iter_433_1 in ipairs(arg_432_1.choices_) do
				SetActive(iter_433_1.go, iter_433_0 <= 1)
			end

			arg_432_1.choices_[1].txt.text = arg_432_1:FormatText(StoryChoiceCfg[1170].name)
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1107506105(arg_432_1)
			end

			arg_432_1:RecordChoiceLog(1107506104, 1170)
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["1075ui_actor"]) and arg_432_1.var_.characterEffect1075ui_actor == nil then
				arg_432_1.var_.characterEffect1075ui_actor = arg_432_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["1075ui_actor"]) then
				if arg_432_1.var_.characterEffect1075ui_actor and not isNil(arg_432_1.actors_["1075ui_actor"]) then
					arg_432_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_432_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_432_1.time_ - 0) / var_435_0)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["1075ui_actor"]) and arg_432_1.var_.characterEffect1075ui_actor then
				arg_432_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_432_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_435_1 = 0

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.allBtn_.enabled = false
			end

			if arg_432_1.time_ >= var_435_1 + 0.5 and arg_432_1.time_ < var_435_1 + 0.5 + arg_435_0 then
				arg_432_1.allBtn_.enabled = true
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1107506105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1107506105
		arg_436_1.duration_ = 2

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1107506106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(arg_436_1.actors_["1075ui_actor"]) and arg_436_1.var_.characterEffect1075ui_actor == nil then
				arg_436_1.var_.characterEffect1075ui_actor = arg_436_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_0 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 and not isNil(arg_436_1.actors_["1075ui_actor"]) then
				if arg_436_1.var_.characterEffect1075ui_actor and not isNil(arg_436_1.actors_["1075ui_actor"]) then
					arg_436_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 and not isNil(arg_436_1.actors_["1075ui_actor"]) and arg_436_1.var_.characterEffect1075ui_actor then
				arg_436_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action424")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_439_2 = 0
			local var_439_3 = 0.125

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_2 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_4 = arg_436_1:GetWordFromCfg(1107506105)
				local var_439_5 = arg_436_1:FormatText(var_439_4.content)

				arg_436_1.text_.text = var_439_5

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_7 = 5 <= 0 and var_439_3 or var_439_3 * (utf8.len(var_439_5) / 5)

				if (5 <= 0 and var_439_3 or var_439_3 * (utf8.len(var_439_5) / 5)) > 0 and var_439_3 < var_439_7 then
					arg_436_1.talkMaxDuration = var_439_7

					if var_439_7 + var_439_2 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_7 + var_439_2
					end
				end

				arg_436_1.text_.text = var_439_5
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506105", "story_v_side_new_1107506.awb") ~= 0 then
					local var_439_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506105", "story_v_side_new_1107506.awb") / 1000

					if var_439_8 + var_439_2 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_8 + var_439_2
					end

					if var_439_4.prefab_name ~= "" and arg_436_1.actors_[var_439_4.prefab_name] ~= nil then
						local var_439_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_4.prefab_name].transform, "story_v_side_new_1107506", "1107506105", "story_v_side_new_1107506.awb")

						arg_436_1:RecordAudio("1107506105", var_439_9)
						arg_436_1:RecordAudio("1107506105", var_439_9)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506105", "story_v_side_new_1107506.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506105", "story_v_side_new_1107506.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_10 = math.max(var_439_3, arg_436_1.talkMaxDuration)

			if var_439_2 <= arg_436_1.time_ and arg_436_1.time_ < var_439_2 + var_439_10 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_2) / var_439_10

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_2 + var_439_10 and arg_436_1.time_ < var_439_2 + var_439_10 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1107506106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1107506106
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1107506107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos1075ui_actor = arg_440_1.actors_["1075ui_actor"].transform.localPosition

				local var_443_0 = GameObjectTools.GetOrAddComponent(arg_440_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_443_0 then
					var_443_0:EnableDynamicBone(false)
				end
			end

			local var_443_1 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_1 then
				arg_440_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_440_1.time_ - 0) / var_443_1)
				arg_440_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1075ui_actor"].transform.position).z)
				arg_440_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_440_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_1 and arg_440_1.time_ < 0 + var_443_1 + arg_443_0 then
				arg_440_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_440_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1075ui_actor"].transform.position).z)
				arg_440_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_440_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_443_2 = GameObjectTools.GetOrAddComponent(arg_440_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_443_2 then
					var_443_2:EnableDynamicBone(true)
				end
			end

			local var_443_3 = arg_440_1.actors_["1075ui_actor"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_3) and arg_440_1.var_.characterEffect1075ui_actor == nil then
				arg_440_1.var_.characterEffect1075ui_actor = var_443_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_4 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_4 and not isNil(var_443_3) then
				if arg_440_1.var_.characterEffect1075ui_actor and not isNil(var_443_3) then
					arg_440_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_440_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_440_1.time_ - 0) / var_443_4)
				end
			end

			if arg_440_1.time_ >= 0 + var_443_4 and arg_440_1.time_ < 0 + var_443_4 + arg_443_0 and not isNil(var_443_3) and arg_440_1.var_.characterEffect1075ui_actor then
				arg_440_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_440_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_443_5 = 0
			local var_443_6 = 0.85

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_5 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, false)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_7 = arg_440_1:FormatText(arg_440_1:GetWordFromCfg(1107506106).content)

				arg_440_1.text_.text = var_443_7

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_9 = 34 <= 0 and var_443_6 or var_443_6 * (utf8.len(var_443_7) / 34)

				if (34 <= 0 and var_443_6 or var_443_6 * (utf8.len(var_443_7) / 34)) > 0 and var_443_6 < var_443_9 then
					arg_440_1.talkMaxDuration = var_443_9

					if var_443_9 + var_443_5 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_9 + var_443_5
					end
				end

				arg_440_1.text_.text = var_443_7
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_10 = math.max(var_443_6, arg_440_1.talkMaxDuration)

			if var_443_5 <= arg_440_1.time_ and arg_440_1.time_ < var_443_5 + var_443_10 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_5) / var_443_10

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_5 + var_443_10 and arg_440_1.time_ < var_443_5 + var_443_10 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play1107506107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1107506107
		arg_444_1.duration_ = 4.5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1107506108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos1075ui_actor = arg_444_1.actors_["1075ui_actor"].transform.localPosition

				local var_447_0 = GameObjectTools.GetOrAddComponent(arg_444_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_447_0 then
					var_447_0:EnableDynamicBone(false)
				end
			end

			local var_447_1 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_1 then
				arg_444_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_444_1.time_ - 0) / var_447_1)
				arg_444_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1075ui_actor"].transform.position).z)
				arg_444_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_444_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_444_1.time_ >= 0 + var_447_1 and arg_444_1.time_ < 0 + var_447_1 + arg_447_0 then
				arg_444_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_444_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1075ui_actor"].transform.position).z)
				arg_444_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_444_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_447_2 = GameObjectTools.GetOrAddComponent(arg_444_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_447_2 then
					var_447_2:EnableDynamicBone(true)
				end
			end

			local var_447_3 = arg_444_1.actors_["1075ui_actor"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_3) and arg_444_1.var_.characterEffect1075ui_actor == nil then
				arg_444_1.var_.characterEffect1075ui_actor = var_447_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_4 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_4 and not isNil(var_447_3) then
				if arg_444_1.var_.characterEffect1075ui_actor and not isNil(var_447_3) then
					arg_444_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_444_1.time_ >= 0 + var_447_4 and arg_444_1.time_ < 0 + var_447_4 + arg_447_0 and not isNil(var_447_3) and arg_444_1.var_.characterEffect1075ui_actor then
				arg_444_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action443")
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_447_6 = 0
			local var_447_7 = 0.45

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_6 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_8 = arg_444_1:GetWordFromCfg(1107506107)
				local var_447_9 = arg_444_1:FormatText(var_447_8.content)

				arg_444_1.text_.text = var_447_9

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_11 = 18 <= 0 and var_447_7 or var_447_7 * (utf8.len(var_447_9) / 18)

				if (18 <= 0 and var_447_7 or var_447_7 * (utf8.len(var_447_9) / 18)) > 0 and var_447_7 < var_447_11 then
					arg_444_1.talkMaxDuration = var_447_11

					if var_447_11 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_11 + var_447_6
					end
				end

				arg_444_1.text_.text = var_447_9
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506107", "story_v_side_new_1107506.awb") ~= 0 then
					local var_447_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506107", "story_v_side_new_1107506.awb") / 1000

					if var_447_12 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_12 + var_447_6
					end

					if var_447_8.prefab_name ~= "" and arg_444_1.actors_[var_447_8.prefab_name] ~= nil then
						local var_447_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_8.prefab_name].transform, "story_v_side_new_1107506", "1107506107", "story_v_side_new_1107506.awb")

						arg_444_1:RecordAudio("1107506107", var_447_13)
						arg_444_1:RecordAudio("1107506107", var_447_13)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506107", "story_v_side_new_1107506.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506107", "story_v_side_new_1107506.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_14 = math.max(var_447_7, arg_444_1.talkMaxDuration)

			if var_447_6 <= arg_444_1.time_ and arg_444_1.time_ < var_447_6 + var_447_14 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_6) / var_447_14

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_6 + var_447_14 and arg_444_1.time_ < var_447_6 + var_447_14 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play1107506108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1107506108
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1107506109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["1075ui_actor"]) and arg_448_1.var_.characterEffect1075ui_actor == nil then
				arg_448_1.var_.characterEffect1075ui_actor = arg_448_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_0 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["1075ui_actor"]) then
				if arg_448_1.var_.characterEffect1075ui_actor and not isNil(arg_448_1.actors_["1075ui_actor"]) then
					arg_448_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_448_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_448_1.time_ - 0) / var_451_0)
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["1075ui_actor"]) and arg_448_1.var_.characterEffect1075ui_actor then
				arg_448_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_448_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_451_1 = 0
			local var_451_2 = 0.325

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_3 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(1107506108).content)

				arg_448_1.text_.text = var_451_3

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 13 <= 0 and var_451_2 or var_451_2 * (utf8.len(var_451_3) / 13)

				if (13 <= 0 and var_451_2 or var_451_2 * (utf8.len(var_451_3) / 13)) > 0 and var_451_2 < var_451_5 then
					arg_448_1.talkMaxDuration = var_451_5

					if var_451_5 + var_451_1 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + var_451_1
					end
				end

				arg_448_1.text_.text = var_451_3
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_6 = math.max(var_451_2, arg_448_1.talkMaxDuration)

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_6 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_1) / var_451_6

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_1 + var_451_6 and arg_448_1.time_ < var_451_1 + var_451_6 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1107506109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1107506109
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1107506110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos1075ui_actor = arg_452_1.actors_["1075ui_actor"].transform.localPosition

				local var_455_0 = GameObjectTools.GetOrAddComponent(arg_452_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_455_0 then
					var_455_0:EnableDynamicBone(false)
				end
			end

			local var_455_1 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_1 then
				arg_452_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_452_1.time_ - 0) / var_455_1)
				arg_452_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1075ui_actor"].transform.position).z)
				arg_452_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_452_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_1 and arg_452_1.time_ < 0 + var_455_1 + arg_455_0 then
				arg_452_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_452_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1075ui_actor"].transform.position).z)
				arg_452_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_452_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_455_2 = GameObjectTools.GetOrAddComponent(arg_452_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_455_2 then
					var_455_2:EnableDynamicBone(true)
				end
			end

			local var_455_3 = 0
			local var_455_4 = 0.6

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_3 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_5 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(1107506109).content)

				arg_452_1.text_.text = var_455_5

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_7 = 24 <= 0 and var_455_4 or var_455_4 * (utf8.len(var_455_5) / 24)

				if (24 <= 0 and var_455_4 or var_455_4 * (utf8.len(var_455_5) / 24)) > 0 and var_455_4 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_3 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_3
					end
				end

				arg_452_1.text_.text = var_455_5
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_8 = math.max(var_455_4, arg_452_1.talkMaxDuration)

			if var_455_3 <= arg_452_1.time_ and arg_452_1.time_ < var_455_3 + var_455_8 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_3) / var_455_8

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_3 + var_455_8 and arg_452_1.time_ < var_455_3 + var_455_8 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play1107506110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1107506110
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1107506111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0.625

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_1 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(1107506110).content)

				arg_456_1.text_.text = var_459_1

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_3 = 25 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_1) / 25)

				if (25 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_1) / 25)) > 0 and var_459_0 < var_459_3 then
					arg_456_1.talkMaxDuration = var_459_3

					if var_459_3 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_3 + 0
					end
				end

				arg_456_1.text_.text = var_459_1
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_4 = math.max(var_459_0, arg_456_1.talkMaxDuration)

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - 0) / var_459_4

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1107506111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1107506111
		arg_460_1.duration_ = 2.6

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1107506112(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos1075ui_actor = arg_460_1.actors_["1075ui_actor"].transform.localPosition

				local var_463_0 = GameObjectTools.GetOrAddComponent(arg_460_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_463_0 then
					var_463_0:EnableDynamicBone(false)
				end
			end

			local var_463_1 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_1 then
				arg_460_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_460_1.time_ - 0) / var_463_1)
				arg_460_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1075ui_actor"].transform.position).z)
				arg_460_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_460_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_460_1.time_ >= 0 + var_463_1 and arg_460_1.time_ < 0 + var_463_1 + arg_463_0 then
				arg_460_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_460_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1075ui_actor"].transform.position).z)
				arg_460_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_460_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_463_2 = GameObjectTools.GetOrAddComponent(arg_460_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_463_2 then
					var_463_2:EnableDynamicBone(true)
				end
			end

			local var_463_3 = arg_460_1.actors_["1075ui_actor"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_3) and arg_460_1.var_.characterEffect1075ui_actor == nil then
				arg_460_1.var_.characterEffect1075ui_actor = var_463_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_4 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_4 and not isNil(var_463_3) then
				if arg_460_1.var_.characterEffect1075ui_actor and not isNil(var_463_3) then
					arg_460_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_460_1.time_ >= 0 + var_463_4 and arg_460_1.time_ < 0 + var_463_4 + arg_463_0 and not isNil(var_463_3) and arg_460_1.var_.characterEffect1075ui_actor then
				arg_460_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_463_6 = 0
			local var_463_7 = 0.225

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_6 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_8 = arg_460_1:GetWordFromCfg(1107506111)
				local var_463_9 = arg_460_1:FormatText(var_463_8.content)

				arg_460_1.text_.text = var_463_9

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_11 = 9 <= 0 and var_463_7 or var_463_7 * (utf8.len(var_463_9) / 9)

				if (9 <= 0 and var_463_7 or var_463_7 * (utf8.len(var_463_9) / 9)) > 0 and var_463_7 < var_463_11 then
					arg_460_1.talkMaxDuration = var_463_11

					if var_463_11 + var_463_6 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_11 + var_463_6
					end
				end

				arg_460_1.text_.text = var_463_9
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506111", "story_v_side_new_1107506.awb") ~= 0 then
					local var_463_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506111", "story_v_side_new_1107506.awb") / 1000

					if var_463_12 + var_463_6 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_12 + var_463_6
					end

					if var_463_8.prefab_name ~= "" and arg_460_1.actors_[var_463_8.prefab_name] ~= nil then
						local var_463_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_8.prefab_name].transform, "story_v_side_new_1107506", "1107506111", "story_v_side_new_1107506.awb")

						arg_460_1:RecordAudio("1107506111", var_463_13)
						arg_460_1:RecordAudio("1107506111", var_463_13)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506111", "story_v_side_new_1107506.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506111", "story_v_side_new_1107506.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_14 = math.max(var_463_7, arg_460_1.talkMaxDuration)

			if var_463_6 <= arg_460_1.time_ and arg_460_1.time_ < var_463_6 + var_463_14 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_6) / var_463_14

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_6 + var_463_14 and arg_460_1.time_ < var_463_6 + var_463_14 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play1107506112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1107506112
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1107506113(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["1075ui_actor"]) and arg_464_1.var_.characterEffect1075ui_actor == nil then
				arg_464_1.var_.characterEffect1075ui_actor = arg_464_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_0 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["1075ui_actor"]) then
				if arg_464_1.var_.characterEffect1075ui_actor and not isNil(arg_464_1.actors_["1075ui_actor"]) then
					arg_464_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_464_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_464_1.time_ - 0) / var_467_0)
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["1075ui_actor"]) and arg_464_1.var_.characterEffect1075ui_actor then
				arg_464_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_464_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_467_1 = 0
			local var_467_2 = 0.225

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_3 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(1107506112).content)

				arg_464_1.text_.text = var_467_3

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 9 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 9)

				if (9 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 9)) > 0 and var_467_2 < var_467_5 then
					arg_464_1.talkMaxDuration = var_467_5

					if var_467_5 + var_467_1 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_5 + var_467_1
					end
				end

				arg_464_1.text_.text = var_467_3
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_6 = math.max(var_467_2, arg_464_1.talkMaxDuration)

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_6 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_1) / var_467_6

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_1 + var_467_6 and arg_464_1.time_ < var_467_1 + var_467_6 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1107506113 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1107506113
		arg_468_1.duration_ = 8.6

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1107506114(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(arg_468_1.actors_["1075ui_actor"]) and arg_468_1.var_.characterEffect1075ui_actor == nil then
				arg_468_1.var_.characterEffect1075ui_actor = arg_468_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_0 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 and not isNil(arg_468_1.actors_["1075ui_actor"]) then
				if arg_468_1.var_.characterEffect1075ui_actor and not isNil(arg_468_1.actors_["1075ui_actor"]) then
					arg_468_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 and not isNil(arg_468_1.actors_["1075ui_actor"]) and arg_468_1.var_.characterEffect1075ui_actor then
				arg_468_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_471_2 = 0
			local var_471_3 = 0.95

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_2 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_4 = arg_468_1:GetWordFromCfg(1107506113)
				local var_471_5 = arg_468_1:FormatText(var_471_4.content)

				arg_468_1.text_.text = var_471_5

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_7 = 38 <= 0 and var_471_3 or var_471_3 * (utf8.len(var_471_5) / 38)

				if (38 <= 0 and var_471_3 or var_471_3 * (utf8.len(var_471_5) / 38)) > 0 and var_471_3 < var_471_7 then
					arg_468_1.talkMaxDuration = var_471_7

					if var_471_7 + var_471_2 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_7 + var_471_2
					end
				end

				arg_468_1.text_.text = var_471_5
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506113", "story_v_side_new_1107506.awb") ~= 0 then
					local var_471_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506113", "story_v_side_new_1107506.awb") / 1000

					if var_471_8 + var_471_2 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_8 + var_471_2
					end

					if var_471_4.prefab_name ~= "" and arg_468_1.actors_[var_471_4.prefab_name] ~= nil then
						local var_471_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_4.prefab_name].transform, "story_v_side_new_1107506", "1107506113", "story_v_side_new_1107506.awb")

						arg_468_1:RecordAudio("1107506113", var_471_9)
						arg_468_1:RecordAudio("1107506113", var_471_9)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506113", "story_v_side_new_1107506.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506113", "story_v_side_new_1107506.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_10 = math.max(var_471_3, arg_468_1.talkMaxDuration)

			if var_471_2 <= arg_468_1.time_ and arg_468_1.time_ < var_471_2 + var_471_10 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_2) / var_471_10

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_2 + var_471_10 and arg_468_1.time_ < var_471_2 + var_471_10 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1107506114 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1107506114
		arg_472_1.duration_ = 5.73

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1107506115(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0.575

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_1 = arg_472_1:GetWordFromCfg(1107506114)
				local var_475_2 = arg_472_1:FormatText(var_475_1.content)

				arg_472_1.text_.text = var_475_2

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_4 = 23 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_2) / 23)

				if (23 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_2) / 23)) > 0 and var_475_0 < var_475_4 then
					arg_472_1.talkMaxDuration = var_475_4

					if var_475_4 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_4 + 0
					end
				end

				arg_472_1.text_.text = var_475_2
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506114", "story_v_side_new_1107506.awb") ~= 0 then
					local var_475_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506114", "story_v_side_new_1107506.awb") / 1000

					if var_475_5 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_5 + 0
					end

					if var_475_1.prefab_name ~= "" and arg_472_1.actors_[var_475_1.prefab_name] ~= nil then
						local var_475_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_1.prefab_name].transform, "story_v_side_new_1107506", "1107506114", "story_v_side_new_1107506.awb")

						arg_472_1:RecordAudio("1107506114", var_475_6)
						arg_472_1:RecordAudio("1107506114", var_475_6)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506114", "story_v_side_new_1107506.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506114", "story_v_side_new_1107506.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_7 = math.max(var_475_0, arg_472_1.talkMaxDuration)

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_7 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - 0) / var_475_7

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= 0 + var_475_7 and arg_472_1.time_ < 0 + var_475_7 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play1107506115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1107506115
		arg_476_1.duration_ = 5.47

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1107506116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_479_0 = 0
			local var_479_1 = 0.6

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_2 = arg_476_1:GetWordFromCfg(1107506115)
				local var_479_3 = arg_476_1:FormatText(var_479_2.content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 24 <= 0 and var_479_1 or var_479_1 * (utf8.len(var_479_3) / 24)

				if (24 <= 0 and var_479_1 or var_479_1 * (utf8.len(var_479_3) / 24)) > 0 and var_479_1 < var_479_5 then
					arg_476_1.talkMaxDuration = var_479_5

					if var_479_5 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506115", "story_v_side_new_1107506.awb") ~= 0 then
					local var_479_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506115", "story_v_side_new_1107506.awb") / 1000

					if var_479_6 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_6 + var_479_0
					end

					if var_479_2.prefab_name ~= "" and arg_476_1.actors_[var_479_2.prefab_name] ~= nil then
						local var_479_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_2.prefab_name].transform, "story_v_side_new_1107506", "1107506115", "story_v_side_new_1107506.awb")

						arg_476_1:RecordAudio("1107506115", var_479_7)
						arg_476_1:RecordAudio("1107506115", var_479_7)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506115", "story_v_side_new_1107506.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506115", "story_v_side_new_1107506.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_8 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_8 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_8

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_8 and arg_476_1.time_ < var_479_0 + var_479_8 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1107506116 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1107506116
		arg_480_1.duration_ = 1

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"

			SetActive(arg_480_1.choicesGo_, true)

			for iter_481_0, iter_481_1 in ipairs(arg_480_1.choices_) do
				SetActive(iter_481_1.go, iter_481_0 <= 2)
			end

			arg_480_1.choices_[1].txt.text = arg_480_1:FormatText(StoryChoiceCfg[1171].name)
			arg_480_1.choices_[2].txt.text = arg_480_1:FormatText(StoryChoiceCfg[1172].name)
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1107506117(arg_480_1)
			end

			if arg_482_0 == 2 then
				arg_480_0:Play1107506118(arg_480_1)
			end

			arg_480_1:RecordChoiceLog(1107506116, 1171, 1172)
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(arg_480_1.actors_["1075ui_actor"]) and arg_480_1.var_.characterEffect1075ui_actor == nil then
				arg_480_1.var_.characterEffect1075ui_actor = arg_480_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_0 = 0.200000002980232

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 and not isNil(arg_480_1.actors_["1075ui_actor"]) then
				if arg_480_1.var_.characterEffect1075ui_actor and not isNil(arg_480_1.actors_["1075ui_actor"]) then
					arg_480_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_480_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_480_1.time_ - 0) / var_483_0)
				end
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 and not isNil(arg_480_1.actors_["1075ui_actor"]) and arg_480_1.var_.characterEffect1075ui_actor then
				arg_480_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_480_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_483_1 = 0

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.allBtn_.enabled = false
			end

			if arg_480_1.time_ >= var_483_1 + 0.6 and arg_480_1.time_ < var_483_1 + 0.6 + arg_483_0 then
				arg_480_1.allBtn_.enabled = true
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play1107506117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1107506117
		arg_484_1.duration_ = 3.23

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1107506119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(arg_484_1.actors_["1075ui_actor"]) and arg_484_1.var_.characterEffect1075ui_actor == nil then
				arg_484_1.var_.characterEffect1075ui_actor = arg_484_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_0 = 0.200000002980232

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_0 and not isNil(arg_484_1.actors_["1075ui_actor"]) then
				if arg_484_1.var_.characterEffect1075ui_actor and not isNil(arg_484_1.actors_["1075ui_actor"]) then
					arg_484_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_484_1.time_ >= 0 + var_487_0 and arg_484_1.time_ < 0 + var_487_0 + arg_487_0 and not isNil(arg_484_1.actors_["1075ui_actor"]) and arg_484_1.var_.characterEffect1075ui_actor then
				arg_484_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_487_2 = 0
			local var_487_3 = 0.375

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_2 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_4 = arg_484_1:GetWordFromCfg(1107506117)
				local var_487_5 = arg_484_1:FormatText(var_487_4.content)

				arg_484_1.text_.text = var_487_5

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_7 = 15 <= 0 and var_487_3 or var_487_3 * (utf8.len(var_487_5) / 15)

				if (15 <= 0 and var_487_3 or var_487_3 * (utf8.len(var_487_5) / 15)) > 0 and var_487_3 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_2 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_2
					end
				end

				arg_484_1.text_.text = var_487_5
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506117", "story_v_side_new_1107506.awb") ~= 0 then
					local var_487_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506117", "story_v_side_new_1107506.awb") / 1000

					if var_487_8 + var_487_2 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_2
					end

					if var_487_4.prefab_name ~= "" and arg_484_1.actors_[var_487_4.prefab_name] ~= nil then
						local var_487_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_4.prefab_name].transform, "story_v_side_new_1107506", "1107506117", "story_v_side_new_1107506.awb")

						arg_484_1:RecordAudio("1107506117", var_487_9)
						arg_484_1:RecordAudio("1107506117", var_487_9)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506117", "story_v_side_new_1107506.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506117", "story_v_side_new_1107506.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_10 = math.max(var_487_3, arg_484_1.talkMaxDuration)

			if var_487_2 <= arg_484_1.time_ and arg_484_1.time_ < var_487_2 + var_487_10 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_2) / var_487_10

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_2 + var_487_10 and arg_484_1.time_ < var_487_2 + var_487_10 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1107506119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1107506119
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1107506120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["1075ui_actor"]) and arg_488_1.var_.characterEffect1075ui_actor == nil then
				arg_488_1.var_.characterEffect1075ui_actor = arg_488_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_0 = 0.200000002980232

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["1075ui_actor"]) then
				if arg_488_1.var_.characterEffect1075ui_actor and not isNil(arg_488_1.actors_["1075ui_actor"]) then
					arg_488_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_488_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_488_1.time_ - 0) / var_491_0)
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["1075ui_actor"]) and arg_488_1.var_.characterEffect1075ui_actor then
				arg_488_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_488_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_491_1 = 0
			local var_491_2 = 0.475

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_3 = arg_488_1:FormatText(arg_488_1:GetWordFromCfg(1107506119).content)

				arg_488_1.text_.text = var_491_3

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 19 <= 0 and var_491_2 or var_491_2 * (utf8.len(var_491_3) / 19)

				if (19 <= 0 and var_491_2 or var_491_2 * (utf8.len(var_491_3) / 19)) > 0 and var_491_2 < var_491_5 then
					arg_488_1.talkMaxDuration = var_491_5

					if var_491_5 + var_491_1 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_5 + var_491_1
					end
				end

				arg_488_1.text_.text = var_491_3
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_6 = math.max(var_491_2, arg_488_1.talkMaxDuration)

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_6 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_1) / var_491_6

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_1 + var_491_6 and arg_488_1.time_ < var_491_1 + var_491_6 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play1107506120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1107506120
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1107506121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos1075ui_actor = arg_492_1.actors_["1075ui_actor"].transform.localPosition

				local var_495_0 = GameObjectTools.GetOrAddComponent(arg_492_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_495_0 then
					var_495_0:EnableDynamicBone(false)
				end
			end

			local var_495_1 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_1 then
				arg_492_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_492_1.time_ - 0) / var_495_1)
				arg_492_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1075ui_actor"].transform.position).z)
				arg_492_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_492_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_492_1.time_ >= 0 + var_495_1 and arg_492_1.time_ < 0 + var_495_1 + arg_495_0 then
				arg_492_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_492_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1075ui_actor"].transform.position).z)
				arg_492_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_492_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_495_2 = GameObjectTools.GetOrAddComponent(arg_492_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_495_2 then
					var_495_2:EnableDynamicBone(true)
				end
			end

			local var_495_3 = 0
			local var_495_4 = 0.675

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_3 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, false)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_5 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(1107506120).content)

				arg_492_1.text_.text = var_495_5

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_7 = 27 <= 0 and var_495_4 or var_495_4 * (utf8.len(var_495_5) / 27)

				if (27 <= 0 and var_495_4 or var_495_4 * (utf8.len(var_495_5) / 27)) > 0 and var_495_4 < var_495_7 then
					arg_492_1.talkMaxDuration = var_495_7

					if var_495_7 + var_495_3 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_7 + var_495_3
					end
				end

				arg_492_1.text_.text = var_495_5
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_8 = math.max(var_495_4, arg_492_1.talkMaxDuration)

			if var_495_3 <= arg_492_1.time_ and arg_492_1.time_ < var_495_3 + var_495_8 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_3) / var_495_8

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_3 + var_495_8 and arg_492_1.time_ < var_495_3 + var_495_8 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play1107506121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1107506121
		arg_496_1.duration_ = 3.17

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1107506122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos1075ui_actor = arg_496_1.actors_["1075ui_actor"].transform.localPosition

				local var_499_0 = GameObjectTools.GetOrAddComponent(arg_496_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_499_0 then
					var_499_0:EnableDynamicBone(false)
				end
			end

			local var_499_1 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_1 then
				arg_496_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_496_1.time_ - 0) / var_499_1)
				arg_496_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_496_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1075ui_actor"].transform.position).z)
				arg_496_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_496_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_496_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_496_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_496_1.time_ >= 0 + var_499_1 and arg_496_1.time_ < 0 + var_499_1 + arg_499_0 then
				arg_496_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_496_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_496_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1075ui_actor"].transform.position).z)
				arg_496_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_496_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_496_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_496_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_499_2 = GameObjectTools.GetOrAddComponent(arg_496_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_499_2 then
					var_499_2:EnableDynamicBone(true)
				end
			end

			local var_499_3 = arg_496_1.actors_["1075ui_actor"]

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(var_499_3) and arg_496_1.var_.characterEffect1075ui_actor == nil then
				arg_496_1.var_.characterEffect1075ui_actor = var_499_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_4 = 0.200000002980232

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_4 and not isNil(var_499_3) then
				if arg_496_1.var_.characterEffect1075ui_actor and not isNil(var_499_3) then
					arg_496_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_496_1.time_ >= 0 + var_499_4 and arg_496_1.time_ < 0 + var_499_4 + arg_499_0 and not isNil(var_499_3) and arg_496_1.var_.characterEffect1075ui_actor then
				arg_496_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_499_6 = 0
			local var_499_7 = 0.275

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_6 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_8 = arg_496_1:GetWordFromCfg(1107506121)
				local var_499_9 = arg_496_1:FormatText(var_499_8.content)

				arg_496_1.text_.text = var_499_9

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_11 = 11 <= 0 and var_499_7 or var_499_7 * (utf8.len(var_499_9) / 11)

				if (11 <= 0 and var_499_7 or var_499_7 * (utf8.len(var_499_9) / 11)) > 0 and var_499_7 < var_499_11 then
					arg_496_1.talkMaxDuration = var_499_11

					if var_499_11 + var_499_6 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_11 + var_499_6
					end
				end

				arg_496_1.text_.text = var_499_9
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506121", "story_v_side_new_1107506.awb") ~= 0 then
					local var_499_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506121", "story_v_side_new_1107506.awb") / 1000

					if var_499_12 + var_499_6 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_12 + var_499_6
					end

					if var_499_8.prefab_name ~= "" and arg_496_1.actors_[var_499_8.prefab_name] ~= nil then
						local var_499_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_8.prefab_name].transform, "story_v_side_new_1107506", "1107506121", "story_v_side_new_1107506.awb")

						arg_496_1:RecordAudio("1107506121", var_499_13)
						arg_496_1:RecordAudio("1107506121", var_499_13)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506121", "story_v_side_new_1107506.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506121", "story_v_side_new_1107506.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_14 = math.max(var_499_7, arg_496_1.talkMaxDuration)

			if var_499_6 <= arg_496_1.time_ and arg_496_1.time_ < var_499_6 + var_499_14 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_6) / var_499_14

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_6 + var_499_14 and arg_496_1.time_ < var_499_6 + var_499_14 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play1107506122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1107506122
		arg_500_1.duration_ = 7.67

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1107506123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0.775

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_1 = arg_500_1:GetWordFromCfg(1107506122)
				local var_503_2 = arg_500_1:FormatText(var_503_1.content)

				arg_500_1.text_.text = var_503_2

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_4 = 31 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_2) / 31)

				if (31 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_2) / 31)) > 0 and var_503_0 < var_503_4 then
					arg_500_1.talkMaxDuration = var_503_4

					if var_503_4 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_4 + 0
					end
				end

				arg_500_1.text_.text = var_503_2
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506122", "story_v_side_new_1107506.awb") ~= 0 then
					local var_503_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506122", "story_v_side_new_1107506.awb") / 1000

					if var_503_5 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_5 + 0
					end

					if var_503_1.prefab_name ~= "" and arg_500_1.actors_[var_503_1.prefab_name] ~= nil then
						local var_503_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_1.prefab_name].transform, "story_v_side_new_1107506", "1107506122", "story_v_side_new_1107506.awb")

						arg_500_1:RecordAudio("1107506122", var_503_6)
						arg_500_1:RecordAudio("1107506122", var_503_6)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506122", "story_v_side_new_1107506.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506122", "story_v_side_new_1107506.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_7 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_7 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_7

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_7 and arg_500_1.time_ < 0 + var_503_7 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1107506123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1107506123
		arg_504_1.duration_ = 4.1

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1107506124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_507_0 = 0
			local var_507_1 = 0.4

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_2 = arg_504_1:GetWordFromCfg(1107506123)
				local var_507_3 = arg_504_1:FormatText(var_507_2.content)

				arg_504_1.text_.text = var_507_3

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 16 <= 0 and var_507_1 or var_507_1 * (utf8.len(var_507_3) / 16)

				if (16 <= 0 and var_507_1 or var_507_1 * (utf8.len(var_507_3) / 16)) > 0 and var_507_1 < var_507_5 then
					arg_504_1.talkMaxDuration = var_507_5

					if var_507_5 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_5 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_3
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506123", "story_v_side_new_1107506.awb") ~= 0 then
					local var_507_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506123", "story_v_side_new_1107506.awb") / 1000

					if var_507_6 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_6 + var_507_0
					end

					if var_507_2.prefab_name ~= "" and arg_504_1.actors_[var_507_2.prefab_name] ~= nil then
						local var_507_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_2.prefab_name].transform, "story_v_side_new_1107506", "1107506123", "story_v_side_new_1107506.awb")

						arg_504_1:RecordAudio("1107506123", var_507_7)
						arg_504_1:RecordAudio("1107506123", var_507_7)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506123", "story_v_side_new_1107506.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506123", "story_v_side_new_1107506.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_8 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_8 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_8

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_8 and arg_504_1.time_ < var_507_0 + var_507_8 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1107506124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1107506124
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1107506125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.var_.moveOldPos1075ui_actor = arg_508_1.actors_["1075ui_actor"].transform.localPosition

				local var_511_0 = GameObjectTools.GetOrAddComponent(arg_508_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_511_0 then
					var_511_0:EnableDynamicBone(false)
				end
			end

			local var_511_1 = 0.001

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_1 then
				arg_508_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_508_1.time_ - 0) / var_511_1)
				arg_508_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_508_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["1075ui_actor"].transform.position).z)
				arg_508_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_508_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_508_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_508_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_508_1.time_ >= 0 + var_511_1 and arg_508_1.time_ < 0 + var_511_1 + arg_511_0 then
				arg_508_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_508_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_508_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["1075ui_actor"].transform.position).z)
				arg_508_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_508_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_508_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_508_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_511_2 = GameObjectTools.GetOrAddComponent(arg_508_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_511_2 then
					var_511_2:EnableDynamicBone(true)
				end
			end

			local var_511_3 = arg_508_1.actors_["1075ui_actor"]

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(var_511_3) and arg_508_1.var_.characterEffect1075ui_actor == nil then
				arg_508_1.var_.characterEffect1075ui_actor = var_511_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_4 = 0.200000002980232

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_4 and not isNil(var_511_3) then
				if arg_508_1.var_.characterEffect1075ui_actor and not isNil(var_511_3) then
					arg_508_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_508_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_508_1.time_ - 0) / var_511_4)
				end
			end

			if arg_508_1.time_ >= 0 + var_511_4 and arg_508_1.time_ < 0 + var_511_4 + arg_511_0 and not isNil(var_511_3) and arg_508_1.var_.characterEffect1075ui_actor then
				arg_508_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_508_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_511_5 = 0
			local var_511_6 = 0.65

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_5 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, false)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_7 = arg_508_1:FormatText(arg_508_1:GetWordFromCfg(1107506124).content)

				arg_508_1.text_.text = var_511_7

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_9 = 26 <= 0 and var_511_6 or var_511_6 * (utf8.len(var_511_7) / 26)

				if (26 <= 0 and var_511_6 or var_511_6 * (utf8.len(var_511_7) / 26)) > 0 and var_511_6 < var_511_9 then
					arg_508_1.talkMaxDuration = var_511_9

					if var_511_9 + var_511_5 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_9 + var_511_5
					end
				end

				arg_508_1.text_.text = var_511_7
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_10 = math.max(var_511_6, arg_508_1.talkMaxDuration)

			if var_511_5 <= arg_508_1.time_ and arg_508_1.time_ < var_511_5 + var_511_10 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_5) / var_511_10

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_5 + var_511_10 and arg_508_1.time_ < var_511_5 + var_511_10 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play1107506125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1107506125
		arg_512_1.duration_ = 1

		SetActive(arg_512_1.tipsGo_, true)

		arg_512_1.tipsText_.text = StoryTipsCfg[107501].name

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"

			SetActive(arg_512_1.choicesGo_, true)

			for iter_513_0, iter_513_1 in ipairs(arg_512_1.choices_) do
				SetActive(iter_513_1.go, iter_513_0 <= 2)
			end

			arg_512_1.choices_[1].txt.text = arg_512_1:FormatText(StoryChoiceCfg[1173].name)
			arg_512_1.choices_[2].txt.text = arg_512_1:FormatText(StoryChoiceCfg[1174].name)
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				PlayerAction.UseStoryTrigger(1075012, 210750106, 1107506125, 1)
				arg_512_0:Play1107506126(arg_512_1)
			end

			if arg_514_0 == 2 then
				arg_512_0:Play1107506128(arg_512_1)
			end

			arg_512_1:RecordChoiceLog(1107506125, 1173, 1174)
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.allBtn_.enabled = false
			end

			if arg_512_1.time_ >= 0 + 0.5 and arg_512_1.time_ < 0 + 0.5 + arg_515_0 then
				arg_512_1.allBtn_.enabled = true
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1107506126 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1107506126
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1107506127(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0.75

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, false)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_1 = arg_516_1:FormatText(arg_516_1:GetWordFromCfg(1107506126).content)

				arg_516_1.text_.text = var_519_1

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_3 = 30 <= 0 and var_519_0 or var_519_0 * (utf8.len(var_519_1) / 30)

				if (30 <= 0 and var_519_0 or var_519_0 * (utf8.len(var_519_1) / 30)) > 0 and var_519_0 < var_519_3 then
					arg_516_1.talkMaxDuration = var_519_3

					if var_519_3 + 0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_3 + 0
					end
				end

				arg_516_1.text_.text = var_519_1
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_4 = math.max(var_519_0, arg_516_1.talkMaxDuration)

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_4 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - 0) / var_519_4

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= 0 + var_519_4 and arg_516_1.time_ < 0 + var_519_4 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play1107506127 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1107506127
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1107506130(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0.475

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_1 = arg_520_1:FormatText(arg_520_1:GetWordFromCfg(1107506127).content)

				arg_520_1.text_.text = var_523_1

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_3 = 24 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_1) / 24)

				if (24 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_1) / 24)) > 0 and var_523_0 < var_523_3 then
					arg_520_1.talkMaxDuration = var_523_3

					if var_523_3 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_3 + 0
					end
				end

				arg_520_1.text_.text = var_523_1
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_4 = math.max(var_523_0, arg_520_1.talkMaxDuration)

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_4 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - 0) / var_523_4

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= 0 + var_523_4 and arg_520_1.time_ < 0 + var_523_4 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play1107506130 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1107506130
		arg_524_1.duration_ = 5.2

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play1107506131(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.var_.moveOldPos1075ui_actor = arg_524_1.actors_["1075ui_actor"].transform.localPosition

				local var_527_0 = GameObjectTools.GetOrAddComponent(arg_524_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_527_0 then
					var_527_0:EnableDynamicBone(false)
				end
			end

			local var_527_1 = 0.001

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_1 then
				arg_524_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_524_1.time_ - 0) / var_527_1)
				arg_524_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1075ui_actor"].transform.position).z)
				arg_524_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_524_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_524_1.time_ >= 0 + var_527_1 and arg_524_1.time_ < 0 + var_527_1 + arg_527_0 then
				arg_524_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_524_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1075ui_actor"].transform.position).z)
				arg_524_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_524_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_527_2 = GameObjectTools.GetOrAddComponent(arg_524_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_527_2 then
					var_527_2:EnableDynamicBone(true)
				end
			end

			local var_527_3 = arg_524_1.actors_["1075ui_actor"]

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(var_527_3) and arg_524_1.var_.characterEffect1075ui_actor == nil then
				arg_524_1.var_.characterEffect1075ui_actor = var_527_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_4 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_4 and not isNil(var_527_3) then
				if arg_524_1.var_.characterEffect1075ui_actor and not isNil(var_527_3) then
					arg_524_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_524_1.time_ >= 0 + var_527_4 and arg_524_1.time_ < 0 + var_527_4 + arg_527_0 and not isNil(var_527_3) and arg_524_1.var_.characterEffect1075ui_actor then
				arg_524_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_527_6 = 0
			local var_527_7 = 0.525

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_6 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_8 = arg_524_1:GetWordFromCfg(1107506130)
				local var_527_9 = arg_524_1:FormatText(var_527_8.content)

				arg_524_1.text_.text = var_527_9

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_11 = 21 <= 0 and var_527_7 or var_527_7 * (utf8.len(var_527_9) / 21)

				if (21 <= 0 and var_527_7 or var_527_7 * (utf8.len(var_527_9) / 21)) > 0 and var_527_7 < var_527_11 then
					arg_524_1.talkMaxDuration = var_527_11

					if var_527_11 + var_527_6 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_11 + var_527_6
					end
				end

				arg_524_1.text_.text = var_527_9
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506130", "story_v_side_new_1107506.awb") ~= 0 then
					local var_527_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506130", "story_v_side_new_1107506.awb") / 1000

					if var_527_12 + var_527_6 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_12 + var_527_6
					end

					if var_527_8.prefab_name ~= "" and arg_524_1.actors_[var_527_8.prefab_name] ~= nil then
						local var_527_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_8.prefab_name].transform, "story_v_side_new_1107506", "1107506130", "story_v_side_new_1107506.awb")

						arg_524_1:RecordAudio("1107506130", var_527_13)
						arg_524_1:RecordAudio("1107506130", var_527_13)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506130", "story_v_side_new_1107506.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506130", "story_v_side_new_1107506.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_14 = math.max(var_527_7, arg_524_1.talkMaxDuration)

			if var_527_6 <= arg_524_1.time_ and arg_524_1.time_ < var_527_6 + var_527_14 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_6) / var_527_14

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_6 + var_527_14 and arg_524_1.time_ < var_527_6 + var_527_14 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_524_1:InitPlayNodeList()
	end,
	Play1107506131 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1107506131
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1107506132(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(arg_528_1.actors_["1075ui_actor"]) and arg_528_1.var_.characterEffect1075ui_actor == nil then
				arg_528_1.var_.characterEffect1075ui_actor = arg_528_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_0 = 0.200000002980232

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_0 and not isNil(arg_528_1.actors_["1075ui_actor"]) then
				if arg_528_1.var_.characterEffect1075ui_actor and not isNil(arg_528_1.actors_["1075ui_actor"]) then
					arg_528_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_528_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_528_1.time_ - 0) / var_531_0)
				end
			end

			if arg_528_1.time_ >= 0 + var_531_0 and arg_528_1.time_ < 0 + var_531_0 + arg_531_0 and not isNil(arg_528_1.actors_["1075ui_actor"]) and arg_528_1.var_.characterEffect1075ui_actor then
				arg_528_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_528_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_531_1 = 0
			local var_531_2 = 0.225

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(1, 1, 1)
				arg_528_1.icon_.color = Color.New(1, 1, 1)

				local var_531_3 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(1107506131).content)

				arg_528_1.text_.text = var_531_3

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 9 <= 0 and var_531_2 or var_531_2 * (utf8.len(var_531_3) / 9)

				if (9 <= 0 and var_531_2 or var_531_2 * (utf8.len(var_531_3) / 9)) > 0 and var_531_2 < var_531_5 then
					arg_528_1.talkMaxDuration = var_531_5

					if var_531_5 + var_531_1 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_5 + var_531_1
					end
				end

				arg_528_1.text_.text = var_531_3
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_6 = math.max(var_531_2, arg_528_1.talkMaxDuration)

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_6 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_1) / var_531_6

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_1 + var_531_6 and arg_528_1.time_ < var_531_1 + var_531_6 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1107506132 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1107506132
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1107506133(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 1

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_1 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(1107506132).content)

				arg_532_1.text_.text = var_535_1

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_3 = 40 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 40)

				if (40 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 40)) > 0 and var_535_0 < var_535_3 then
					arg_532_1.talkMaxDuration = var_535_3

					if var_535_3 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_3 + 0
					end
				end

				arg_532_1.text_.text = var_535_1
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_4 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_4

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1107506133 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1107506133
		arg_536_1.duration_ = 3.43

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1107506134(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(arg_536_1.actors_["1075ui_actor"]) and arg_536_1.var_.characterEffect1075ui_actor == nil then
				arg_536_1.var_.characterEffect1075ui_actor = arg_536_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_0 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 and not isNil(arg_536_1.actors_["1075ui_actor"]) then
				if arg_536_1.var_.characterEffect1075ui_actor and not isNil(arg_536_1.actors_["1075ui_actor"]) then
					arg_536_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 and not isNil(arg_536_1.actors_["1075ui_actor"]) and arg_536_1.var_.characterEffect1075ui_actor then
				arg_536_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_539_2 = 0
			local var_539_3 = 0.25

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_2 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_4 = arg_536_1:GetWordFromCfg(1107506133)
				local var_539_5 = arg_536_1:FormatText(var_539_4.content)

				arg_536_1.text_.text = var_539_5

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_7 = 10 <= 0 and var_539_3 or var_539_3 * (utf8.len(var_539_5) / 10)

				if (10 <= 0 and var_539_3 or var_539_3 * (utf8.len(var_539_5) / 10)) > 0 and var_539_3 < var_539_7 then
					arg_536_1.talkMaxDuration = var_539_7

					if var_539_7 + var_539_2 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_7 + var_539_2
					end
				end

				arg_536_1.text_.text = var_539_5
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506133", "story_v_side_new_1107506.awb") ~= 0 then
					local var_539_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506133", "story_v_side_new_1107506.awb") / 1000

					if var_539_8 + var_539_2 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_8 + var_539_2
					end

					if var_539_4.prefab_name ~= "" and arg_536_1.actors_[var_539_4.prefab_name] ~= nil then
						local var_539_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_4.prefab_name].transform, "story_v_side_new_1107506", "1107506133", "story_v_side_new_1107506.awb")

						arg_536_1:RecordAudio("1107506133", var_539_9)
						arg_536_1:RecordAudio("1107506133", var_539_9)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506133", "story_v_side_new_1107506.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506133", "story_v_side_new_1107506.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_10 = math.max(var_539_3, arg_536_1.talkMaxDuration)

			if var_539_2 <= arg_536_1.time_ and arg_536_1.time_ < var_539_2 + var_539_10 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_2) / var_539_10

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_2 + var_539_10 and arg_536_1.time_ < var_539_2 + var_539_10 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play1107506134 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1107506134
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1107506135(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 and not isNil(arg_540_1.actors_["1075ui_actor"]) and arg_540_1.var_.characterEffect1075ui_actor == nil then
				arg_540_1.var_.characterEffect1075ui_actor = arg_540_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_0 = 0.200000002980232

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_0 and not isNil(arg_540_1.actors_["1075ui_actor"]) then
				if arg_540_1.var_.characterEffect1075ui_actor and not isNil(arg_540_1.actors_["1075ui_actor"]) then
					arg_540_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_540_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_540_1.time_ - 0) / var_543_0)
				end
			end

			if arg_540_1.time_ >= 0 + var_543_0 and arg_540_1.time_ < 0 + var_543_0 + arg_543_0 and not isNil(arg_540_1.actors_["1075ui_actor"]) and arg_540_1.var_.characterEffect1075ui_actor then
				arg_540_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_540_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_543_1 = 0
			local var_543_2 = 0.1

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_3 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(1107506134).content)

				arg_540_1.text_.text = var_543_3

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 4 <= 0 and var_543_2 or var_543_2 * (utf8.len(var_543_3) / 4)

				if (4 <= 0 and var_543_2 or var_543_2 * (utf8.len(var_543_3) / 4)) > 0 and var_543_2 < var_543_5 then
					arg_540_1.talkMaxDuration = var_543_5

					if var_543_5 + var_543_1 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + var_543_1
					end
				end

				arg_540_1.text_.text = var_543_3
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_6 = math.max(var_543_2, arg_540_1.talkMaxDuration)

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_6 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_1) / var_543_6

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_1 + var_543_6 and arg_540_1.time_ < var_543_1 + var_543_6 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play1107506135 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1107506135
		arg_544_1.duration_ = 12.6

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1107506136(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(arg_544_1.actors_["1075ui_actor"]) and arg_544_1.var_.characterEffect1075ui_actor == nil then
				arg_544_1.var_.characterEffect1075ui_actor = arg_544_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_0 = 0.200000002980232

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_0 and not isNil(arg_544_1.actors_["1075ui_actor"]) then
				if arg_544_1.var_.characterEffect1075ui_actor and not isNil(arg_544_1.actors_["1075ui_actor"]) then
					arg_544_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_544_1.time_ >= 0 + var_547_0 and arg_544_1.time_ < 0 + var_547_0 + arg_547_0 and not isNil(arg_544_1.actors_["1075ui_actor"]) and arg_544_1.var_.characterEffect1075ui_actor then
				arg_544_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_547_2 = 0
			local var_547_3 = 1.175

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_2 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_4 = arg_544_1:GetWordFromCfg(1107506135)
				local var_547_5 = arg_544_1:FormatText(var_547_4.content)

				arg_544_1.text_.text = var_547_5

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_7 = 47 <= 0 and var_547_3 or var_547_3 * (utf8.len(var_547_5) / 47)

				if (47 <= 0 and var_547_3 or var_547_3 * (utf8.len(var_547_5) / 47)) > 0 and var_547_3 < var_547_7 then
					arg_544_1.talkMaxDuration = var_547_7

					if var_547_7 + var_547_2 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_7 + var_547_2
					end
				end

				arg_544_1.text_.text = var_547_5
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506135", "story_v_side_new_1107506.awb") ~= 0 then
					local var_547_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506135", "story_v_side_new_1107506.awb") / 1000

					if var_547_8 + var_547_2 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_8 + var_547_2
					end

					if var_547_4.prefab_name ~= "" and arg_544_1.actors_[var_547_4.prefab_name] ~= nil then
						local var_547_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_4.prefab_name].transform, "story_v_side_new_1107506", "1107506135", "story_v_side_new_1107506.awb")

						arg_544_1:RecordAudio("1107506135", var_547_9)
						arg_544_1:RecordAudio("1107506135", var_547_9)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506135", "story_v_side_new_1107506.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506135", "story_v_side_new_1107506.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_10 = math.max(var_547_3, arg_544_1.talkMaxDuration)

			if var_547_2 <= arg_544_1.time_ and arg_544_1.time_ < var_547_2 + var_547_10 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_2) / var_547_10

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_2 + var_547_10 and arg_544_1.time_ < var_547_2 + var_547_10 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play1107506136 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 1107506136
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play1107506137(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(arg_548_1.actors_["1075ui_actor"]) and arg_548_1.var_.characterEffect1075ui_actor == nil then
				arg_548_1.var_.characterEffect1075ui_actor = arg_548_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_0 = 0.200000002980232

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_0 and not isNil(arg_548_1.actors_["1075ui_actor"]) then
				if arg_548_1.var_.characterEffect1075ui_actor and not isNil(arg_548_1.actors_["1075ui_actor"]) then
					arg_548_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_548_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_548_1.time_ - 0) / var_551_0)
				end
			end

			if arg_548_1.time_ >= 0 + var_551_0 and arg_548_1.time_ < 0 + var_551_0 + arg_551_0 and not isNil(arg_548_1.actors_["1075ui_actor"]) and arg_548_1.var_.characterEffect1075ui_actor then
				arg_548_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_548_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_551_1 = 0
			local var_551_2 = 0.8

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_3 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(1107506136).content)

				arg_548_1.text_.text = var_551_3

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_5 = 43 <= 0 and var_551_2 or var_551_2 * (utf8.len(var_551_3) / 43)

				if (43 <= 0 and var_551_2 or var_551_2 * (utf8.len(var_551_3) / 43)) > 0 and var_551_2 < var_551_5 then
					arg_548_1.talkMaxDuration = var_551_5

					if var_551_5 + var_551_1 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_5 + var_551_1
					end
				end

				arg_548_1.text_.text = var_551_3
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_6 = math.max(var_551_2, arg_548_1.talkMaxDuration)

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_6 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_1) / var_551_6

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_1 + var_551_6 and arg_548_1.time_ < var_551_1 + var_551_6 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play1107506137 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1107506137
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play1107506138(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.425

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_1 = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(1107506137).content)

				arg_552_1.text_.text = var_555_1

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_3 = 17 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_1) / 17)

				if (17 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_1) / 17)) > 0 and var_555_0 < var_555_3 then
					arg_552_1.talkMaxDuration = var_555_3

					if var_555_3 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_3 + 0
					end
				end

				arg_552_1.text_.text = var_555_1
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_4 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_4 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_4

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_4 and arg_552_1.time_ < 0 + var_555_4 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play1107506138 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 1107506138
		arg_556_1.duration_ = 8.97

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play1107506139(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 1.96599999815226 < arg_556_1.time_ and arg_556_1.time_ <= 1.96599999815226 + arg_559_0 then
				local var_559_0 = arg_556_1.bgs_.ST37a

				arg_556_1.bgs_.ST37a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_559_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_559_1 = var_559_0:GetComponent("SpriteRenderer")

				if var_559_1 and var_559_1.sprite then
					local var_559_2 = 2 * (var_559_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_559_0.transform.localScale = Vector3.New(var_559_2 / var_559_1.sprite.bounds.size.y < var_559_2 * manager.ui.mainCameraCom_.aspect / var_559_1.sprite.bounds.size.x and var_559_2 * manager.ui.mainCameraCom_.aspect / var_559_1.sprite.bounds.size.x or var_559_2 / var_559_1.sprite.bounds.size.y, var_559_2 / var_559_1.sprite.bounds.size.y < var_559_2 * manager.ui.mainCameraCom_.aspect / var_559_1.sprite.bounds.size.x and var_559_2 * manager.ui.mainCameraCom_.aspect / var_559_1.sprite.bounds.size.x or var_559_2 / var_559_1.sprite.bounds.size.y, 0)
				end

				for iter_559_0, iter_559_1 in pairs(arg_556_1.bgs_) do
					if iter_559_0 ~= "ST37a" then
						iter_559_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_559_3 = 4

			if 4 < arg_556_1.time_ and arg_556_1.time_ <= var_559_3 + arg_559_0 then
				arg_556_1.allBtn_.enabled = false
			end

			if arg_556_1.time_ >= var_559_3 + 0.3 and arg_556_1.time_ < var_559_3 + 0.3 + arg_559_0 then
				arg_556_1.allBtn_.enabled = true
			end

			local var_559_4 = 0

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_4 + arg_559_0 then
				arg_556_1.mask_.enabled = true
				arg_556_1.mask_.raycastTarget = true

				arg_556_1:SetGaussion(false)
			end

			local var_559_5 = 2

			if var_559_4 <= arg_556_1.time_ and arg_556_1.time_ < var_559_4 + var_559_5 then
				local var_559_6 = Color.New(0, 0, 0)

				var_559_6.a = Mathf.Lerp(0, 1, (arg_556_1.time_ - var_559_4) / var_559_5)
				arg_556_1.mask_.color = var_559_6
			end

			if arg_556_1.time_ >= var_559_4 + var_559_5 and arg_556_1.time_ < var_559_4 + var_559_5 + arg_559_0 then
				local var_559_7 = Color.New(0, 0, 0)

				var_559_7.a = 1
				arg_556_1.mask_.color = var_559_7
			end

			local var_559_8 = 2

			if 2 < arg_556_1.time_ and arg_556_1.time_ <= var_559_8 + arg_559_0 then
				arg_556_1.mask_.enabled = true
				arg_556_1.mask_.raycastTarget = true

				arg_556_1:SetGaussion(false)
			end

			local var_559_9 = 2

			if var_559_8 <= arg_556_1.time_ and arg_556_1.time_ < var_559_8 + var_559_9 then
				local var_559_10 = Color.New(0, 0, 0)

				var_559_10.a = Mathf.Lerp(1, 0, (arg_556_1.time_ - var_559_8) / var_559_9)
				arg_556_1.mask_.color = var_559_10
			end

			if arg_556_1.time_ >= var_559_8 + var_559_9 and arg_556_1.time_ < var_559_8 + var_559_9 + arg_559_0 then
				local var_559_11 = Color.New(0, 0, 0)

				arg_556_1.mask_.enabled = false
				var_559_11.a = 0
				arg_556_1.mask_.color = var_559_11
			end

			local var_559_12 = arg_556_1.actors_["1075ui_actor"].transform

			if 1.96599999815226 < arg_556_1.time_ and arg_556_1.time_ <= 1.96599999815226 + arg_559_0 then
				arg_556_1.var_.moveOldPos1075ui_actor = var_559_12.localPosition

				local var_559_13 = GameObjectTools.GetOrAddComponent(var_559_12.gameObject, typeof(DynamicBoneHelper))

				if var_559_13 then
					var_559_13:EnableDynamicBone(false)
				end
			end

			local var_559_14 = 0.001

			if 1.96599999815226 <= arg_556_1.time_ and arg_556_1.time_ < 1.96599999815226 + var_559_14 then
				var_559_12.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_556_1.time_ - 1.96599999815226) / var_559_14)
				var_559_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_559_12.position).x, (manager.ui.mainCamera.transform.position - var_559_12.position).y, (manager.ui.mainCamera.transform.position - var_559_12.position).z)
				var_559_12.localEulerAngles.z = 0
				var_559_12.localEulerAngles.x = 0
				var_559_12.localEulerAngles = var_559_12.localEulerAngles
			end

			if arg_556_1.time_ >= 1.96599999815226 + var_559_14 and arg_556_1.time_ < 1.96599999815226 + var_559_14 + arg_559_0 then
				var_559_12.localPosition = Vector3.New(0, 100, 0)
				var_559_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_559_12.position).x, (manager.ui.mainCamera.transform.position - var_559_12.position).y, (manager.ui.mainCamera.transform.position - var_559_12.position).z)
				var_559_12.localEulerAngles.z = 0
				var_559_12.localEulerAngles.x = 0
				var_559_12.localEulerAngles = var_559_12.localEulerAngles

				local var_559_15 = GameObjectTools.GetOrAddComponent(var_559_12.gameObject, typeof(DynamicBoneHelper))

				if var_559_15 then
					var_559_15:EnableDynamicBone(true)
				end
			end

			if arg_556_1.frameCnt_ <= 1 then
				arg_556_1.dialog_:SetActive(false)
			end

			local var_559_16 = 3.96599999815226
			local var_559_17 = 0.625

			if 3.96599999815226 < arg_556_1.time_ and arg_556_1.time_ <= var_559_16 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0

				arg_556_1.dialog_:SetActive(true)

				arg_556_1.dialogCg_.alpha = 0

				local var_559_18 = LeanTween.value(arg_556_1.dialog_, 0, 1, 0.3)

				var_559_18:setOnUpdate(LuaHelper.FloatAction(function(arg_560_0)
					arg_556_1.dialogCg_.alpha = arg_560_0
				end))
				var_559_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_556_1.dialog_)
					var_559_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_556_1.duration_ = arg_556_1.duration_ + 0.3

				SetActive(arg_556_1.leftNameGo_, false)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_19 = arg_556_1:FormatText(arg_556_1:GetWordFromCfg(1107506138).content)

				arg_556_1.text_.text = var_559_19

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_21 = 25 <= 0 and var_559_17 or var_559_17 * (utf8.len(var_559_19) / 25)

				if (25 <= 0 and var_559_17 or var_559_17 * (utf8.len(var_559_19) / 25)) > 0 and var_559_17 < var_559_21 then
					arg_556_1.talkMaxDuration = var_559_21
					var_559_16 = var_559_16 + 0.3

					if var_559_21 + var_559_16 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_21 + var_559_16
					end
				end

				arg_556_1.text_.text = var_559_19
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_22 = var_559_16 + 0.3
			local var_559_23 = math.max(var_559_17, arg_556_1.talkMaxDuration)

			if var_559_16 + 0.3 <= arg_556_1.time_ and arg_556_1.time_ < var_559_22 + var_559_23 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_22) / var_559_23

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_22 + var_559_23 and arg_556_1.time_ < var_559_22 + var_559_23 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_556_1:InitPlayNodeList()
	end,
	Play1107506139 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1107506139
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1107506140(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_rain_inside02", "")
			end

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_rain_inside01", "")
			end

			local var_565_2 = 0
			local var_565_3 = 0.55

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_2 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, false)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_4 = arg_562_1:FormatText(arg_562_1:GetWordFromCfg(1107506139).content)

				arg_562_1.text_.text = var_565_4

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_6 = 22 <= 0 and var_565_3 or var_565_3 * (utf8.len(var_565_4) / 22)

				if (22 <= 0 and var_565_3 or var_565_3 * (utf8.len(var_565_4) / 22)) > 0 and var_565_3 < var_565_6 then
					arg_562_1.talkMaxDuration = var_565_6

					if var_565_6 + var_565_2 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_6 + var_565_2
					end
				end

				arg_562_1.text_.text = var_565_4
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_7 = math.max(var_565_3, arg_562_1.talkMaxDuration)

			if var_565_2 <= arg_562_1.time_ and arg_562_1.time_ < var_565_2 + var_565_7 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_2) / var_565_7

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_2 + var_565_7 and arg_562_1.time_ < var_565_2 + var_565_7 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play1107506140 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1107506140
		arg_566_1.duration_ = 4.5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play1107506141(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1.var_.moveOldPos1075ui_actor = arg_566_1.actors_["1075ui_actor"].transform.localPosition

				local var_569_0 = GameObjectTools.GetOrAddComponent(arg_566_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_569_0 then
					var_569_0:EnableDynamicBone(false)
				end
			end

			local var_569_1 = 0.001

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_1 then
				arg_566_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_566_1.time_ - 0) / var_569_1)
				arg_566_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_566_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1075ui_actor"].transform.position).z)
				arg_566_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_566_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_566_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_566_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_566_1.time_ >= 0 + var_569_1 and arg_566_1.time_ < 0 + var_569_1 + arg_569_0 then
				arg_566_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_566_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_566_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1075ui_actor"].transform.position).z)
				arg_566_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_566_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_566_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_566_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_569_2 = GameObjectTools.GetOrAddComponent(arg_566_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_569_2 then
					var_569_2:EnableDynamicBone(true)
				end
			end

			local var_569_3 = arg_566_1.actors_["1075ui_actor"]

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(var_569_3) and arg_566_1.var_.characterEffect1075ui_actor == nil then
				arg_566_1.var_.characterEffect1075ui_actor = var_569_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_4 = 0.200000002980232

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_4 and not isNil(var_569_3) then
				if arg_566_1.var_.characterEffect1075ui_actor and not isNil(var_569_3) then
					arg_566_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_566_1.time_ >= 0 + var_569_4 and arg_566_1.time_ < 0 + var_569_4 + arg_569_0 and not isNil(var_569_3) and arg_566_1.var_.characterEffect1075ui_actor then
				arg_566_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_569_6 = 0
			local var_569_7 = 0.525

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_6 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_8 = arg_566_1:GetWordFromCfg(1107506140)
				local var_569_9 = arg_566_1:FormatText(var_569_8.content)

				arg_566_1.text_.text = var_569_9

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_11 = 21 <= 0 and var_569_7 or var_569_7 * (utf8.len(var_569_9) / 21)

				if (21 <= 0 and var_569_7 or var_569_7 * (utf8.len(var_569_9) / 21)) > 0 and var_569_7 < var_569_11 then
					arg_566_1.talkMaxDuration = var_569_11

					if var_569_11 + var_569_6 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_11 + var_569_6
					end
				end

				arg_566_1.text_.text = var_569_9
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506140", "story_v_side_new_1107506.awb") ~= 0 then
					local var_569_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506140", "story_v_side_new_1107506.awb") / 1000

					if var_569_12 + var_569_6 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_12 + var_569_6
					end

					if var_569_8.prefab_name ~= "" and arg_566_1.actors_[var_569_8.prefab_name] ~= nil then
						local var_569_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_8.prefab_name].transform, "story_v_side_new_1107506", "1107506140", "story_v_side_new_1107506.awb")

						arg_566_1:RecordAudio("1107506140", var_569_13)
						arg_566_1:RecordAudio("1107506140", var_569_13)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506140", "story_v_side_new_1107506.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506140", "story_v_side_new_1107506.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_14 = math.max(var_569_7, arg_566_1.talkMaxDuration)

			if var_569_6 <= arg_566_1.time_ and arg_566_1.time_ < var_569_6 + var_569_14 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_6) / var_569_14

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_6 + var_569_14 and arg_566_1.time_ < var_569_6 + var_569_14 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play1107506141 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1107506141
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1107506142(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(arg_570_1.actors_["1075ui_actor"]) and arg_570_1.var_.characterEffect1075ui_actor == nil then
				arg_570_1.var_.characterEffect1075ui_actor = arg_570_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_0 = 0.200000002980232

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 and not isNil(arg_570_1.actors_["1075ui_actor"]) then
				if arg_570_1.var_.characterEffect1075ui_actor and not isNil(arg_570_1.actors_["1075ui_actor"]) then
					arg_570_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_570_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_570_1.time_ - 0) / var_573_0)
				end
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 and not isNil(arg_570_1.actors_["1075ui_actor"]) and arg_570_1.var_.characterEffect1075ui_actor then
				arg_570_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_570_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_573_1 = 0
			local var_573_2 = 0.475

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, true)
				arg_570_1.iconController_:SetSelectedState("hero")

				arg_570_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_570_1.callingController_:SetSelectedState("normal")

				arg_570_1.keyicon_.color = Color.New(1, 1, 1)
				arg_570_1.icon_.color = Color.New(1, 1, 1)

				local var_573_3 = arg_570_1:FormatText(arg_570_1:GetWordFromCfg(1107506141).content)

				arg_570_1.text_.text = var_573_3

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_5 = 19 <= 0 and var_573_2 or var_573_2 * (utf8.len(var_573_3) / 19)

				if (19 <= 0 and var_573_2 or var_573_2 * (utf8.len(var_573_3) / 19)) > 0 and var_573_2 < var_573_5 then
					arg_570_1.talkMaxDuration = var_573_5

					if var_573_5 + var_573_1 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_5 + var_573_1
					end
				end

				arg_570_1.text_.text = var_573_3
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_6 = math.max(var_573_2, arg_570_1.talkMaxDuration)

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_6 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_1) / var_573_6

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_1 + var_573_6 and arg_570_1.time_ < var_573_1 + var_573_6 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play1107506142 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 1107506142
		arg_574_1.duration_ = 2.8

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play1107506143(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(arg_574_1.actors_["1075ui_actor"]) and arg_574_1.var_.characterEffect1075ui_actor == nil then
				arg_574_1.var_.characterEffect1075ui_actor = arg_574_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_0 = 0.200000002980232

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_0 and not isNil(arg_574_1.actors_["1075ui_actor"]) then
				if arg_574_1.var_.characterEffect1075ui_actor and not isNil(arg_574_1.actors_["1075ui_actor"]) then
					arg_574_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_574_1.time_ >= 0 + var_577_0 and arg_574_1.time_ < 0 + var_577_0 + arg_577_0 and not isNil(arg_574_1.actors_["1075ui_actor"]) and arg_574_1.var_.characterEffect1075ui_actor then
				arg_574_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_577_2 = 0
			local var_577_3 = 0.325

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_2 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_4 = arg_574_1:GetWordFromCfg(1107506142)
				local var_577_5 = arg_574_1:FormatText(var_577_4.content)

				arg_574_1.text_.text = var_577_5

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_7 = 13 <= 0 and var_577_3 or var_577_3 * (utf8.len(var_577_5) / 13)

				if (13 <= 0 and var_577_3 or var_577_3 * (utf8.len(var_577_5) / 13)) > 0 and var_577_3 < var_577_7 then
					arg_574_1.talkMaxDuration = var_577_7

					if var_577_7 + var_577_2 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_7 + var_577_2
					end
				end

				arg_574_1.text_.text = var_577_5
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506142", "story_v_side_new_1107506.awb") ~= 0 then
					local var_577_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506142", "story_v_side_new_1107506.awb") / 1000

					if var_577_8 + var_577_2 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_8 + var_577_2
					end

					if var_577_4.prefab_name ~= "" and arg_574_1.actors_[var_577_4.prefab_name] ~= nil then
						local var_577_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_4.prefab_name].transform, "story_v_side_new_1107506", "1107506142", "story_v_side_new_1107506.awb")

						arg_574_1:RecordAudio("1107506142", var_577_9)
						arg_574_1:RecordAudio("1107506142", var_577_9)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506142", "story_v_side_new_1107506.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506142", "story_v_side_new_1107506.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_10 = math.max(var_577_3, arg_574_1.talkMaxDuration)

			if var_577_2 <= arg_574_1.time_ and arg_574_1.time_ < var_577_2 + var_577_10 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_2) / var_577_10

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_2 + var_577_10 and arg_574_1.time_ < var_577_2 + var_577_10 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play1107506143 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1107506143
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1107506144(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(arg_578_1.actors_["1075ui_actor"]) and arg_578_1.var_.characterEffect1075ui_actor == nil then
				arg_578_1.var_.characterEffect1075ui_actor = arg_578_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_0 = 0.200000002980232

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 and not isNil(arg_578_1.actors_["1075ui_actor"]) then
				if arg_578_1.var_.characterEffect1075ui_actor and not isNil(arg_578_1.actors_["1075ui_actor"]) then
					arg_578_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_578_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_578_1.time_ - 0) / var_581_0)
				end
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 and not isNil(arg_578_1.actors_["1075ui_actor"]) and arg_578_1.var_.characterEffect1075ui_actor then
				arg_578_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_578_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_581_1 = 0
			local var_581_2 = 0.475

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, true)
				arg_578_1.iconController_:SetSelectedState("hero")

				arg_578_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_578_1.callingController_:SetSelectedState("normal")

				arg_578_1.keyicon_.color = Color.New(1, 1, 1)
				arg_578_1.icon_.color = Color.New(1, 1, 1)

				local var_581_3 = arg_578_1:FormatText(arg_578_1:GetWordFromCfg(1107506143).content)

				arg_578_1.text_.text = var_581_3

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_5 = 19 <= 0 and var_581_2 or var_581_2 * (utf8.len(var_581_3) / 19)

				if (19 <= 0 and var_581_2 or var_581_2 * (utf8.len(var_581_3) / 19)) > 0 and var_581_2 < var_581_5 then
					arg_578_1.talkMaxDuration = var_581_5

					if var_581_5 + var_581_1 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_5 + var_581_1
					end
				end

				arg_578_1.text_.text = var_581_3
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_6 = math.max(var_581_2, arg_578_1.talkMaxDuration)

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_6 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_1) / var_581_6

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_1 + var_581_6 and arg_578_1.time_ < var_581_1 + var_581_6 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play1107506144 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1107506144
		arg_582_1.duration_ = 9

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1107506145(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 1.999999999999 < arg_582_1.time_ and arg_582_1.time_ <= 1.999999999999 + arg_585_0 then
				local var_585_0 = arg_582_1.bgs_.STblack

				arg_582_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_585_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_585_1 = var_585_0:GetComponent("SpriteRenderer")

				if var_585_1 and var_585_1.sprite then
					local var_585_2 = 2 * (var_585_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_585_0.transform.localScale = Vector3.New(var_585_2 / var_585_1.sprite.bounds.size.y < var_585_2 * manager.ui.mainCameraCom_.aspect / var_585_1.sprite.bounds.size.x and var_585_2 * manager.ui.mainCameraCom_.aspect / var_585_1.sprite.bounds.size.x or var_585_2 / var_585_1.sprite.bounds.size.y, var_585_2 / var_585_1.sprite.bounds.size.y < var_585_2 * manager.ui.mainCameraCom_.aspect / var_585_1.sprite.bounds.size.x and var_585_2 * manager.ui.mainCameraCom_.aspect / var_585_1.sprite.bounds.size.x or var_585_2 / var_585_1.sprite.bounds.size.y, 0)
				end

				for iter_585_0, iter_585_1 in pairs(arg_582_1.bgs_) do
					if iter_585_0 ~= "STblack" then
						iter_585_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_585_3 = 3.999999999999

			if 3.999999999999 < arg_582_1.time_ and arg_582_1.time_ <= var_585_3 + arg_585_0 then
				arg_582_1.allBtn_.enabled = false
			end

			if arg_582_1.time_ >= var_585_3 + 0.3 and arg_582_1.time_ < var_585_3 + 0.3 + arg_585_0 then
				arg_582_1.allBtn_.enabled = true
			end

			local var_585_4 = 0

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_4 + arg_585_0 then
				arg_582_1.mask_.enabled = true
				arg_582_1.mask_.raycastTarget = true

				arg_582_1:SetGaussion(false)
			end

			local var_585_5 = 2

			if var_585_4 <= arg_582_1.time_ and arg_582_1.time_ < var_585_4 + var_585_5 then
				local var_585_6 = Color.New(0, 0, 0)

				var_585_6.a = Mathf.Lerp(0, 1, (arg_582_1.time_ - var_585_4) / var_585_5)
				arg_582_1.mask_.color = var_585_6
			end

			if arg_582_1.time_ >= var_585_4 + var_585_5 and arg_582_1.time_ < var_585_4 + var_585_5 + arg_585_0 then
				local var_585_7 = Color.New(0, 0, 0)

				var_585_7.a = 1
				arg_582_1.mask_.color = var_585_7
			end

			local var_585_8 = 2

			if 2 < arg_582_1.time_ and arg_582_1.time_ <= var_585_8 + arg_585_0 then
				arg_582_1.mask_.enabled = true
				arg_582_1.mask_.raycastTarget = true

				arg_582_1:SetGaussion(false)
			end

			local var_585_9 = 2

			if var_585_8 <= arg_582_1.time_ and arg_582_1.time_ < var_585_8 + var_585_9 then
				local var_585_10 = Color.New(0, 0, 0)

				var_585_10.a = Mathf.Lerp(1, 0, (arg_582_1.time_ - var_585_8) / var_585_9)
				arg_582_1.mask_.color = var_585_10
			end

			if arg_582_1.time_ >= var_585_8 + var_585_9 and arg_582_1.time_ < var_585_8 + var_585_9 + arg_585_0 then
				local var_585_11 = Color.New(0, 0, 0)

				arg_582_1.mask_.enabled = false
				var_585_11.a = 0
				arg_582_1.mask_.color = var_585_11
			end

			local var_585_12 = arg_582_1.actors_["1075ui_actor"].transform

			if 1.96599999815226 < arg_582_1.time_ and arg_582_1.time_ <= 1.96599999815226 + arg_585_0 then
				arg_582_1.var_.moveOldPos1075ui_actor = var_585_12.localPosition

				local var_585_13 = GameObjectTools.GetOrAddComponent(var_585_12.gameObject, typeof(DynamicBoneHelper))

				if var_585_13 then
					var_585_13:EnableDynamicBone(false)
				end
			end

			local var_585_14 = 0.001

			if 1.96599999815226 <= arg_582_1.time_ and arg_582_1.time_ < 1.96599999815226 + var_585_14 then
				var_585_12.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_582_1.time_ - 1.96599999815226) / var_585_14)
				var_585_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_585_12.position).x, (manager.ui.mainCamera.transform.position - var_585_12.position).y, (manager.ui.mainCamera.transform.position - var_585_12.position).z)
				var_585_12.localEulerAngles.z = 0
				var_585_12.localEulerAngles.x = 0
				var_585_12.localEulerAngles = var_585_12.localEulerAngles
			end

			if arg_582_1.time_ >= 1.96599999815226 + var_585_14 and arg_582_1.time_ < 1.96599999815226 + var_585_14 + arg_585_0 then
				var_585_12.localPosition = Vector3.New(0, 100, 0)
				var_585_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_585_12.position).x, (manager.ui.mainCamera.transform.position - var_585_12.position).y, (manager.ui.mainCamera.transform.position - var_585_12.position).z)
				var_585_12.localEulerAngles.z = 0
				var_585_12.localEulerAngles.x = 0
				var_585_12.localEulerAngles = var_585_12.localEulerAngles

				local var_585_15 = GameObjectTools.GetOrAddComponent(var_585_12.gameObject, typeof(DynamicBoneHelper))

				if var_585_15 then
					var_585_15:EnableDynamicBone(true)
				end
			end

			if arg_582_1.frameCnt_ <= 1 then
				arg_582_1.dialog_:SetActive(false)
			end

			local var_585_16 = 3.999999999999
			local var_585_17 = 0.775

			if 3.999999999999 < arg_582_1.time_ and arg_582_1.time_ <= var_585_16 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0

				arg_582_1.dialog_:SetActive(true)

				arg_582_1.dialogCg_.alpha = 0

				local var_585_18 = LeanTween.value(arg_582_1.dialog_, 0, 1, 0.3)

				var_585_18:setOnUpdate(LuaHelper.FloatAction(function(arg_586_0)
					arg_582_1.dialogCg_.alpha = arg_586_0
				end))
				var_585_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_582_1.dialog_)
					var_585_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_582_1.duration_ = arg_582_1.duration_ + 0.3

				SetActive(arg_582_1.leftNameGo_, false)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_19 = arg_582_1:FormatText(arg_582_1:GetWordFromCfg(1107506144).content)

				arg_582_1.text_.text = var_585_19

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_21 = 31 <= 0 and var_585_17 or var_585_17 * (utf8.len(var_585_19) / 31)

				if (31 <= 0 and var_585_17 or var_585_17 * (utf8.len(var_585_19) / 31)) > 0 and var_585_17 < var_585_21 then
					arg_582_1.talkMaxDuration = var_585_21
					var_585_16 = var_585_16 + 0.3

					if var_585_21 + var_585_16 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_21 + var_585_16
					end
				end

				arg_582_1.text_.text = var_585_19
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_22 = var_585_16 + 0.3
			local var_585_23 = math.max(var_585_17, arg_582_1.talkMaxDuration)

			if var_585_16 + 0.3 <= arg_582_1.time_ and arg_582_1.time_ < var_585_22 + var_585_23 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_22) / var_585_23

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_22 + var_585_23 and arg_582_1.time_ < var_585_22 + var_585_23 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_582_1:InitPlayNodeList()
	end,
	Play1107506145 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 1107506145
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play1107506146(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0.875

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, false)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_1 = arg_588_1:FormatText(arg_588_1:GetWordFromCfg(1107506145).content)

				arg_588_1.text_.text = var_591_1

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_3 = 35 <= 0 and var_591_0 or var_591_0 * (utf8.len(var_591_1) / 35)

				if (35 <= 0 and var_591_0 or var_591_0 * (utf8.len(var_591_1) / 35)) > 0 and var_591_0 < var_591_3 then
					arg_588_1.talkMaxDuration = var_591_3

					if var_591_3 + 0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_3 + 0
					end
				end

				arg_588_1.text_.text = var_591_1
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_4 = math.max(var_591_0, arg_588_1.talkMaxDuration)

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_4 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - 0) / var_591_4

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= 0 + var_591_4 and arg_588_1.time_ < 0 + var_591_4 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play1107506146 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 1107506146
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play1107506147(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0.125

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				arg_592_1.leftNameTxt_.text = arg_592_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, true)
				arg_592_1.iconController_:SetSelectedState("hero")

				arg_592_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_592_1.callingController_:SetSelectedState("normal")

				arg_592_1.keyicon_.color = Color.New(1, 1, 1)
				arg_592_1.icon_.color = Color.New(1, 1, 1)

				local var_595_1 = arg_592_1:FormatText(arg_592_1:GetWordFromCfg(1107506146).content)

				arg_592_1.text_.text = var_595_1

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_3 = 5 <= 0 and var_595_0 or var_595_0 * (utf8.len(var_595_1) / 5)

				if (5 <= 0 and var_595_0 or var_595_0 * (utf8.len(var_595_1) / 5)) > 0 and var_595_0 < var_595_3 then
					arg_592_1.talkMaxDuration = var_595_3

					if var_595_3 + 0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_3 + 0
					end
				end

				arg_592_1.text_.text = var_595_1
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_4 = math.max(var_595_0, arg_592_1.talkMaxDuration)

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_4 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - 0) / var_595_4

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= 0 + var_595_4 and arg_592_1.time_ < 0 + var_595_4 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play1107506147 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 1107506147
		arg_596_1.duration_ = 3.93

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play1107506148(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 and not isNil(arg_596_1.actors_["1075ui_actor"]) and arg_596_1.var_.characterEffect1075ui_actor == nil then
				arg_596_1.var_.characterEffect1075ui_actor = arg_596_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_0 = 0.200000002980232

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_0 and not isNil(arg_596_1.actors_["1075ui_actor"]) then
				if arg_596_1.var_.characterEffect1075ui_actor and not isNil(arg_596_1.actors_["1075ui_actor"]) then
					arg_596_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_596_1.time_ >= 0 + var_599_0 and arg_596_1.time_ < 0 + var_599_0 + arg_599_0 and not isNil(arg_596_1.actors_["1075ui_actor"]) and arg_596_1.var_.characterEffect1075ui_actor then
				arg_596_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_599_2 = 0
			local var_599_3 = 0.5

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_2 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, true)
				arg_596_1.iconController_:SetSelectedState("hero")

				arg_596_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_596_1.callingController_:SetSelectedState("normal")

				arg_596_1.keyicon_.color = Color.New(1, 1, 1)
				arg_596_1.icon_.color = Color.New(1, 1, 1)

				local var_599_4 = arg_596_1:GetWordFromCfg(1107506147)
				local var_599_5 = arg_596_1:FormatText(var_599_4.content)

				arg_596_1.text_.text = var_599_5

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_7 = 20 <= 0 and var_599_3 or var_599_3 * (utf8.len(var_599_5) / 20)

				if (20 <= 0 and var_599_3 or var_599_3 * (utf8.len(var_599_5) / 20)) > 0 and var_599_3 < var_599_7 then
					arg_596_1.talkMaxDuration = var_599_7

					if var_599_7 + var_599_2 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_7 + var_599_2
					end
				end

				arg_596_1.text_.text = var_599_5
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506147", "story_v_side_new_1107506.awb") ~= 0 then
					local var_599_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506147", "story_v_side_new_1107506.awb") / 1000

					if var_599_8 + var_599_2 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_8 + var_599_2
					end

					if var_599_4.prefab_name ~= "" and arg_596_1.actors_[var_599_4.prefab_name] ~= nil then
						local var_599_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_4.prefab_name].transform, "story_v_side_new_1107506", "1107506147", "story_v_side_new_1107506.awb")

						arg_596_1:RecordAudio("1107506147", var_599_9)
						arg_596_1:RecordAudio("1107506147", var_599_9)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506147", "story_v_side_new_1107506.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506147", "story_v_side_new_1107506.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_10 = math.max(var_599_3, arg_596_1.talkMaxDuration)

			if var_599_2 <= arg_596_1.time_ and arg_596_1.time_ < var_599_2 + var_599_10 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_2) / var_599_10

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_2 + var_599_10 and arg_596_1.time_ < var_599_2 + var_599_10 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play1107506148 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 1107506148
		arg_600_1.duration_ = 6.43

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play1107506149(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = 0.675

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				arg_600_1.leftNameTxt_.text = arg_600_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, true)
				arg_600_1.iconController_:SetSelectedState("hero")

				arg_600_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_600_1.callingController_:SetSelectedState("normal")

				arg_600_1.keyicon_.color = Color.New(1, 1, 1)
				arg_600_1.icon_.color = Color.New(1, 1, 1)

				local var_603_1 = arg_600_1:GetWordFromCfg(1107506148)
				local var_603_2 = arg_600_1:FormatText(var_603_1.content)

				arg_600_1.text_.text = var_603_2

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_4 = 27 <= 0 and var_603_0 or var_603_0 * (utf8.len(var_603_2) / 27)

				if (27 <= 0 and var_603_0 or var_603_0 * (utf8.len(var_603_2) / 27)) > 0 and var_603_0 < var_603_4 then
					arg_600_1.talkMaxDuration = var_603_4

					if var_603_4 + 0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_4 + 0
					end
				end

				arg_600_1.text_.text = var_603_2
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506148", "story_v_side_new_1107506.awb") ~= 0 then
					local var_603_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506148", "story_v_side_new_1107506.awb") / 1000

					if var_603_5 + 0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_5 + 0
					end

					if var_603_1.prefab_name ~= "" and arg_600_1.actors_[var_603_1.prefab_name] ~= nil then
						local var_603_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_600_1.actors_[var_603_1.prefab_name].transform, "story_v_side_new_1107506", "1107506148", "story_v_side_new_1107506.awb")

						arg_600_1:RecordAudio("1107506148", var_603_6)
						arg_600_1:RecordAudio("1107506148", var_603_6)
					else
						arg_600_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506148", "story_v_side_new_1107506.awb")
					end

					arg_600_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506148", "story_v_side_new_1107506.awb")
				end

				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_7 = math.max(var_603_0, arg_600_1.talkMaxDuration)

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_7 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - 0) / var_603_7

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= 0 + var_603_7 and arg_600_1.time_ < 0 + var_603_7 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play1107506149 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 1107506149
		arg_604_1.duration_ = 8.53

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play1107506150(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = 0.825

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, true)
				arg_604_1.iconController_:SetSelectedState("hero")

				arg_604_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_604_1.callingController_:SetSelectedState("normal")

				arg_604_1.keyicon_.color = Color.New(1, 1, 1)
				arg_604_1.icon_.color = Color.New(1, 1, 1)

				local var_607_1 = arg_604_1:GetWordFromCfg(1107506149)
				local var_607_2 = arg_604_1:FormatText(var_607_1.content)

				arg_604_1.text_.text = var_607_2

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_4 = 33 <= 0 and var_607_0 or var_607_0 * (utf8.len(var_607_2) / 33)

				if (33 <= 0 and var_607_0 or var_607_0 * (utf8.len(var_607_2) / 33)) > 0 and var_607_0 < var_607_4 then
					arg_604_1.talkMaxDuration = var_607_4

					if var_607_4 + 0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_4 + 0
					end
				end

				arg_604_1.text_.text = var_607_2
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506149", "story_v_side_new_1107506.awb") ~= 0 then
					local var_607_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506149", "story_v_side_new_1107506.awb") / 1000

					if var_607_5 + 0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_5 + 0
					end

					if var_607_1.prefab_name ~= "" and arg_604_1.actors_[var_607_1.prefab_name] ~= nil then
						local var_607_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_1.prefab_name].transform, "story_v_side_new_1107506", "1107506149", "story_v_side_new_1107506.awb")

						arg_604_1:RecordAudio("1107506149", var_607_6)
						arg_604_1:RecordAudio("1107506149", var_607_6)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506149", "story_v_side_new_1107506.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506149", "story_v_side_new_1107506.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_7 = math.max(var_607_0, arg_604_1.talkMaxDuration)

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_7 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - 0) / var_607_7

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= 0 + var_607_7 and arg_604_1.time_ < 0 + var_607_7 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play1107506150 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 1107506150
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play1107506151(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 and not isNil(arg_608_1.actors_["1075ui_actor"]) and arg_608_1.var_.characterEffect1075ui_actor == nil then
				arg_608_1.var_.characterEffect1075ui_actor = arg_608_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_611_0 = 0.200000002980232

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_0 and not isNil(arg_608_1.actors_["1075ui_actor"]) then
				if arg_608_1.var_.characterEffect1075ui_actor and not isNil(arg_608_1.actors_["1075ui_actor"]) then
					arg_608_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_608_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_608_1.time_ - 0) / var_611_0)
				end
			end

			if arg_608_1.time_ >= 0 + var_611_0 and arg_608_1.time_ < 0 + var_611_0 + arg_611_0 and not isNil(arg_608_1.actors_["1075ui_actor"]) and arg_608_1.var_.characterEffect1075ui_actor then
				arg_608_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_608_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_611_1 = 0
			local var_611_2 = 0.5

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				arg_608_1.leftNameTxt_.text = arg_608_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, true)
				arg_608_1.iconController_:SetSelectedState("hero")

				arg_608_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_608_1.callingController_:SetSelectedState("normal")

				arg_608_1.keyicon_.color = Color.New(1, 1, 1)
				arg_608_1.icon_.color = Color.New(1, 1, 1)

				local var_611_3 = arg_608_1:FormatText(arg_608_1:GetWordFromCfg(1107506150).content)

				arg_608_1.text_.text = var_611_3

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_5 = 20 <= 0 and var_611_2 or var_611_2 * (utf8.len(var_611_3) / 20)

				if (20 <= 0 and var_611_2 or var_611_2 * (utf8.len(var_611_3) / 20)) > 0 and var_611_2 < var_611_5 then
					arg_608_1.talkMaxDuration = var_611_5

					if var_611_5 + var_611_1 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_5 + var_611_1
					end
				end

				arg_608_1.text_.text = var_611_3
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_6 = math.max(var_611_2, arg_608_1.talkMaxDuration)

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_6 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_1) / var_611_6

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_1 + var_611_6 and arg_608_1.time_ < var_611_1 + var_611_6 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play1107506151 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 1107506151
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play1107506152(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0.3

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, true)
				arg_612_1.iconController_:SetSelectedState("hero")

				arg_612_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_612_1.callingController_:SetSelectedState("normal")

				arg_612_1.keyicon_.color = Color.New(1, 1, 1)
				arg_612_1.icon_.color = Color.New(1, 1, 1)

				local var_615_1 = arg_612_1:FormatText(arg_612_1:GetWordFromCfg(1107506151).content)

				arg_612_1.text_.text = var_615_1

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_3 = 12 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_1) / 12)

				if (12 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_1) / 12)) > 0 and var_615_0 < var_615_3 then
					arg_612_1.talkMaxDuration = var_615_3

					if var_615_3 + 0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_3 + 0
					end
				end

				arg_612_1.text_.text = var_615_1
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_4 = math.max(var_615_0, arg_612_1.talkMaxDuration)

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_4 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - 0) / var_615_4

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= 0 + var_615_4 and arg_612_1.time_ < 0 + var_615_4 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play1107506152 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 1107506152
		arg_616_1.duration_ = 7

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play1107506153(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			if arg_616_1.bgs_.ST37 == nil then
				local var_619_0 = Object.Instantiate(arg_616_1.paintGo_)

				var_619_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")
				var_619_0.name = "ST37"
				var_619_0.transform.parent = arg_616_1.stage_.transform
				var_619_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_616_1.bgs_.ST37 = var_619_0
			end

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				local var_619_1 = arg_616_1.bgs_.ST37

				arg_616_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_619_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_619_2 = var_619_1:GetComponent("SpriteRenderer")

				if var_619_2 and var_619_2.sprite then
					local var_619_3 = 2 * (var_619_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_619_1.transform.localScale = Vector3.New(var_619_3 / var_619_2.sprite.bounds.size.y < var_619_3 * manager.ui.mainCameraCom_.aspect / var_619_2.sprite.bounds.size.x and var_619_3 * manager.ui.mainCameraCom_.aspect / var_619_2.sprite.bounds.size.x or var_619_3 / var_619_2.sprite.bounds.size.y, var_619_3 / var_619_2.sprite.bounds.size.y < var_619_3 * manager.ui.mainCameraCom_.aspect / var_619_2.sprite.bounds.size.x and var_619_3 * manager.ui.mainCameraCom_.aspect / var_619_2.sprite.bounds.size.x or var_619_3 / var_619_2.sprite.bounds.size.y, 0)
				end

				for iter_619_0, iter_619_1 in pairs(arg_616_1.bgs_) do
					if iter_619_0 ~= "ST37" then
						iter_619_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_619_4 = 2

			if 2 < arg_616_1.time_ and arg_616_1.time_ <= var_619_4 + arg_619_0 then
				arg_616_1.allBtn_.enabled = false
			end

			if arg_616_1.time_ >= var_619_4 + 0.3 and arg_616_1.time_ < var_619_4 + 0.3 + arg_619_0 then
				arg_616_1.allBtn_.enabled = true
			end

			local var_619_5 = 0

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_5 + arg_619_0 then
				arg_616_1.mask_.enabled = true
				arg_616_1.mask_.raycastTarget = true

				arg_616_1:SetGaussion(false)
			end

			local var_619_6 = 2

			if var_619_5 <= arg_616_1.time_ and arg_616_1.time_ < var_619_5 + var_619_6 then
				local var_619_7 = Color.New(0, 0, 0)

				var_619_7.a = Mathf.Lerp(1, 0, (arg_616_1.time_ - var_619_5) / var_619_6)
				arg_616_1.mask_.color = var_619_7
			end

			if arg_616_1.time_ >= var_619_5 + var_619_6 and arg_616_1.time_ < var_619_5 + var_619_6 + arg_619_0 then
				local var_619_8 = Color.New(0, 0, 0)

				arg_616_1.mask_.enabled = false
				var_619_8.a = 0
				arg_616_1.mask_.color = var_619_8
			end

			if 0.233333333333333 < arg_616_1.time_ and arg_616_1.time_ <= 0.233333333333333 + arg_619_0 then
				arg_616_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_rain_inside01", "")
			end

			local var_619_11 = "ST37_blur"

			if arg_616_1.bgs_.ST37_blur == nil then
				local var_619_12 = Object.Instantiate(arg_616_1.blurPaintGo_)

				var_619_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_619_11)
				var_619_12.name = var_619_11
				var_619_12.transform.parent = arg_616_1.stage_.transform
				var_619_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_616_1.bgs_[var_619_11] = var_619_12
			end

			local var_619_13 = 0
			local var_619_14 = arg_616_1.bgs_[var_619_11]

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_13 + arg_619_0 then
				var_619_14.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_619_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_619_15 = var_619_14:GetComponent("SpriteRenderer")

				if var_619_15 and var_619_15.sprite then
					local var_619_16 = 2 * (var_619_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_619_14.transform.localScale = Vector3.New(var_619_16 / var_619_15.sprite.bounds.size.y < var_619_16 * manager.ui.mainCameraCom_.aspect / var_619_15.sprite.bounds.size.x and var_619_16 * manager.ui.mainCameraCom_.aspect / var_619_15.sprite.bounds.size.x or var_619_16 / var_619_15.sprite.bounds.size.y, var_619_16 / var_619_15.sprite.bounds.size.y < var_619_16 * manager.ui.mainCameraCom_.aspect / var_619_15.sprite.bounds.size.x and var_619_16 * manager.ui.mainCameraCom_.aspect / var_619_15.sprite.bounds.size.x or var_619_16 / var_619_15.sprite.bounds.size.y, 0)
				end
			end

			local var_619_17 = 3

			if var_619_13 <= arg_616_1.time_ and arg_616_1.time_ < var_619_13 + var_619_17 then
				local var_619_18 = Color.New(1, 1, 1)

				var_619_18.a = Mathf.Lerp(1, 0, (arg_616_1.time_ - var_619_13) / var_619_17)

				var_619_14:GetComponent("SpriteRenderer").material:SetColor("_Color", var_619_18)
			end

			local var_619_19 = 2

			if 2 < arg_616_1.time_ and arg_616_1.time_ <= var_619_19 + arg_619_0 then
				arg_616_1.allBtn_.enabled = false
			end

			if arg_616_1.time_ >= var_619_19 + 1 and arg_616_1.time_ < var_619_19 + 1 + arg_619_0 then
				arg_616_1.allBtn_.enabled = true
			end

			if arg_616_1.frameCnt_ <= 1 then
				arg_616_1.dialog_:SetActive(false)
			end

			local var_619_20 = 2
			local var_619_21 = 0.85

			if 2 < arg_616_1.time_ and arg_616_1.time_ <= var_619_20 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0

				arg_616_1.dialog_:SetActive(true)

				arg_616_1.dialogCg_.alpha = 0

				local var_619_22 = LeanTween.value(arg_616_1.dialog_, 0, 1, 0.3)

				var_619_22:setOnUpdate(LuaHelper.FloatAction(function(arg_620_0)
					arg_616_1.dialogCg_.alpha = arg_620_0
				end))
				var_619_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_616_1.dialog_)
					var_619_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_616_1.duration_ = arg_616_1.duration_ + 0.3

				SetActive(arg_616_1.leftNameGo_, false)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_23 = arg_616_1:FormatText(arg_616_1:GetWordFromCfg(1107506152).content)

				arg_616_1.text_.text = var_619_23

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_25 = 34 <= 0 and var_619_21 or var_619_21 * (utf8.len(var_619_23) / 34)

				if (34 <= 0 and var_619_21 or var_619_21 * (utf8.len(var_619_23) / 34)) > 0 and var_619_21 < var_619_25 then
					arg_616_1.talkMaxDuration = var_619_25
					var_619_20 = var_619_20 + 0.3

					if var_619_25 + var_619_20 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_25 + var_619_20
					end
				end

				arg_616_1.text_.text = var_619_23
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_26 = var_619_20 + 0.3
			local var_619_27 = math.max(var_619_21, arg_616_1.talkMaxDuration)

			if var_619_20 + 0.3 <= arg_616_1.time_ and arg_616_1.time_ < var_619_26 + var_619_27 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_26) / var_619_27

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_26 + var_619_27 and arg_616_1.time_ < var_619_26 + var_619_27 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play1107506153 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1107506153
		arg_622_1.duration_ = 5

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1107506154(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = 0.475

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, true)
				arg_622_1.iconController_:SetSelectedState("hero")

				arg_622_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_622_1.callingController_:SetSelectedState("normal")

				arg_622_1.keyicon_.color = Color.New(1, 1, 1)
				arg_622_1.icon_.color = Color.New(1, 1, 1)

				local var_625_1 = arg_622_1:FormatText(arg_622_1:GetWordFromCfg(1107506153).content)

				arg_622_1.text_.text = var_625_1

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_3 = 19 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_1) / 19)

				if (19 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_1) / 19)) > 0 and var_625_0 < var_625_3 then
					arg_622_1.talkMaxDuration = var_625_3

					if var_625_3 + 0 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_3 + 0
					end
				end

				arg_622_1.text_.text = var_625_1
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)
				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_4 = math.max(var_625_0, arg_622_1.talkMaxDuration)

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_4 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - 0) / var_625_4

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= 0 + var_625_4 and arg_622_1.time_ < 0 + var_625_4 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play1107506154 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 1107506154
		arg_626_1.duration_ = 5

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play1107506155(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 0.15

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				arg_626_1.leftNameTxt_.text = arg_626_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, true)
				arg_626_1.iconController_:SetSelectedState("hero")

				arg_626_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_626_1.callingController_:SetSelectedState("normal")

				arg_626_1.keyicon_.color = Color.New(1, 1, 1)
				arg_626_1.icon_.color = Color.New(1, 1, 1)

				local var_629_1 = arg_626_1:FormatText(arg_626_1:GetWordFromCfg(1107506154).content)

				arg_626_1.text_.text = var_629_1

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_3 = 6 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_1) / 6)

				if (6 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_1) / 6)) > 0 and var_629_0 < var_629_3 then
					arg_626_1.talkMaxDuration = var_629_3

					if var_629_3 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_3 + 0
					end
				end

				arg_626_1.text_.text = var_629_1
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)
				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_4 = math.max(var_629_0, arg_626_1.talkMaxDuration)

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_4 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - 0) / var_629_4

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= 0 + var_629_4 and arg_626_1.time_ < 0 + var_629_4 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play1107506155 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 1107506155
		arg_630_1.duration_ = 5

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play1107506156(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = 0.675

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, false)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_1 = arg_630_1:FormatText(arg_630_1:GetWordFromCfg(1107506155).content)

				arg_630_1.text_.text = var_633_1

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_3 = 28 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_1) / 28)

				if (28 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_1) / 28)) > 0 and var_633_0 < var_633_3 then
					arg_630_1.talkMaxDuration = var_633_3

					if var_633_3 + 0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_3 + 0
					end
				end

				arg_630_1.text_.text = var_633_1
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)
				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_4 = math.max(var_633_0, arg_630_1.talkMaxDuration)

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_4 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - 0) / var_633_4

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= 0 + var_633_4 and arg_630_1.time_ < 0 + var_633_4 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play1107506156 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 1107506156
		arg_634_1.duration_ = 5

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play1107506157(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			local var_637_0 = 0.475

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, true)
				arg_634_1.iconController_:SetSelectedState("hero")

				arg_634_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_634_1.callingController_:SetSelectedState("normal")

				arg_634_1.keyicon_.color = Color.New(1, 1, 1)
				arg_634_1.icon_.color = Color.New(1, 1, 1)

				local var_637_1 = arg_634_1:FormatText(arg_634_1:GetWordFromCfg(1107506156).content)

				arg_634_1.text_.text = var_637_1

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_3 = 19 <= 0 and var_637_0 or var_637_0 * (utf8.len(var_637_1) / 19)

				if (19 <= 0 and var_637_0 or var_637_0 * (utf8.len(var_637_1) / 19)) > 0 and var_637_0 < var_637_3 then
					arg_634_1.talkMaxDuration = var_637_3

					if var_637_3 + 0 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_3 + 0
					end
				end

				arg_634_1.text_.text = var_637_1
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)
				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_4 = math.max(var_637_0, arg_634_1.talkMaxDuration)

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_4 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - 0) / var_637_4

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= 0 + var_637_4 and arg_634_1.time_ < 0 + var_637_4 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	Play1107506157 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 1107506157
		arg_638_1.duration_ = 5

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play1107506158(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			local var_641_0 = 0.775

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, false)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_1 = arg_638_1:FormatText(arg_638_1:GetWordFromCfg(1107506157).content)

				arg_638_1.text_.text = var_641_1

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_3 = 31 <= 0 and var_641_0 or var_641_0 * (utf8.len(var_641_1) / 31)

				if (31 <= 0 and var_641_0 or var_641_0 * (utf8.len(var_641_1) / 31)) > 0 and var_641_0 < var_641_3 then
					arg_638_1.talkMaxDuration = var_641_3

					if var_641_3 + 0 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_3 + 0
					end
				end

				arg_638_1.text_.text = var_641_1
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)
				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_4 = math.max(var_641_0, arg_638_1.talkMaxDuration)

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_4 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - 0) / var_641_4

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= 0 + var_641_4 and arg_638_1.time_ < 0 + var_641_4 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {}

		arg_638_1:InitPlayNodeList()
	end,
	Play1107506158 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 1107506158
		arg_642_1.duration_ = 2.27

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play1107506159(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 and not isNil(arg_642_1.actors_["1075ui_actor"]) and arg_642_1.var_.characterEffect1075ui_actor == nil then
				arg_642_1.var_.characterEffect1075ui_actor = arg_642_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_645_0 = 0.200000002980232

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_0 and not isNil(arg_642_1.actors_["1075ui_actor"]) then
				if arg_642_1.var_.characterEffect1075ui_actor and not isNil(arg_642_1.actors_["1075ui_actor"]) then
					arg_642_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_642_1.time_ >= 0 + var_645_0 and arg_642_1.time_ < 0 + var_645_0 + arg_645_0 and not isNil(arg_642_1.actors_["1075ui_actor"]) and arg_642_1.var_.characterEffect1075ui_actor then
				arg_642_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_645_2 = 0
			local var_645_3 = 0.075

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= var_645_2 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				arg_642_1.leftNameTxt_.text = arg_642_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, true)
				arg_642_1.iconController_:SetSelectedState("hero")

				arg_642_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_642_1.callingController_:SetSelectedState("normal")

				arg_642_1.keyicon_.color = Color.New(1, 1, 1)
				arg_642_1.icon_.color = Color.New(1, 1, 1)

				local var_645_4 = arg_642_1:GetWordFromCfg(1107506158)
				local var_645_5 = arg_642_1:FormatText(var_645_4.content)

				arg_642_1.text_.text = var_645_5

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_7 = 3 <= 0 and var_645_3 or var_645_3 * (utf8.len(var_645_5) / 3)

				if (3 <= 0 and var_645_3 or var_645_3 * (utf8.len(var_645_5) / 3)) > 0 and var_645_3 < var_645_7 then
					arg_642_1.talkMaxDuration = var_645_7

					if var_645_7 + var_645_2 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_7 + var_645_2
					end
				end

				arg_642_1.text_.text = var_645_5
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506158", "story_v_side_new_1107506.awb") ~= 0 then
					local var_645_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506158", "story_v_side_new_1107506.awb") / 1000

					if var_645_8 + var_645_2 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_8 + var_645_2
					end

					if var_645_4.prefab_name ~= "" and arg_642_1.actors_[var_645_4.prefab_name] ~= nil then
						local var_645_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_642_1.actors_[var_645_4.prefab_name].transform, "story_v_side_new_1107506", "1107506158", "story_v_side_new_1107506.awb")

						arg_642_1:RecordAudio("1107506158", var_645_9)
						arg_642_1:RecordAudio("1107506158", var_645_9)
					else
						arg_642_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506158", "story_v_side_new_1107506.awb")
					end

					arg_642_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506158", "story_v_side_new_1107506.awb")
				end

				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_10 = math.max(var_645_3, arg_642_1.talkMaxDuration)

			if var_645_2 <= arg_642_1.time_ and arg_642_1.time_ < var_645_2 + var_645_10 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_2) / var_645_10

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_2 + var_645_10 and arg_642_1.time_ < var_645_2 + var_645_10 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play1107506159 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 1107506159
		arg_646_1.duration_ = 5

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play1107506160(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 and not isNil(arg_646_1.actors_["1075ui_actor"]) and arg_646_1.var_.characterEffect1075ui_actor == nil then
				arg_646_1.var_.characterEffect1075ui_actor = arg_646_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_649_0 = 0.200000002980232

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_0 and not isNil(arg_646_1.actors_["1075ui_actor"]) then
				if arg_646_1.var_.characterEffect1075ui_actor and not isNil(arg_646_1.actors_["1075ui_actor"]) then
					arg_646_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_646_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_646_1.time_ - 0) / var_649_0)
				end
			end

			if arg_646_1.time_ >= 0 + var_649_0 and arg_646_1.time_ < 0 + var_649_0 + arg_649_0 and not isNil(arg_646_1.actors_["1075ui_actor"]) and arg_646_1.var_.characterEffect1075ui_actor then
				arg_646_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_646_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_649_1 = 0
			local var_649_2 = 1.1

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= var_649_1 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, false)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_3 = arg_646_1:FormatText(arg_646_1:GetWordFromCfg(1107506159).content)

				arg_646_1.text_.text = var_649_3

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_5 = 44 <= 0 and var_649_2 or var_649_2 * (utf8.len(var_649_3) / 44)

				if (44 <= 0 and var_649_2 or var_649_2 * (utf8.len(var_649_3) / 44)) > 0 and var_649_2 < var_649_5 then
					arg_646_1.talkMaxDuration = var_649_5

					if var_649_5 + var_649_1 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_5 + var_649_1
					end
				end

				arg_646_1.text_.text = var_649_3
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_6 = math.max(var_649_2, arg_646_1.talkMaxDuration)

			if var_649_1 <= arg_646_1.time_ and arg_646_1.time_ < var_649_1 + var_649_6 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_1) / var_649_6

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_1 + var_649_6 and arg_646_1.time_ < var_649_1 + var_649_6 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {}

		arg_646_1:InitPlayNodeList()
	end,
	Play1107506160 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 1107506160
		arg_650_1.duration_ = 9

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play1107506161(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			if arg_650_1.bgs_.R7502 == nil then
				local var_653_0 = Object.Instantiate(arg_650_1.paintGo_)

				var_653_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R7502")
				var_653_0.name = "R7502"
				var_653_0.transform.parent = arg_650_1.stage_.transform
				var_653_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_650_1.bgs_.R7502 = var_653_0
			end

			if 2 < arg_650_1.time_ and arg_650_1.time_ <= 2 + arg_653_0 then
				local var_653_1 = arg_650_1.bgs_.R7502

				arg_650_1.bgs_.R7502.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_653_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_653_2 = var_653_1:GetComponent("SpriteRenderer")

				if var_653_2 and var_653_2.sprite then
					local var_653_3 = 2 * (var_653_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_653_1.transform.localScale = Vector3.New(var_653_3 / var_653_2.sprite.bounds.size.y < var_653_3 * manager.ui.mainCameraCom_.aspect / var_653_2.sprite.bounds.size.x and var_653_3 * manager.ui.mainCameraCom_.aspect / var_653_2.sprite.bounds.size.x or var_653_3 / var_653_2.sprite.bounds.size.y, var_653_3 / var_653_2.sprite.bounds.size.y < var_653_3 * manager.ui.mainCameraCom_.aspect / var_653_2.sprite.bounds.size.x and var_653_3 * manager.ui.mainCameraCom_.aspect / var_653_2.sprite.bounds.size.x or var_653_3 / var_653_2.sprite.bounds.size.y, 0)
				end

				for iter_653_0, iter_653_1 in pairs(arg_650_1.bgs_) do
					if iter_653_0 ~= "R7502" then
						iter_653_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_653_4 = 4

			if 4 < arg_650_1.time_ and arg_650_1.time_ <= var_653_4 + arg_653_0 then
				arg_650_1.allBtn_.enabled = false
			end

			if arg_650_1.time_ >= var_653_4 + 0.3 and arg_650_1.time_ < var_653_4 + 0.3 + arg_653_0 then
				arg_650_1.allBtn_.enabled = true
			end

			local var_653_5 = 0

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= var_653_5 + arg_653_0 then
				arg_650_1.mask_.enabled = true
				arg_650_1.mask_.raycastTarget = true

				arg_650_1:SetGaussion(false)
			end

			local var_653_6 = 2

			if var_653_5 <= arg_650_1.time_ and arg_650_1.time_ < var_653_5 + var_653_6 then
				local var_653_7 = Color.New(0, 0, 0)

				var_653_7.a = Mathf.Lerp(0, 1, (arg_650_1.time_ - var_653_5) / var_653_6)
				arg_650_1.mask_.color = var_653_7
			end

			if arg_650_1.time_ >= var_653_5 + var_653_6 and arg_650_1.time_ < var_653_5 + var_653_6 + arg_653_0 then
				local var_653_8 = Color.New(0, 0, 0)

				var_653_8.a = 1
				arg_650_1.mask_.color = var_653_8
			end

			local var_653_9 = 2

			if 2 < arg_650_1.time_ and arg_650_1.time_ <= var_653_9 + arg_653_0 then
				arg_650_1.mask_.enabled = true
				arg_650_1.mask_.raycastTarget = true

				arg_650_1:SetGaussion(false)
			end

			local var_653_10 = 2

			if var_653_9 <= arg_650_1.time_ and arg_650_1.time_ < var_653_9 + var_653_10 then
				local var_653_11 = Color.New(0, 0, 0)

				var_653_11.a = Mathf.Lerp(1, 0, (arg_650_1.time_ - var_653_9) / var_653_10)
				arg_650_1.mask_.color = var_653_11
			end

			if arg_650_1.time_ >= var_653_9 + var_653_10 and arg_650_1.time_ < var_653_9 + var_653_10 + arg_653_0 then
				local var_653_12 = Color.New(0, 0, 0)

				arg_650_1.mask_.enabled = false
				var_653_12.a = 0
				arg_650_1.mask_.color = var_653_12
			end

			local var_653_13 = arg_650_1.bgs_.R7502.transform

			if 2 < arg_650_1.time_ and arg_650_1.time_ <= 2 + arg_653_0 then
				arg_650_1.var_.moveOldPosR7502 = var_653_13.localPosition
			end

			local var_653_14 = 0.001

			if 2 <= arg_650_1.time_ and arg_650_1.time_ < 2 + var_653_14 then
				var_653_13.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPosR7502, Vector3.New(-1.5, 0.15, 5), (arg_650_1.time_ - 2) / var_653_14)
			end

			if arg_650_1.time_ >= 2 + var_653_14 and arg_650_1.time_ < 2 + var_653_14 + arg_653_0 then
				var_653_13.localPosition = Vector3.New(-1.5, 0.15, 5)
			end

			local var_653_15 = arg_650_1.bgs_.R7502.transform

			if 2.01666666666667 < arg_650_1.time_ and arg_650_1.time_ <= 2.01666666666667 + arg_653_0 then
				arg_650_1.var_.moveOldPosR7502 = var_653_15.localPosition
			end

			local var_653_16 = 5.5

			if 2.01666666666667 <= arg_650_1.time_ and arg_650_1.time_ < 2.01666666666667 + var_653_16 then
				var_653_15.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPosR7502, Vector3.New(-1.5, 0.15, 5.5), (arg_650_1.time_ - 2.01666666666667) / var_653_16)
			end

			if arg_650_1.time_ >= 2.01666666666667 + var_653_16 and arg_650_1.time_ < 2.01666666666667 + var_653_16 + arg_653_0 then
				var_653_15.localPosition = Vector3.New(-1.5, 0.15, 5.5)
			end

			local var_653_17 = 4

			if 4 < arg_650_1.time_ and arg_650_1.time_ <= var_653_17 + arg_653_0 then
				arg_650_1.allBtn_.enabled = false
			end

			if arg_650_1.time_ >= var_653_17 + 3.51666666666667 and arg_650_1.time_ < var_653_17 + 3.51666666666667 + arg_653_0 then
				arg_650_1.allBtn_.enabled = true
			end

			if arg_650_1.frameCnt_ <= 1 then
				arg_650_1.dialog_:SetActive(false)
			end

			local var_653_18 = 4
			local var_653_19 = 0.15

			if 4 < arg_650_1.time_ and arg_650_1.time_ <= var_653_18 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0

				arg_650_1.dialog_:SetActive(true)

				arg_650_1.dialogCg_.alpha = 0

				local var_653_20 = LeanTween.value(arg_650_1.dialog_, 0, 1, 0.3)

				var_653_20:setOnUpdate(LuaHelper.FloatAction(function(arg_654_0)
					arg_650_1.dialogCg_.alpha = arg_654_0
				end))
				var_653_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_650_1.dialog_)
					var_653_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_650_1.duration_ = arg_650_1.duration_ + 0.3

				SetActive(arg_650_1.leftNameGo_, true)

				arg_650_1.leftNameTxt_.text = arg_650_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, true)
				arg_650_1.iconController_:SetSelectedState("hero")

				arg_650_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_650_1.callingController_:SetSelectedState("normal")

				arg_650_1.keyicon_.color = Color.New(1, 1, 1)
				arg_650_1.icon_.color = Color.New(1, 1, 1)

				local var_653_21 = arg_650_1:FormatText(arg_650_1:GetWordFromCfg(1107506160).content)

				arg_650_1.text_.text = var_653_21

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_23 = 6 <= 0 and var_653_19 or var_653_19 * (utf8.len(var_653_21) / 6)

				if (6 <= 0 and var_653_19 or var_653_19 * (utf8.len(var_653_21) / 6)) > 0 and var_653_19 < var_653_23 then
					arg_650_1.talkMaxDuration = var_653_23
					var_653_18 = var_653_18 + 0.3

					if var_653_23 + var_653_18 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_23 + var_653_18
					end
				end

				arg_650_1.text_.text = var_653_21
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)
				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_24 = var_653_18 + 0.3
			local var_653_25 = math.max(var_653_19, arg_650_1.talkMaxDuration)

			if var_653_18 + 0.3 <= arg_650_1.time_ and arg_650_1.time_ < var_653_24 + var_653_25 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_24) / var_653_25

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_24 + var_653_25 and arg_650_1.time_ < var_653_24 + var_653_25 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R7502",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R7502",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_650_1:InitPlayNodeList()
	end,
	Play1107506161 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1107506161
		arg_656_1.duration_ = 4.17

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1107506162(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 and not isNil(arg_656_1.actors_["1075ui_actor"]) and arg_656_1.var_.characterEffect1075ui_actor == nil then
				arg_656_1.var_.characterEffect1075ui_actor = arg_656_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_659_0 = 0.200000002980232

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_0 and not isNil(arg_656_1.actors_["1075ui_actor"]) then
				if arg_656_1.var_.characterEffect1075ui_actor and not isNil(arg_656_1.actors_["1075ui_actor"]) then
					arg_656_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_656_1.time_ >= 0 + var_659_0 and arg_656_1.time_ < 0 + var_659_0 + arg_659_0 and not isNil(arg_656_1.actors_["1075ui_actor"]) and arg_656_1.var_.characterEffect1075ui_actor then
				arg_656_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_659_2 = 0
			local var_659_3 = 0.25

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_2 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				arg_656_1.leftNameTxt_.text = arg_656_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_4 = arg_656_1:GetWordFromCfg(1107506161)
				local var_659_5 = arg_656_1:FormatText(var_659_4.content)

				arg_656_1.text_.text = var_659_5

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_7 = 10 <= 0 and var_659_3 or var_659_3 * (utf8.len(var_659_5) / 10)

				if (10 <= 0 and var_659_3 or var_659_3 * (utf8.len(var_659_5) / 10)) > 0 and var_659_3 < var_659_7 then
					arg_656_1.talkMaxDuration = var_659_7

					if var_659_7 + var_659_2 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_7 + var_659_2
					end
				end

				arg_656_1.text_.text = var_659_5
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506161", "story_v_side_new_1107506.awb") ~= 0 then
					local var_659_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506161", "story_v_side_new_1107506.awb") / 1000

					if var_659_8 + var_659_2 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_8 + var_659_2
					end

					if var_659_4.prefab_name ~= "" and arg_656_1.actors_[var_659_4.prefab_name] ~= nil then
						local var_659_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_4.prefab_name].transform, "story_v_side_new_1107506", "1107506161", "story_v_side_new_1107506.awb")

						arg_656_1:RecordAudio("1107506161", var_659_9)
						arg_656_1:RecordAudio("1107506161", var_659_9)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506161", "story_v_side_new_1107506.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506161", "story_v_side_new_1107506.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_10 = math.max(var_659_3, arg_656_1.talkMaxDuration)

			if var_659_2 <= arg_656_1.time_ and arg_656_1.time_ < var_659_2 + var_659_10 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_2) / var_659_10

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_2 + var_659_10 and arg_656_1.time_ < var_659_2 + var_659_10 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play1107506162 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1107506162
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1107506163(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 and not isNil(arg_660_1.actors_["1075ui_actor"]) and arg_660_1.var_.characterEffect1075ui_actor == nil then
				arg_660_1.var_.characterEffect1075ui_actor = arg_660_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_663_0 = 0.200000002980232

			if 0 <= arg_660_1.time_ and arg_660_1.time_ < 0 + var_663_0 and not isNil(arg_660_1.actors_["1075ui_actor"]) then
				if arg_660_1.var_.characterEffect1075ui_actor and not isNil(arg_660_1.actors_["1075ui_actor"]) then
					arg_660_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_660_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_660_1.time_ - 0) / var_663_0)
				end
			end

			if arg_660_1.time_ >= 0 + var_663_0 and arg_660_1.time_ < 0 + var_663_0 + arg_663_0 and not isNil(arg_660_1.actors_["1075ui_actor"]) and arg_660_1.var_.characterEffect1075ui_actor then
				arg_660_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_660_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_663_1 = 0
			local var_663_2 = 0.175

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_1 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				arg_660_1.leftNameTxt_.text = arg_660_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, true)
				arg_660_1.iconController_:SetSelectedState("hero")

				arg_660_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_660_1.callingController_:SetSelectedState("normal")

				arg_660_1.keyicon_.color = Color.New(1, 1, 1)
				arg_660_1.icon_.color = Color.New(1, 1, 1)

				local var_663_3 = arg_660_1:FormatText(arg_660_1:GetWordFromCfg(1107506162).content)

				arg_660_1.text_.text = var_663_3

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_5 = 7 <= 0 and var_663_2 or var_663_2 * (utf8.len(var_663_3) / 7)

				if (7 <= 0 and var_663_2 or var_663_2 * (utf8.len(var_663_3) / 7)) > 0 and var_663_2 < var_663_5 then
					arg_660_1.talkMaxDuration = var_663_5

					if var_663_5 + var_663_1 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_5 + var_663_1
					end
				end

				arg_660_1.text_.text = var_663_3
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_6 = math.max(var_663_2, arg_660_1.talkMaxDuration)

			if var_663_1 <= arg_660_1.time_ and arg_660_1.time_ < var_663_1 + var_663_6 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_1) / var_663_6

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_1 + var_663_6 and arg_660_1.time_ < var_663_1 + var_663_6 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1107506163 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1107506163
		arg_664_1.duration_ = 5

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play1107506164(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0.7

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, false)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_1 = arg_664_1:FormatText(arg_664_1:GetWordFromCfg(1107506163).content)

				arg_664_1.text_.text = var_667_1

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_3 = 28 <= 0 and var_667_0 or var_667_0 * (utf8.len(var_667_1) / 28)

				if (28 <= 0 and var_667_0 or var_667_0 * (utf8.len(var_667_1) / 28)) > 0 and var_667_0 < var_667_3 then
					arg_664_1.talkMaxDuration = var_667_3

					if var_667_3 + 0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_3 + 0
					end
				end

				arg_664_1.text_.text = var_667_1
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)
				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_4 = math.max(var_667_0, arg_664_1.talkMaxDuration)

			if 0 <= arg_664_1.time_ and arg_664_1.time_ < 0 + var_667_4 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - 0) / var_667_4

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= 0 + var_667_4 and arg_664_1.time_ < 0 + var_667_4 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play1107506164 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1107506164
		arg_668_1.duration_ = 2.9

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1107506165(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			if 0 < arg_668_1.time_ and arg_668_1.time_ <= 0 + arg_671_0 and not isNil(arg_668_1.actors_["1075ui_actor"]) and arg_668_1.var_.characterEffect1075ui_actor == nil then
				arg_668_1.var_.characterEffect1075ui_actor = arg_668_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_671_0 = 0.200000002980232

			if 0 <= arg_668_1.time_ and arg_668_1.time_ < 0 + var_671_0 and not isNil(arg_668_1.actors_["1075ui_actor"]) then
				if arg_668_1.var_.characterEffect1075ui_actor and not isNil(arg_668_1.actors_["1075ui_actor"]) then
					arg_668_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_668_1.time_ >= 0 + var_671_0 and arg_668_1.time_ < 0 + var_671_0 + arg_671_0 and not isNil(arg_668_1.actors_["1075ui_actor"]) and arg_668_1.var_.characterEffect1075ui_actor then
				arg_668_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_671_2 = 0
			local var_671_3 = 0.275

			if 0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_2 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				arg_668_1.leftNameTxt_.text = arg_668_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, false)
				arg_668_1.callingController_:SetSelectedState("normal")

				local var_671_4 = arg_668_1:GetWordFromCfg(1107506164)
				local var_671_5 = arg_668_1:FormatText(var_671_4.content)

				arg_668_1.text_.text = var_671_5

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_7 = 11 <= 0 and var_671_3 or var_671_3 * (utf8.len(var_671_5) / 11)

				if (11 <= 0 and var_671_3 or var_671_3 * (utf8.len(var_671_5) / 11)) > 0 and var_671_3 < var_671_7 then
					arg_668_1.talkMaxDuration = var_671_7

					if var_671_7 + var_671_2 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_7 + var_671_2
					end
				end

				arg_668_1.text_.text = var_671_5
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506164", "story_v_side_new_1107506.awb") ~= 0 then
					local var_671_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506164", "story_v_side_new_1107506.awb") / 1000

					if var_671_8 + var_671_2 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_8 + var_671_2
					end

					if var_671_4.prefab_name ~= "" and arg_668_1.actors_[var_671_4.prefab_name] ~= nil then
						local var_671_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_668_1.actors_[var_671_4.prefab_name].transform, "story_v_side_new_1107506", "1107506164", "story_v_side_new_1107506.awb")

						arg_668_1:RecordAudio("1107506164", var_671_9)
						arg_668_1:RecordAudio("1107506164", var_671_9)
					else
						arg_668_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506164", "story_v_side_new_1107506.awb")
					end

					arg_668_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506164", "story_v_side_new_1107506.awb")
				end

				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_10 = math.max(var_671_3, arg_668_1.talkMaxDuration)

			if var_671_2 <= arg_668_1.time_ and arg_668_1.time_ < var_671_2 + var_671_10 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - var_671_2) / var_671_10

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= var_671_2 + var_671_10 and arg_668_1.time_ < var_671_2 + var_671_10 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1107506165 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1107506165
		arg_672_1.duration_ = 5

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1107506166(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 and not isNil(arg_672_1.actors_["1075ui_actor"]) and arg_672_1.var_.characterEffect1075ui_actor == nil then
				arg_672_1.var_.characterEffect1075ui_actor = arg_672_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_675_0 = 0.200000002980232

			if 0 <= arg_672_1.time_ and arg_672_1.time_ < 0 + var_675_0 and not isNil(arg_672_1.actors_["1075ui_actor"]) then
				if arg_672_1.var_.characterEffect1075ui_actor and not isNil(arg_672_1.actors_["1075ui_actor"]) then
					arg_672_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_672_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_672_1.time_ - 0) / var_675_0)
				end
			end

			if arg_672_1.time_ >= 0 + var_675_0 and arg_672_1.time_ < 0 + var_675_0 + arg_675_0 and not isNil(arg_672_1.actors_["1075ui_actor"]) and arg_672_1.var_.characterEffect1075ui_actor then
				arg_672_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_672_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_675_1 = 0
			local var_675_2 = 0.175

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_1 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				arg_672_1.leftNameTxt_.text = arg_672_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, true)
				arg_672_1.iconController_:SetSelectedState("hero")

				arg_672_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_672_1.callingController_:SetSelectedState("normal")

				arg_672_1.keyicon_.color = Color.New(1, 1, 1)
				arg_672_1.icon_.color = Color.New(1, 1, 1)

				local var_675_3 = arg_672_1:FormatText(arg_672_1:GetWordFromCfg(1107506165).content)

				arg_672_1.text_.text = var_675_3

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_5 = 7 <= 0 and var_675_2 or var_675_2 * (utf8.len(var_675_3) / 7)

				if (7 <= 0 and var_675_2 or var_675_2 * (utf8.len(var_675_3) / 7)) > 0 and var_675_2 < var_675_5 then
					arg_672_1.talkMaxDuration = var_675_5

					if var_675_5 + var_675_1 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_5 + var_675_1
					end
				end

				arg_672_1.text_.text = var_675_3
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)
				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_6 = math.max(var_675_2, arg_672_1.talkMaxDuration)

			if var_675_1 <= arg_672_1.time_ and arg_672_1.time_ < var_675_1 + var_675_6 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_1) / var_675_6

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_1 + var_675_6 and arg_672_1.time_ < var_675_1 + var_675_6 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play1107506166 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 1107506166
		arg_676_1.duration_ = 5

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play1107506167(arg_676_1)
			end
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = 0.65

			if 0 < arg_676_1.time_ and arg_676_1.time_ <= 0 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0
				arg_676_1.dialogCg_.alpha = 1

				arg_676_1.dialog_:SetActive(true)
				SetActive(arg_676_1.leftNameGo_, false)

				arg_676_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_676_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_676_1:RecordName(arg_676_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_676_1.iconTrs_.gameObject, false)
				arg_676_1.callingController_:SetSelectedState("normal")

				local var_679_1 = arg_676_1:FormatText(arg_676_1:GetWordFromCfg(1107506166).content)

				arg_676_1.text_.text = var_679_1

				LuaForUtil.ClearLinePrefixSymbol(arg_676_1.text_)

				local var_679_3 = 26 <= 0 and var_679_0 or var_679_0 * (utf8.len(var_679_1) / 26)

				if (26 <= 0 and var_679_0 or var_679_0 * (utf8.len(var_679_1) / 26)) > 0 and var_679_0 < var_679_3 then
					arg_676_1.talkMaxDuration = var_679_3

					if var_679_3 + 0 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_3 + 0
					end
				end

				arg_676_1.text_.text = var_679_1
				arg_676_1.typewritter.percent = 0

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(false)
				arg_676_1:RecordContent(arg_676_1.text_.text)
			end

			local var_679_4 = math.max(var_679_0, arg_676_1.talkMaxDuration)

			if 0 <= arg_676_1.time_ and arg_676_1.time_ < 0 + var_679_4 then
				arg_676_1.typewritter.percent = (arg_676_1.time_ - 0) / var_679_4

				arg_676_1.typewritter:SetDirty()
			end

			if arg_676_1.time_ >= 0 + var_679_4 and arg_676_1.time_ < 0 + var_679_4 + arg_679_0 then
				arg_676_1.typewritter.percent = 1

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(true)
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play1107506167 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 1107506167
		arg_680_1.duration_ = 5

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play1107506168(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			local var_683_0 = 0.725

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, false)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_1 = arg_680_1:FormatText(arg_680_1:GetWordFromCfg(1107506167).content)

				arg_680_1.text_.text = var_683_1

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_3 = 29 <= 0 and var_683_0 or var_683_0 * (utf8.len(var_683_1) / 29)

				if (29 <= 0 and var_683_0 or var_683_0 * (utf8.len(var_683_1) / 29)) > 0 and var_683_0 < var_683_3 then
					arg_680_1.talkMaxDuration = var_683_3

					if var_683_3 + 0 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_3 + 0
					end
				end

				arg_680_1.text_.text = var_683_1
				arg_680_1.typewritter.percent = 0

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(false)
				arg_680_1:RecordContent(arg_680_1.text_.text)
			end

			local var_683_4 = math.max(var_683_0, arg_680_1.talkMaxDuration)

			if 0 <= arg_680_1.time_ and arg_680_1.time_ < 0 + var_683_4 then
				arg_680_1.typewritter.percent = (arg_680_1.time_ - 0) / var_683_4

				arg_680_1.typewritter:SetDirty()
			end

			if arg_680_1.time_ >= 0 + var_683_4 and arg_680_1.time_ < 0 + var_683_4 + arg_683_0 then
				arg_680_1.typewritter.percent = 1

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(true)
			end
		end

		arg_680_1.nodeConfigList_ = {}

		arg_680_1:InitPlayNodeList()
	end,
	Play1107506168 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 1107506168
		arg_684_1.duration_ = 7.36

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play1107506169(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			if arg_684_1.bgs_.R7502a == nil then
				local var_687_0 = Object.Instantiate(arg_684_1.paintGo_)

				var_687_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R7502a")
				var_687_0.name = "R7502a"
				var_687_0.transform.parent = arg_684_1.stage_.transform
				var_687_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_684_1.bgs_.R7502a = var_687_0
			end

			if 2 < arg_684_1.time_ and arg_684_1.time_ <= 2 + arg_687_0 then
				local var_687_1 = arg_684_1.bgs_.R7502a

				arg_684_1.bgs_.R7502a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_687_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_687_2 = var_687_1:GetComponent("SpriteRenderer")

				if var_687_2 and var_687_2.sprite then
					local var_687_3 = 2 * (var_687_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_687_1.transform.localScale = Vector3.New(var_687_3 / var_687_2.sprite.bounds.size.y < var_687_3 * manager.ui.mainCameraCom_.aspect / var_687_2.sprite.bounds.size.x and var_687_3 * manager.ui.mainCameraCom_.aspect / var_687_2.sprite.bounds.size.x or var_687_3 / var_687_2.sprite.bounds.size.y, var_687_3 / var_687_2.sprite.bounds.size.y < var_687_3 * manager.ui.mainCameraCom_.aspect / var_687_2.sprite.bounds.size.x and var_687_3 * manager.ui.mainCameraCom_.aspect / var_687_2.sprite.bounds.size.x or var_687_3 / var_687_2.sprite.bounds.size.y, 0)
				end

				for iter_687_0, iter_687_1 in pairs(arg_684_1.bgs_) do
					if iter_687_0 ~= "R7502a" then
						iter_687_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_687_4 = 4

			if 4 < arg_684_1.time_ and arg_684_1.time_ <= var_687_4 + arg_687_0 then
				arg_684_1.allBtn_.enabled = false
			end

			if arg_684_1.time_ >= var_687_4 + 0.3 and arg_684_1.time_ < var_687_4 + 0.3 + arg_687_0 then
				arg_684_1.allBtn_.enabled = true
			end

			local var_687_5 = 0

			if 0 < arg_684_1.time_ and arg_684_1.time_ <= var_687_5 + arg_687_0 then
				arg_684_1.mask_.enabled = true
				arg_684_1.mask_.raycastTarget = true

				arg_684_1:SetGaussion(false)
			end

			local var_687_6 = 2

			if var_687_5 <= arg_684_1.time_ and arg_684_1.time_ < var_687_5 + var_687_6 then
				local var_687_7 = Color.New(0, 0, 0)

				var_687_7.a = Mathf.Lerp(0, 1, (arg_684_1.time_ - var_687_5) / var_687_6)
				arg_684_1.mask_.color = var_687_7
			end

			if arg_684_1.time_ >= var_687_5 + var_687_6 and arg_684_1.time_ < var_687_5 + var_687_6 + arg_687_0 then
				local var_687_8 = Color.New(0, 0, 0)

				var_687_8.a = 1
				arg_684_1.mask_.color = var_687_8
			end

			local var_687_9 = 2

			if 2 < arg_684_1.time_ and arg_684_1.time_ <= var_687_9 + arg_687_0 then
				arg_684_1.mask_.enabled = true
				arg_684_1.mask_.raycastTarget = true

				arg_684_1:SetGaussion(false)
			end

			local var_687_10 = 2

			if var_687_9 <= arg_684_1.time_ and arg_684_1.time_ < var_687_9 + var_687_10 then
				local var_687_11 = Color.New(0, 0, 0)

				var_687_11.a = Mathf.Lerp(1, 0, (arg_684_1.time_ - var_687_9) / var_687_10)
				arg_684_1.mask_.color = var_687_11
			end

			if arg_684_1.time_ >= var_687_9 + var_687_10 and arg_684_1.time_ < var_687_9 + var_687_10 + arg_687_0 then
				local var_687_12 = Color.New(0, 0, 0)

				arg_684_1.mask_.enabled = false
				var_687_12.a = 0
				arg_684_1.mask_.color = var_687_12
			end

			local var_687_13 = arg_684_1.actors_["1075ui_actor"]

			if 4 < arg_684_1.time_ and arg_684_1.time_ <= 4 + arg_687_0 and not isNil(var_687_13) and arg_684_1.var_.characterEffect1075ui_actor == nil then
				arg_684_1.var_.characterEffect1075ui_actor = var_687_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_687_14 = 0.200000002980232

			if 4 <= arg_684_1.time_ and arg_684_1.time_ < 4 + var_687_14 and not isNil(var_687_13) then
				if arg_684_1.var_.characterEffect1075ui_actor and not isNil(var_687_13) then
					arg_684_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_684_1.time_ >= 4 + var_687_14 and arg_684_1.time_ < 4 + var_687_14 + arg_687_0 and not isNil(var_687_13) and arg_684_1.var_.characterEffect1075ui_actor then
				arg_684_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_687_16 = arg_684_1.bgs_.R7502a.transform

			if 2 < arg_684_1.time_ and arg_684_1.time_ <= 2 + arg_687_0 then
				arg_684_1.var_.moveOldPosR7502a = var_687_16.localPosition
			end

			local var_687_17 = 0.001

			if 2 <= arg_684_1.time_ and arg_684_1.time_ < 2 + var_687_17 then
				var_687_16.localPosition = Vector3.Lerp(arg_684_1.var_.moveOldPosR7502a, Vector3.New(-2.5, -1.15, -2.5), (arg_684_1.time_ - 2) / var_687_17)
			end

			if arg_684_1.time_ >= 2 + var_687_17 and arg_684_1.time_ < 2 + var_687_17 + arg_687_0 then
				var_687_16.localPosition = Vector3.New(-2.5, -1.15, -2.5)
			end

			local var_687_18 = arg_684_1.bgs_.R7502a.transform

			if 2.01666666666667 < arg_684_1.time_ and arg_684_1.time_ <= 2.01666666666667 + arg_687_0 then
				arg_684_1.var_.moveOldPosR7502a = var_687_18.localPosition
			end

			local var_687_19 = 3

			if 2.01666666666667 <= arg_684_1.time_ and arg_684_1.time_ < 2.01666666666667 + var_687_19 then
				var_687_18.localPosition = Vector3.Lerp(arg_684_1.var_.moveOldPosR7502a, Vector3.New(-2.5, -1.35, -2.5), (arg_684_1.time_ - 2.01666666666667) / var_687_19)
			end

			if arg_684_1.time_ >= 2.01666666666667 + var_687_19 and arg_684_1.time_ < 2.01666666666667 + var_687_19 + arg_687_0 then
				var_687_18.localPosition = Vector3.New(-2.5, -1.35, -2.5)
			end

			local var_687_20 = 4

			if 4 < arg_684_1.time_ and arg_684_1.time_ <= var_687_20 + arg_687_0 then
				arg_684_1.allBtn_.enabled = false
			end

			if arg_684_1.time_ >= var_687_20 + 1.01666666666667 and arg_684_1.time_ < var_687_20 + 1.01666666666667 + arg_687_0 then
				arg_684_1.allBtn_.enabled = true
			end

			if arg_684_1.frameCnt_ <= 1 then
				arg_684_1.dialog_:SetActive(false)
			end

			local var_687_21 = 4.025
			local var_687_22 = 0.275

			if 4.025 < arg_684_1.time_ and arg_684_1.time_ <= var_687_21 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0

				arg_684_1.dialog_:SetActive(true)

				arg_684_1.dialogCg_.alpha = 0

				local var_687_23 = LeanTween.value(arg_684_1.dialog_, 0, 1, 0.3)

				var_687_23:setOnUpdate(LuaHelper.FloatAction(function(arg_688_0)
					arg_684_1.dialogCg_.alpha = arg_688_0
				end))
				var_687_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_684_1.dialog_)
					var_687_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_684_1.duration_ = arg_684_1.duration_ + 0.3

				SetActive(arg_684_1.leftNameGo_, true)

				arg_684_1.leftNameTxt_.text = arg_684_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_684_1.leftNameTxt_.transform)

				arg_684_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_684_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_684_1:RecordName(arg_684_1.leftNameTxt_.text)
				SetActive(arg_684_1.iconTrs_.gameObject, false)
				arg_684_1.callingController_:SetSelectedState("normal")

				local var_687_24 = arg_684_1:GetWordFromCfg(1107506168)
				local var_687_25 = arg_684_1:FormatText(var_687_24.content)

				arg_684_1.text_.text = var_687_25

				LuaForUtil.ClearLinePrefixSymbol(arg_684_1.text_)

				local var_687_27 = 11 <= 0 and var_687_22 or var_687_22 * (utf8.len(var_687_25) / 11)

				if (11 <= 0 and var_687_22 or var_687_22 * (utf8.len(var_687_25) / 11)) > 0 and var_687_22 < var_687_27 then
					arg_684_1.talkMaxDuration = var_687_27
					var_687_21 = var_687_21 + 0.3

					if var_687_27 + var_687_21 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_27 + var_687_21
					end
				end

				arg_684_1.text_.text = var_687_25
				arg_684_1.typewritter.percent = 0

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506168", "story_v_side_new_1107506.awb") ~= 0 then
					local var_687_28 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506168", "story_v_side_new_1107506.awb") / 1000

					if var_687_28 + var_687_21 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_28 + var_687_21
					end

					if var_687_24.prefab_name ~= "" and arg_684_1.actors_[var_687_24.prefab_name] ~= nil then
						local var_687_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_684_1.actors_[var_687_24.prefab_name].transform, "story_v_side_new_1107506", "1107506168", "story_v_side_new_1107506.awb")

						arg_684_1:RecordAudio("1107506168", var_687_29)
						arg_684_1:RecordAudio("1107506168", var_687_29)
					else
						arg_684_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506168", "story_v_side_new_1107506.awb")
					end

					arg_684_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506168", "story_v_side_new_1107506.awb")
				end

				arg_684_1:RecordContent(arg_684_1.text_.text)
			end

			local var_687_30 = var_687_21 + 0.3
			local var_687_31 = math.max(var_687_22, arg_684_1.talkMaxDuration)

			if var_687_21 + 0.3 <= arg_684_1.time_ and arg_684_1.time_ < var_687_30 + var_687_31 then
				arg_684_1.typewritter.percent = (arg_684_1.time_ - var_687_30) / var_687_31

				arg_684_1.typewritter:SetDirty()
			end

			if arg_684_1.time_ >= var_687_30 + var_687_31 and arg_684_1.time_ < var_687_30 + var_687_31 + arg_687_0 then
				arg_684_1.typewritter.percent = 1

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(true)
			end
		end

		arg_684_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R7502a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R7502a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_684_1:InitPlayNodeList()
	end,
	Play1107506169 = function(arg_690_0, arg_690_1)
		arg_690_1.time_ = 0
		arg_690_1.frameCnt_ = 0
		arg_690_1.state_ = "playing"
		arg_690_1.curTalkId_ = 1107506169
		arg_690_1.duration_ = 7.67

		SetActive(arg_690_1.tipsGo_, false)

		function arg_690_1.onSingleLineFinish_()
			arg_690_1.onSingleLineUpdate_ = nil
			arg_690_1.onSingleLineFinish_ = nil
			arg_690_1.state_ = "waiting"
		end

		function arg_690_1.playNext_(arg_692_0)
			if arg_692_0 == 1 then
				arg_690_0:Play1107506170(arg_690_1)
			end
		end

		function arg_690_1.onSingleLineUpdate_(arg_693_0)
			local var_693_0 = 0.75

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 then
				arg_690_1.talkMaxDuration = 0
				arg_690_1.dialogCg_.alpha = 1

				arg_690_1.dialog_:SetActive(true)
				SetActive(arg_690_1.leftNameGo_, true)

				arg_690_1.leftNameTxt_.text = arg_690_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_690_1.leftNameTxt_.transform)

				arg_690_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_690_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_690_1:RecordName(arg_690_1.leftNameTxt_.text)
				SetActive(arg_690_1.iconTrs_.gameObject, false)
				arg_690_1.callingController_:SetSelectedState("normal")

				local var_693_1 = arg_690_1:GetWordFromCfg(1107506169)
				local var_693_2 = arg_690_1:FormatText(var_693_1.content)

				arg_690_1.text_.text = var_693_2

				LuaForUtil.ClearLinePrefixSymbol(arg_690_1.text_)

				local var_693_4 = 30 <= 0 and var_693_0 or var_693_0 * (utf8.len(var_693_2) / 30)

				if (30 <= 0 and var_693_0 or var_693_0 * (utf8.len(var_693_2) / 30)) > 0 and var_693_0 < var_693_4 then
					arg_690_1.talkMaxDuration = var_693_4

					if var_693_4 + 0 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_4 + 0
					end
				end

				arg_690_1.text_.text = var_693_2
				arg_690_1.typewritter.percent = 0

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506169", "story_v_side_new_1107506.awb") ~= 0 then
					local var_693_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506169", "story_v_side_new_1107506.awb") / 1000

					if var_693_5 + 0 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_5 + 0
					end

					if var_693_1.prefab_name ~= "" and arg_690_1.actors_[var_693_1.prefab_name] ~= nil then
						local var_693_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_690_1.actors_[var_693_1.prefab_name].transform, "story_v_side_new_1107506", "1107506169", "story_v_side_new_1107506.awb")

						arg_690_1:RecordAudio("1107506169", var_693_6)
						arg_690_1:RecordAudio("1107506169", var_693_6)
					else
						arg_690_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506169", "story_v_side_new_1107506.awb")
					end

					arg_690_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506169", "story_v_side_new_1107506.awb")
				end

				arg_690_1:RecordContent(arg_690_1.text_.text)
			end

			local var_693_7 = math.max(var_693_0, arg_690_1.talkMaxDuration)

			if 0 <= arg_690_1.time_ and arg_690_1.time_ < 0 + var_693_7 then
				arg_690_1.typewritter.percent = (arg_690_1.time_ - 0) / var_693_7

				arg_690_1.typewritter:SetDirty()
			end

			if arg_690_1.time_ >= 0 + var_693_7 and arg_690_1.time_ < 0 + var_693_7 + arg_693_0 then
				arg_690_1.typewritter.percent = 1

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(true)
			end
		end

		arg_690_1.nodeConfigList_ = {}

		arg_690_1:InitPlayNodeList()
	end,
	Play1107506170 = function(arg_694_0, arg_694_1)
		arg_694_1.time_ = 0
		arg_694_1.frameCnt_ = 0
		arg_694_1.state_ = "playing"
		arg_694_1.curTalkId_ = 1107506170
		arg_694_1.duration_ = 1

		SetActive(arg_694_1.tipsGo_, true)

		arg_694_1.tipsText_.text = StoryTipsCfg[107501].name

		function arg_694_1.onSingleLineFinish_()
			arg_694_1.onSingleLineUpdate_ = nil
			arg_694_1.onSingleLineFinish_ = nil
			arg_694_1.state_ = "waiting"

			SetActive(arg_694_1.choicesGo_, true)

			for iter_695_0, iter_695_1 in ipairs(arg_694_1.choices_) do
				SetActive(iter_695_1.go, iter_695_0 <= 2)
			end

			arg_694_1.choices_[1].txt.text = arg_694_1:FormatText(StoryChoiceCfg[1175].name)
			arg_694_1.choices_[2].txt.text = arg_694_1:FormatText(StoryChoiceCfg[1176].name)
		end

		function arg_694_1.playNext_(arg_696_0)
			if arg_696_0 == 1 then
				PlayerAction.UseStoryTrigger(1075013, 210750106, 1107506170, 1)
				arg_694_0:Play1107506171(arg_694_1)
			end

			if arg_696_0 == 2 then
				PlayerAction.UseStoryTrigger(1075013, 210750106, 1107506170, 2)
				arg_694_0:Play1107506171(arg_694_1)
			end

			arg_694_1:RecordChoiceLog(1107506170, 1175, 1176)
		end

		function arg_694_1.onSingleLineUpdate_(arg_697_0)
			if 0 < arg_694_1.time_ and arg_694_1.time_ <= 0 + arg_697_0 and not isNil(arg_694_1.actors_["1075ui_actor"]) and arg_694_1.var_.characterEffect1075ui_actor == nil then
				arg_694_1.var_.characterEffect1075ui_actor = arg_694_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_697_0 = 0.2

			if 0 <= arg_694_1.time_ and arg_694_1.time_ < 0 + var_697_0 and not isNil(arg_694_1.actors_["1075ui_actor"]) then
				if arg_694_1.var_.characterEffect1075ui_actor and not isNil(arg_694_1.actors_["1075ui_actor"]) then
					arg_694_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_694_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_694_1.time_ - 0) / var_697_0)
				end
			end

			if arg_694_1.time_ >= 0 + var_697_0 and arg_694_1.time_ < 0 + var_697_0 + arg_697_0 and not isNil(arg_694_1.actors_["1075ui_actor"]) and arg_694_1.var_.characterEffect1075ui_actor then
				arg_694_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_694_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_697_1 = 0

			if 0 < arg_694_1.time_ and arg_694_1.time_ <= var_697_1 + arg_697_0 then
				arg_694_1.allBtn_.enabled = false
			end

			if arg_694_1.time_ >= var_697_1 + 0.5 and arg_694_1.time_ < var_697_1 + 0.5 + arg_697_0 then
				arg_694_1.allBtn_.enabled = true
			end
		end

		arg_694_1.nodeConfigList_ = {}

		arg_694_1:InitPlayNodeList()
	end,
	Play1107506171 = function(arg_698_0, arg_698_1)
		arg_698_1.time_ = 0
		arg_698_1.frameCnt_ = 0
		arg_698_1.state_ = "playing"
		arg_698_1.curTalkId_ = 1107506171
		arg_698_1.duration_ = 8

		SetActive(arg_698_1.tipsGo_, false)

		function arg_698_1.onSingleLineFinish_()
			arg_698_1.onSingleLineUpdate_ = nil
			arg_698_1.onSingleLineFinish_ = nil
			arg_698_1.state_ = "waiting"
		end

		function arg_698_1.playNext_(arg_700_0)
			if arg_700_0 == 1 then
				arg_698_0:Play1107506172(arg_698_1)
			end
		end

		function arg_698_1.onSingleLineUpdate_(arg_701_0)
			if 1.5 < arg_698_1.time_ and arg_698_1.time_ <= 1.5 + arg_701_0 then
				local var_701_0 = arg_698_1.bgs_.R7502a

				arg_698_1.bgs_.R7502a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_701_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_701_1 = var_701_0:GetComponent("SpriteRenderer")

				if var_701_1 and var_701_1.sprite then
					local var_701_2 = 2 * (var_701_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_701_0.transform.localScale = Vector3.New(var_701_2 / var_701_1.sprite.bounds.size.y < var_701_2 * manager.ui.mainCameraCom_.aspect / var_701_1.sprite.bounds.size.x and var_701_2 * manager.ui.mainCameraCom_.aspect / var_701_1.sprite.bounds.size.x or var_701_2 / var_701_1.sprite.bounds.size.y, var_701_2 / var_701_1.sprite.bounds.size.y < var_701_2 * manager.ui.mainCameraCom_.aspect / var_701_1.sprite.bounds.size.x and var_701_2 * manager.ui.mainCameraCom_.aspect / var_701_1.sprite.bounds.size.x or var_701_2 / var_701_1.sprite.bounds.size.y, 0)
				end

				for iter_701_0, iter_701_1 in pairs(arg_698_1.bgs_) do
					if iter_701_0 ~= "R7502a" then
						iter_701_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_701_3 = 0

			if 0 < arg_698_1.time_ and arg_698_1.time_ <= var_701_3 + arg_701_0 then
				arg_698_1.mask_.enabled = true
				arg_698_1.mask_.raycastTarget = true

				arg_698_1:SetGaussion(false)
			end

			local var_701_4 = 1.5

			if var_701_3 <= arg_698_1.time_ and arg_698_1.time_ < var_701_3 + var_701_4 then
				local var_701_5 = Color.New(0, 0, 0)

				var_701_5.a = Mathf.Lerp(0, 1, (arg_698_1.time_ - var_701_3) / var_701_4)
				arg_698_1.mask_.color = var_701_5
			end

			if arg_698_1.time_ >= var_701_3 + var_701_4 and arg_698_1.time_ < var_701_3 + var_701_4 + arg_701_0 then
				local var_701_6 = Color.New(0, 0, 0)

				var_701_6.a = 1
				arg_698_1.mask_.color = var_701_6
			end

			local var_701_7 = 1.5

			if 1.5 < arg_698_1.time_ and arg_698_1.time_ <= var_701_7 + arg_701_0 then
				arg_698_1.mask_.enabled = true
				arg_698_1.mask_.raycastTarget = true

				arg_698_1:SetGaussion(false)
			end

			local var_701_8 = 1.5

			if var_701_7 <= arg_698_1.time_ and arg_698_1.time_ < var_701_7 + var_701_8 then
				local var_701_9 = Color.New(0.06603771, 0.06603771, 0.06603771)

				var_701_9.a = Mathf.Lerp(1, 0, (arg_698_1.time_ - var_701_7) / var_701_8)
				arg_698_1.mask_.color = var_701_9
			end

			if arg_698_1.time_ >= var_701_7 + var_701_8 and arg_698_1.time_ < var_701_7 + var_701_8 + arg_701_0 then
				local var_701_10 = Color.New(0.06603771, 0.06603771, 0.06603771)

				arg_698_1.mask_.enabled = false
				var_701_10.a = 0
				arg_698_1.mask_.color = var_701_10
			end

			local var_701_11 = arg_698_1.bgs_.R7502a.transform

			if 1.5 < arg_698_1.time_ and arg_698_1.time_ <= 1.5 + arg_701_0 then
				arg_698_1.var_.moveOldPosR7502a = var_701_11.localPosition
			end

			local var_701_12 = 0.001

			if 1.5 <= arg_698_1.time_ and arg_698_1.time_ < 1.5 + var_701_12 then
				var_701_11.localPosition = Vector3.Lerp(arg_698_1.var_.moveOldPosR7502a, Vector3.New(0, 1, 9.5), (arg_698_1.time_ - 1.5) / var_701_12)
			end

			if arg_698_1.time_ >= 1.5 + var_701_12 and arg_698_1.time_ < 1.5 + var_701_12 + arg_701_0 then
				var_701_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_701_13 = arg_698_1.bgs_.R7502a.transform

			if 1.51666666666667 < arg_698_1.time_ and arg_698_1.time_ <= 1.51666666666667 + arg_701_0 then
				arg_698_1.var_.moveOldPosR7502a = var_701_13.localPosition
			end

			local var_701_14 = 4.5

			if 1.51666666666667 <= arg_698_1.time_ and arg_698_1.time_ < 1.51666666666667 + var_701_14 then
				var_701_13.localPosition = Vector3.Lerp(arg_698_1.var_.moveOldPosR7502a, Vector3.New(0, 1, 10), (arg_698_1.time_ - 1.51666666666667) / var_701_14)
			end

			if arg_698_1.time_ >= 1.51666666666667 + var_701_14 and arg_698_1.time_ < 1.51666666666667 + var_701_14 + arg_701_0 then
				var_701_13.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_698_1.frameCnt_ <= 1 then
				arg_698_1.dialog_:SetActive(false)
			end

			local var_701_15 = 3
			local var_701_16 = 0.65

			if 3 < arg_698_1.time_ and arg_698_1.time_ <= var_701_15 + arg_701_0 then
				arg_698_1.talkMaxDuration = 0

				arg_698_1.dialog_:SetActive(true)

				arg_698_1.dialogCg_.alpha = 0

				local var_701_17 = LeanTween.value(arg_698_1.dialog_, 0, 1, 0.3)

				var_701_17:setOnUpdate(LuaHelper.FloatAction(function(arg_702_0)
					arg_698_1.dialogCg_.alpha = arg_702_0
				end))
				var_701_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_698_1.dialog_)
					var_701_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_698_1.duration_ = arg_698_1.duration_ + 0.3

				SetActive(arg_698_1.leftNameGo_, false)

				arg_698_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_698_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_698_1:RecordName(arg_698_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_698_1.iconTrs_.gameObject, false)
				arg_698_1.callingController_:SetSelectedState("normal")

				local var_701_18 = arg_698_1:FormatText(arg_698_1:GetWordFromCfg(1107506171).content)

				arg_698_1.text_.text = var_701_18

				LuaForUtil.ClearLinePrefixSymbol(arg_698_1.text_)

				local var_701_20 = 26 <= 0 and var_701_16 or var_701_16 * (utf8.len(var_701_18) / 26)

				if (26 <= 0 and var_701_16 or var_701_16 * (utf8.len(var_701_18) / 26)) > 0 and var_701_16 < var_701_20 then
					arg_698_1.talkMaxDuration = var_701_20
					var_701_15 = var_701_15 + 0.3

					if var_701_20 + var_701_15 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_20 + var_701_15
					end
				end

				arg_698_1.text_.text = var_701_18
				arg_698_1.typewritter.percent = 0

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(false)
				arg_698_1:RecordContent(arg_698_1.text_.text)
			end

			local var_701_21 = var_701_15 + 0.3
			local var_701_22 = math.max(var_701_16, arg_698_1.talkMaxDuration)

			if var_701_15 + 0.3 <= arg_698_1.time_ and arg_698_1.time_ < var_701_21 + var_701_22 then
				arg_698_1.typewritter.percent = (arg_698_1.time_ - var_701_21) / var_701_22

				arg_698_1.typewritter:SetDirty()
			end

			if arg_698_1.time_ >= var_701_21 + var_701_22 and arg_698_1.time_ < var_701_21 + var_701_22 + arg_701_0 then
				arg_698_1.typewritter.percent = 1

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(true)
			end
		end

		arg_698_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R7502a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R7502a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 1.51666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_698_1:InitPlayNodeList()
	end,
	Play1107506172 = function(arg_704_0, arg_704_1)
		arg_704_1.time_ = 0
		arg_704_1.frameCnt_ = 0
		arg_704_1.state_ = "playing"
		arg_704_1.curTalkId_ = 1107506172
		arg_704_1.duration_ = 5

		SetActive(arg_704_1.tipsGo_, false)

		function arg_704_1.onSingleLineFinish_()
			arg_704_1.onSingleLineUpdate_ = nil
			arg_704_1.onSingleLineFinish_ = nil
			arg_704_1.state_ = "waiting"
		end

		function arg_704_1.playNext_(arg_706_0)
			if arg_706_0 == 1 then
				arg_704_0:Play1107506173(arg_704_1)
			end
		end

		function arg_704_1.onSingleLineUpdate_(arg_707_0)
			local var_707_0 = 1.325

			if 0 < arg_704_1.time_ and arg_704_1.time_ <= 0 + arg_707_0 then
				arg_704_1.talkMaxDuration = 0
				arg_704_1.dialogCg_.alpha = 1

				arg_704_1.dialog_:SetActive(true)
				SetActive(arg_704_1.leftNameGo_, false)

				arg_704_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_704_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_704_1:RecordName(arg_704_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_704_1.iconTrs_.gameObject, false)
				arg_704_1.callingController_:SetSelectedState("normal")

				local var_707_1 = arg_704_1:FormatText(arg_704_1:GetWordFromCfg(1107506172).content)

				arg_704_1.text_.text = var_707_1

				LuaForUtil.ClearLinePrefixSymbol(arg_704_1.text_)

				local var_707_3 = 53 <= 0 and var_707_0 or var_707_0 * (utf8.len(var_707_1) / 53)

				if (53 <= 0 and var_707_0 or var_707_0 * (utf8.len(var_707_1) / 53)) > 0 and var_707_0 < var_707_3 then
					arg_704_1.talkMaxDuration = var_707_3

					if var_707_3 + 0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_3 + 0
					end
				end

				arg_704_1.text_.text = var_707_1
				arg_704_1.typewritter.percent = 0

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(false)
				arg_704_1:RecordContent(arg_704_1.text_.text)
			end

			local var_707_4 = math.max(var_707_0, arg_704_1.talkMaxDuration)

			if 0 <= arg_704_1.time_ and arg_704_1.time_ < 0 + var_707_4 then
				arg_704_1.typewritter.percent = (arg_704_1.time_ - 0) / var_707_4

				arg_704_1.typewritter:SetDirty()
			end

			if arg_704_1.time_ >= 0 + var_707_4 and arg_704_1.time_ < 0 + var_707_4 + arg_707_0 then
				arg_704_1.typewritter.percent = 1

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(true)
			end
		end

		arg_704_1.nodeConfigList_ = {}

		arg_704_1:InitPlayNodeList()
	end,
	Play1107506173 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 1107506173
		arg_708_1.duration_ = 4.43

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play1107506174(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			if 0 < arg_708_1.time_ and arg_708_1.time_ <= 0 + arg_711_0 and not isNil(arg_708_1.actors_["1075ui_actor"]) and arg_708_1.var_.characterEffect1075ui_actor == nil then
				arg_708_1.var_.characterEffect1075ui_actor = arg_708_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_711_0 = 0.200000002980232

			if 0 <= arg_708_1.time_ and arg_708_1.time_ < 0 + var_711_0 and not isNil(arg_708_1.actors_["1075ui_actor"]) then
				if arg_708_1.var_.characterEffect1075ui_actor and not isNil(arg_708_1.actors_["1075ui_actor"]) then
					arg_708_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_708_1.time_ >= 0 + var_711_0 and arg_708_1.time_ < 0 + var_711_0 + arg_711_0 and not isNil(arg_708_1.actors_["1075ui_actor"]) and arg_708_1.var_.characterEffect1075ui_actor then
				arg_708_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_711_2 = 0
			local var_711_3 = 0.4

			if 0 < arg_708_1.time_ and arg_708_1.time_ <= var_711_2 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0
				arg_708_1.dialogCg_.alpha = 1

				arg_708_1.dialog_:SetActive(true)
				SetActive(arg_708_1.leftNameGo_, true)

				arg_708_1.leftNameTxt_.text = arg_708_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_708_1.leftNameTxt_.transform)

				arg_708_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_708_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_708_1:RecordName(arg_708_1.leftNameTxt_.text)
				SetActive(arg_708_1.iconTrs_.gameObject, false)
				arg_708_1.callingController_:SetSelectedState("normal")

				local var_711_4 = arg_708_1:GetWordFromCfg(1107506173)
				local var_711_5 = arg_708_1:FormatText(var_711_4.content)

				arg_708_1.text_.text = var_711_5

				LuaForUtil.ClearLinePrefixSymbol(arg_708_1.text_)

				local var_711_7 = 16 <= 0 and var_711_3 or var_711_3 * (utf8.len(var_711_5) / 16)

				if (16 <= 0 and var_711_3 or var_711_3 * (utf8.len(var_711_5) / 16)) > 0 and var_711_3 < var_711_7 then
					arg_708_1.talkMaxDuration = var_711_7

					if var_711_7 + var_711_2 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_7 + var_711_2
					end
				end

				arg_708_1.text_.text = var_711_5
				arg_708_1.typewritter.percent = 0

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506173", "story_v_side_new_1107506.awb") ~= 0 then
					local var_711_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506173", "story_v_side_new_1107506.awb") / 1000

					if var_711_8 + var_711_2 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_8 + var_711_2
					end

					if var_711_4.prefab_name ~= "" and arg_708_1.actors_[var_711_4.prefab_name] ~= nil then
						local var_711_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_708_1.actors_[var_711_4.prefab_name].transform, "story_v_side_new_1107506", "1107506173", "story_v_side_new_1107506.awb")

						arg_708_1:RecordAudio("1107506173", var_711_9)
						arg_708_1:RecordAudio("1107506173", var_711_9)
					else
						arg_708_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506173", "story_v_side_new_1107506.awb")
					end

					arg_708_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506173", "story_v_side_new_1107506.awb")
				end

				arg_708_1:RecordContent(arg_708_1.text_.text)
			end

			local var_711_10 = math.max(var_711_3, arg_708_1.talkMaxDuration)

			if var_711_2 <= arg_708_1.time_ and arg_708_1.time_ < var_711_2 + var_711_10 then
				arg_708_1.typewritter.percent = (arg_708_1.time_ - var_711_2) / var_711_10

				arg_708_1.typewritter:SetDirty()
			end

			if arg_708_1.time_ >= var_711_2 + var_711_10 and arg_708_1.time_ < var_711_2 + var_711_10 + arg_711_0 then
				arg_708_1.typewritter.percent = 1

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(true)
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play1107506174 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 1107506174
		arg_712_1.duration_ = 3.9

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play1107506175(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = 0.375

			if 0 < arg_712_1.time_ and arg_712_1.time_ <= 0 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, true)

				arg_712_1.leftNameTxt_.text = arg_712_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_712_1.leftNameTxt_.transform)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1.leftNameTxt_.text)
				SetActive(arg_712_1.iconTrs_.gameObject, false)
				arg_712_1.callingController_:SetSelectedState("normal")

				local var_715_1 = arg_712_1:GetWordFromCfg(1107506174)
				local var_715_2 = arg_712_1:FormatText(var_715_1.content)

				arg_712_1.text_.text = var_715_2

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_4 = 15 <= 0 and var_715_0 or var_715_0 * (utf8.len(var_715_2) / 15)

				if (15 <= 0 and var_715_0 or var_715_0 * (utf8.len(var_715_2) / 15)) > 0 and var_715_0 < var_715_4 then
					arg_712_1.talkMaxDuration = var_715_4

					if var_715_4 + 0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_4 + 0
					end
				end

				arg_712_1.text_.text = var_715_2
				arg_712_1.typewritter.percent = 0

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506174", "story_v_side_new_1107506.awb") ~= 0 then
					local var_715_5 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506174", "story_v_side_new_1107506.awb") / 1000

					if var_715_5 + 0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_5 + 0
					end

					if var_715_1.prefab_name ~= "" and arg_712_1.actors_[var_715_1.prefab_name] ~= nil then
						local var_715_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_712_1.actors_[var_715_1.prefab_name].transform, "story_v_side_new_1107506", "1107506174", "story_v_side_new_1107506.awb")

						arg_712_1:RecordAudio("1107506174", var_715_6)
						arg_712_1:RecordAudio("1107506174", var_715_6)
					else
						arg_712_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506174", "story_v_side_new_1107506.awb")
					end

					arg_712_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506174", "story_v_side_new_1107506.awb")
				end

				arg_712_1:RecordContent(arg_712_1.text_.text)
			end

			local var_715_7 = math.max(var_715_0, arg_712_1.talkMaxDuration)

			if 0 <= arg_712_1.time_ and arg_712_1.time_ < 0 + var_715_7 then
				arg_712_1.typewritter.percent = (arg_712_1.time_ - 0) / var_715_7

				arg_712_1.typewritter:SetDirty()
			end

			if arg_712_1.time_ >= 0 + var_715_7 and arg_712_1.time_ < 0 + var_715_7 + arg_715_0 then
				arg_712_1.typewritter.percent = 1

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(true)
			end
		end

		arg_712_1.nodeConfigList_ = {}

		arg_712_1:InitPlayNodeList()
	end,
	Play1107506175 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 1107506175
		arg_716_1.duration_ = 9

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play1107506176(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			if arg_716_1.bgs_.ST45 == nil then
				local var_719_0 = Object.Instantiate(arg_716_1.paintGo_)

				var_719_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST45")
				var_719_0.name = "ST45"
				var_719_0.transform.parent = arg_716_1.stage_.transform
				var_719_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_716_1.bgs_.ST45 = var_719_0
			end

			if 2 < arg_716_1.time_ and arg_716_1.time_ <= 2 + arg_719_0 then
				local var_719_1 = arg_716_1.bgs_.ST45

				arg_716_1.bgs_.ST45.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_719_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_719_2 = var_719_1:GetComponent("SpriteRenderer")

				if var_719_2 and var_719_2.sprite then
					local var_719_3 = 2 * (var_719_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_719_1.transform.localScale = Vector3.New(var_719_3 / var_719_2.sprite.bounds.size.y < var_719_3 * manager.ui.mainCameraCom_.aspect / var_719_2.sprite.bounds.size.x and var_719_3 * manager.ui.mainCameraCom_.aspect / var_719_2.sprite.bounds.size.x or var_719_3 / var_719_2.sprite.bounds.size.y, var_719_3 / var_719_2.sprite.bounds.size.y < var_719_3 * manager.ui.mainCameraCom_.aspect / var_719_2.sprite.bounds.size.x and var_719_3 * manager.ui.mainCameraCom_.aspect / var_719_2.sprite.bounds.size.x or var_719_3 / var_719_2.sprite.bounds.size.y, 0)
				end

				for iter_719_0, iter_719_1 in pairs(arg_716_1.bgs_) do
					if iter_719_0 ~= "ST45" then
						iter_719_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_719_4 = 4

			if 4 < arg_716_1.time_ and arg_716_1.time_ <= var_719_4 + arg_719_0 then
				arg_716_1.allBtn_.enabled = false
			end

			if arg_716_1.time_ >= var_719_4 + 0.3 and arg_716_1.time_ < var_719_4 + 0.3 + arg_719_0 then
				arg_716_1.allBtn_.enabled = true
			end

			local var_719_5 = 0

			if 0 < arg_716_1.time_ and arg_716_1.time_ <= var_719_5 + arg_719_0 then
				arg_716_1.mask_.enabled = true
				arg_716_1.mask_.raycastTarget = true

				arg_716_1:SetGaussion(false)
			end

			local var_719_6 = 2

			if var_719_5 <= arg_716_1.time_ and arg_716_1.time_ < var_719_5 + var_719_6 then
				local var_719_7 = Color.New(0, 0, 0)

				var_719_7.a = Mathf.Lerp(0, 1, (arg_716_1.time_ - var_719_5) / var_719_6)
				arg_716_1.mask_.color = var_719_7
			end

			if arg_716_1.time_ >= var_719_5 + var_719_6 and arg_716_1.time_ < var_719_5 + var_719_6 + arg_719_0 then
				local var_719_8 = Color.New(0, 0, 0)

				var_719_8.a = 1
				arg_716_1.mask_.color = var_719_8
			end

			local var_719_9 = 2

			if 2 < arg_716_1.time_ and arg_716_1.time_ <= var_719_9 + arg_719_0 then
				arg_716_1.mask_.enabled = true
				arg_716_1.mask_.raycastTarget = true

				arg_716_1:SetGaussion(false)
			end

			local var_719_10 = 2

			if var_719_9 <= arg_716_1.time_ and arg_716_1.time_ < var_719_9 + var_719_10 then
				local var_719_11 = Color.New(0, 0, 0)

				var_719_11.a = Mathf.Lerp(1, 0, (arg_716_1.time_ - var_719_9) / var_719_10)
				arg_716_1.mask_.color = var_719_11
			end

			if arg_716_1.time_ >= var_719_9 + var_719_10 and arg_716_1.time_ < var_719_9 + var_719_10 + arg_719_0 then
				local var_719_12 = Color.New(0, 0, 0)

				arg_716_1.mask_.enabled = false
				var_719_12.a = 0
				arg_716_1.mask_.color = var_719_12
			end

			if arg_716_1.frameCnt_ <= 1 then
				arg_716_1.dialog_:SetActive(false)
			end

			local var_719_13 = 4
			local var_719_14 = 0.525

			if 4 < arg_716_1.time_ and arg_716_1.time_ <= var_719_13 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0

				arg_716_1.dialog_:SetActive(true)

				arg_716_1.dialogCg_.alpha = 0

				local var_719_15 = LeanTween.value(arg_716_1.dialog_, 0, 1, 0.3)

				var_719_15:setOnUpdate(LuaHelper.FloatAction(function(arg_720_0)
					arg_716_1.dialogCg_.alpha = arg_720_0
				end))
				var_719_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_716_1.dialog_)
					var_719_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_716_1.duration_ = arg_716_1.duration_ + 0.3

				SetActive(arg_716_1.leftNameGo_, false)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_716_1.iconTrs_.gameObject, false)
				arg_716_1.callingController_:SetSelectedState("normal")

				local var_719_16 = arg_716_1:FormatText(arg_716_1:GetWordFromCfg(1107506175).content)

				arg_716_1.text_.text = var_719_16

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_18 = 21 <= 0 and var_719_14 or var_719_14 * (utf8.len(var_719_16) / 21)

				if (21 <= 0 and var_719_14 or var_719_14 * (utf8.len(var_719_16) / 21)) > 0 and var_719_14 < var_719_18 then
					arg_716_1.talkMaxDuration = var_719_18
					var_719_13 = var_719_13 + 0.3

					if var_719_18 + var_719_13 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_18 + var_719_13
					end
				end

				arg_716_1.text_.text = var_719_16
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)
				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_19 = var_719_13 + 0.3
			local var_719_20 = math.max(var_719_14, arg_716_1.talkMaxDuration)

			if var_719_13 + 0.3 <= arg_716_1.time_ and arg_716_1.time_ < var_719_19 + var_719_20 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - var_719_19) / var_719_20

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= var_719_19 + var_719_20 and arg_716_1.time_ < var_719_19 + var_719_20 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	Play1107506176 = function(arg_722_0, arg_722_1)
		arg_722_1.time_ = 0
		arg_722_1.frameCnt_ = 0
		arg_722_1.state_ = "playing"
		arg_722_1.curTalkId_ = 1107506176
		arg_722_1.duration_ = 5

		SetActive(arg_722_1.tipsGo_, false)

		function arg_722_1.onSingleLineFinish_()
			arg_722_1.onSingleLineUpdate_ = nil
			arg_722_1.onSingleLineFinish_ = nil
			arg_722_1.state_ = "waiting"
		end

		function arg_722_1.playNext_(arg_724_0)
			if arg_724_0 == 1 then
				arg_722_0:Play1107506177(arg_722_1)
			end
		end

		function arg_722_1.onSingleLineUpdate_(arg_725_0)
			local var_725_0 = 0.3

			if 0 < arg_722_1.time_ and arg_722_1.time_ <= 0 + arg_725_0 then
				arg_722_1.talkMaxDuration = 0
				arg_722_1.dialogCg_.alpha = 1

				arg_722_1.dialog_:SetActive(true)
				SetActive(arg_722_1.leftNameGo_, true)

				arg_722_1.leftNameTxt_.text = arg_722_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_722_1.leftNameTxt_.transform)

				arg_722_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_722_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_722_1:RecordName(arg_722_1.leftNameTxt_.text)
				SetActive(arg_722_1.iconTrs_.gameObject, true)
				arg_722_1.iconController_:SetSelectedState("hero")

				arg_722_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_722_1.callingController_:SetSelectedState("normal")

				arg_722_1.keyicon_.color = Color.New(1, 1, 1)
				arg_722_1.icon_.color = Color.New(1, 1, 1)

				local var_725_1 = arg_722_1:FormatText(arg_722_1:GetWordFromCfg(1107506176).content)

				arg_722_1.text_.text = var_725_1

				LuaForUtil.ClearLinePrefixSymbol(arg_722_1.text_)

				local var_725_3 = 12 <= 0 and var_725_0 or var_725_0 * (utf8.len(var_725_1) / 12)

				if (12 <= 0 and var_725_0 or var_725_0 * (utf8.len(var_725_1) / 12)) > 0 and var_725_0 < var_725_3 then
					arg_722_1.talkMaxDuration = var_725_3

					if var_725_3 + 0 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_3 + 0
					end
				end

				arg_722_1.text_.text = var_725_1
				arg_722_1.typewritter.percent = 0

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(false)
				arg_722_1:RecordContent(arg_722_1.text_.text)
			end

			local var_725_4 = math.max(var_725_0, arg_722_1.talkMaxDuration)

			if 0 <= arg_722_1.time_ and arg_722_1.time_ < 0 + var_725_4 then
				arg_722_1.typewritter.percent = (arg_722_1.time_ - 0) / var_725_4

				arg_722_1.typewritter:SetDirty()
			end

			if arg_722_1.time_ >= 0 + var_725_4 and arg_722_1.time_ < 0 + var_725_4 + arg_725_0 then
				arg_722_1.typewritter.percent = 1

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(true)
			end
		end

		arg_722_1.nodeConfigList_ = {}

		arg_722_1:InitPlayNodeList()
	end,
	Play1107506177 = function(arg_726_0, arg_726_1)
		arg_726_1.time_ = 0
		arg_726_1.frameCnt_ = 0
		arg_726_1.state_ = "playing"
		arg_726_1.curTalkId_ = 1107506177
		arg_726_1.duration_ = 8.57

		SetActive(arg_726_1.tipsGo_, false)

		function arg_726_1.onSingleLineFinish_()
			arg_726_1.onSingleLineUpdate_ = nil
			arg_726_1.onSingleLineFinish_ = nil
			arg_726_1.state_ = "waiting"
		end

		function arg_726_1.playNext_(arg_728_0)
			if arg_728_0 == 1 then
				arg_726_0:Play1107506178(arg_726_1)
			end
		end

		function arg_726_1.onSingleLineUpdate_(arg_729_0)
			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 then
				arg_726_1.var_.moveOldPos1075ui_actor = arg_726_1.actors_["1075ui_actor"].transform.localPosition

				local var_729_0 = GameObjectTools.GetOrAddComponent(arg_726_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_729_0 then
					var_729_0:EnableDynamicBone(false)
				end
			end

			local var_729_1 = 0.001

			if 0 <= arg_726_1.time_ and arg_726_1.time_ < 0 + var_729_1 then
				arg_726_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_726_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_726_1.time_ - 0) / var_729_1)
				arg_726_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_726_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_726_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_726_1.actors_["1075ui_actor"].transform.position).z)
				arg_726_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_726_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_726_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_726_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_726_1.time_ >= 0 + var_729_1 and arg_726_1.time_ < 0 + var_729_1 + arg_729_0 then
				arg_726_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_726_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_726_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_726_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_726_1.actors_["1075ui_actor"].transform.position).z)
				arg_726_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_726_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_726_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_726_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_729_2 = GameObjectTools.GetOrAddComponent(arg_726_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_729_2 then
					var_729_2:EnableDynamicBone(true)
				end
			end

			local var_729_3 = arg_726_1.actors_["1075ui_actor"]

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 and not isNil(var_729_3) and arg_726_1.var_.characterEffect1075ui_actor == nil then
				arg_726_1.var_.characterEffect1075ui_actor = var_729_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_729_4 = 0.200000002980232

			if 0 <= arg_726_1.time_ and arg_726_1.time_ < 0 + var_729_4 and not isNil(var_729_3) then
				if arg_726_1.var_.characterEffect1075ui_actor and not isNil(var_729_3) then
					arg_726_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_726_1.time_ >= 0 + var_729_4 and arg_726_1.time_ < 0 + var_729_4 + arg_729_0 and not isNil(var_729_3) and arg_726_1.var_.characterEffect1075ui_actor then
				arg_726_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 then
				arg_726_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 then
				arg_726_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_729_6 = 0
			local var_729_7 = 0.875

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= var_729_6 + arg_729_0 then
				arg_726_1.talkMaxDuration = 0
				arg_726_1.dialogCg_.alpha = 1

				arg_726_1.dialog_:SetActive(true)
				SetActive(arg_726_1.leftNameGo_, true)

				arg_726_1.leftNameTxt_.text = arg_726_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_726_1.leftNameTxt_.transform)

				arg_726_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_726_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_726_1:RecordName(arg_726_1.leftNameTxt_.text)
				SetActive(arg_726_1.iconTrs_.gameObject, false)
				arg_726_1.callingController_:SetSelectedState("normal")

				local var_729_8 = arg_726_1:GetWordFromCfg(1107506177)
				local var_729_9 = arg_726_1:FormatText(var_729_8.content)

				arg_726_1.text_.text = var_729_9

				LuaForUtil.ClearLinePrefixSymbol(arg_726_1.text_)

				local var_729_11 = 35 <= 0 and var_729_7 or var_729_7 * (utf8.len(var_729_9) / 35)

				if (35 <= 0 and var_729_7 or var_729_7 * (utf8.len(var_729_9) / 35)) > 0 and var_729_7 < var_729_11 then
					arg_726_1.talkMaxDuration = var_729_11

					if var_729_11 + var_729_6 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_11 + var_729_6
					end
				end

				arg_726_1.text_.text = var_729_9
				arg_726_1.typewritter.percent = 0

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506177", "story_v_side_new_1107506.awb") ~= 0 then
					local var_729_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506177", "story_v_side_new_1107506.awb") / 1000

					if var_729_12 + var_729_6 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_12 + var_729_6
					end

					if var_729_8.prefab_name ~= "" and arg_726_1.actors_[var_729_8.prefab_name] ~= nil then
						local var_729_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_726_1.actors_[var_729_8.prefab_name].transform, "story_v_side_new_1107506", "1107506177", "story_v_side_new_1107506.awb")

						arg_726_1:RecordAudio("1107506177", var_729_13)
						arg_726_1:RecordAudio("1107506177", var_729_13)
					else
						arg_726_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506177", "story_v_side_new_1107506.awb")
					end

					arg_726_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506177", "story_v_side_new_1107506.awb")
				end

				arg_726_1:RecordContent(arg_726_1.text_.text)
			end

			local var_729_14 = math.max(var_729_7, arg_726_1.talkMaxDuration)

			if var_729_6 <= arg_726_1.time_ and arg_726_1.time_ < var_729_6 + var_729_14 then
				arg_726_1.typewritter.percent = (arg_726_1.time_ - var_729_6) / var_729_14

				arg_726_1.typewritter:SetDirty()
			end

			if arg_726_1.time_ >= var_729_6 + var_729_14 and arg_726_1.time_ < var_729_6 + var_729_14 + arg_729_0 then
				arg_726_1.typewritter.percent = 1

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(true)
			end
		end

		arg_726_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_726_1:InitPlayNodeList()
	end,
	Play1107506178 = function(arg_730_0, arg_730_1)
		arg_730_1.time_ = 0
		arg_730_1.frameCnt_ = 0
		arg_730_1.state_ = "playing"
		arg_730_1.curTalkId_ = 1107506178
		arg_730_1.duration_ = 8.2

		SetActive(arg_730_1.tipsGo_, false)

		function arg_730_1.onSingleLineFinish_()
			arg_730_1.onSingleLineUpdate_ = nil
			arg_730_1.onSingleLineFinish_ = nil
			arg_730_1.state_ = "waiting"
		end

		function arg_730_1.playNext_(arg_732_0)
			if arg_732_0 == 1 then
				arg_730_0:Play1107506179(arg_730_1)
			end
		end

		function arg_730_1.onSingleLineUpdate_(arg_733_0)
			if 0 < arg_730_1.time_ and arg_730_1.time_ <= 0 + arg_733_0 then
				arg_730_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			if 0 < arg_730_1.time_ and arg_730_1.time_ <= 0 + arg_733_0 then
				arg_730_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_733_0 = 0
			local var_733_1 = 0.825

			if 0 < arg_730_1.time_ and arg_730_1.time_ <= var_733_0 + arg_733_0 then
				arg_730_1.talkMaxDuration = 0
				arg_730_1.dialogCg_.alpha = 1

				arg_730_1.dialog_:SetActive(true)
				SetActive(arg_730_1.leftNameGo_, true)

				arg_730_1.leftNameTxt_.text = arg_730_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_730_1.leftNameTxt_.transform)

				arg_730_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_730_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_730_1:RecordName(arg_730_1.leftNameTxt_.text)
				SetActive(arg_730_1.iconTrs_.gameObject, false)
				arg_730_1.callingController_:SetSelectedState("normal")

				local var_733_2 = arg_730_1:GetWordFromCfg(1107506178)
				local var_733_3 = arg_730_1:FormatText(var_733_2.content)

				arg_730_1.text_.text = var_733_3

				LuaForUtil.ClearLinePrefixSymbol(arg_730_1.text_)

				local var_733_5 = 33 <= 0 and var_733_1 or var_733_1 * (utf8.len(var_733_3) / 33)

				if (33 <= 0 and var_733_1 or var_733_1 * (utf8.len(var_733_3) / 33)) > 0 and var_733_1 < var_733_5 then
					arg_730_1.talkMaxDuration = var_733_5

					if var_733_5 + var_733_0 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_5 + var_733_0
					end
				end

				arg_730_1.text_.text = var_733_3
				arg_730_1.typewritter.percent = 0

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506178", "story_v_side_new_1107506.awb") ~= 0 then
					local var_733_6 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506178", "story_v_side_new_1107506.awb") / 1000

					if var_733_6 + var_733_0 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_6 + var_733_0
					end

					if var_733_2.prefab_name ~= "" and arg_730_1.actors_[var_733_2.prefab_name] ~= nil then
						local var_733_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_730_1.actors_[var_733_2.prefab_name].transform, "story_v_side_new_1107506", "1107506178", "story_v_side_new_1107506.awb")

						arg_730_1:RecordAudio("1107506178", var_733_7)
						arg_730_1:RecordAudio("1107506178", var_733_7)
					else
						arg_730_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506178", "story_v_side_new_1107506.awb")
					end

					arg_730_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506178", "story_v_side_new_1107506.awb")
				end

				arg_730_1:RecordContent(arg_730_1.text_.text)
			end

			local var_733_8 = math.max(var_733_1, arg_730_1.talkMaxDuration)

			if var_733_0 <= arg_730_1.time_ and arg_730_1.time_ < var_733_0 + var_733_8 then
				arg_730_1.typewritter.percent = (arg_730_1.time_ - var_733_0) / var_733_8

				arg_730_1.typewritter:SetDirty()
			end

			if arg_730_1.time_ >= var_733_0 + var_733_8 and arg_730_1.time_ < var_733_0 + var_733_8 + arg_733_0 then
				arg_730_1.typewritter.percent = 1

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(true)
			end
		end

		arg_730_1.nodeConfigList_ = {}

		arg_730_1:InitPlayNodeList()
	end,
	Play1107506179 = function(arg_734_0, arg_734_1)
		arg_734_1.time_ = 0
		arg_734_1.frameCnt_ = 0
		arg_734_1.state_ = "playing"
		arg_734_1.curTalkId_ = 1107506179
		arg_734_1.duration_ = 5

		SetActive(arg_734_1.tipsGo_, false)

		function arg_734_1.onSingleLineFinish_()
			arg_734_1.onSingleLineUpdate_ = nil
			arg_734_1.onSingleLineFinish_ = nil
			arg_734_1.state_ = "waiting"
		end

		function arg_734_1.playNext_(arg_736_0)
			if arg_736_0 == 1 then
				arg_734_0:Play1107506180(arg_734_1)
			end
		end

		function arg_734_1.onSingleLineUpdate_(arg_737_0)
			if 0 < arg_734_1.time_ and arg_734_1.time_ <= 0 + arg_737_0 and not isNil(arg_734_1.actors_["1075ui_actor"]) and arg_734_1.var_.characterEffect1075ui_actor == nil then
				arg_734_1.var_.characterEffect1075ui_actor = arg_734_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_737_0 = 0.200000002980232

			if 0 <= arg_734_1.time_ and arg_734_1.time_ < 0 + var_737_0 and not isNil(arg_734_1.actors_["1075ui_actor"]) then
				if arg_734_1.var_.characterEffect1075ui_actor and not isNil(arg_734_1.actors_["1075ui_actor"]) then
					arg_734_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_734_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_734_1.time_ - 0) / var_737_0)
				end
			end

			if arg_734_1.time_ >= 0 + var_737_0 and arg_734_1.time_ < 0 + var_737_0 + arg_737_0 and not isNil(arg_734_1.actors_["1075ui_actor"]) and arg_734_1.var_.characterEffect1075ui_actor then
				arg_734_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_734_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_737_1 = 0
			local var_737_2 = 0.275

			if 0 < arg_734_1.time_ and arg_734_1.time_ <= var_737_1 + arg_737_0 then
				arg_734_1.talkMaxDuration = 0
				arg_734_1.dialogCg_.alpha = 1

				arg_734_1.dialog_:SetActive(true)
				SetActive(arg_734_1.leftNameGo_, true)

				arg_734_1.leftNameTxt_.text = arg_734_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_734_1.leftNameTxt_.transform)

				arg_734_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_734_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_734_1:RecordName(arg_734_1.leftNameTxt_.text)
				SetActive(arg_734_1.iconTrs_.gameObject, true)
				arg_734_1.iconController_:SetSelectedState("hero")

				arg_734_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_734_1.callingController_:SetSelectedState("normal")

				arg_734_1.keyicon_.color = Color.New(1, 1, 1)
				arg_734_1.icon_.color = Color.New(1, 1, 1)

				local var_737_3 = arg_734_1:FormatText(arg_734_1:GetWordFromCfg(1107506179).content)

				arg_734_1.text_.text = var_737_3

				LuaForUtil.ClearLinePrefixSymbol(arg_734_1.text_)

				local var_737_5 = 11 <= 0 and var_737_2 or var_737_2 * (utf8.len(var_737_3) / 11)

				if (11 <= 0 and var_737_2 or var_737_2 * (utf8.len(var_737_3) / 11)) > 0 and var_737_2 < var_737_5 then
					arg_734_1.talkMaxDuration = var_737_5

					if var_737_5 + var_737_1 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_5 + var_737_1
					end
				end

				arg_734_1.text_.text = var_737_3
				arg_734_1.typewritter.percent = 0

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(false)
				arg_734_1:RecordContent(arg_734_1.text_.text)
			end

			local var_737_6 = math.max(var_737_2, arg_734_1.talkMaxDuration)

			if var_737_1 <= arg_734_1.time_ and arg_734_1.time_ < var_737_1 + var_737_6 then
				arg_734_1.typewritter.percent = (arg_734_1.time_ - var_737_1) / var_737_6

				arg_734_1.typewritter:SetDirty()
			end

			if arg_734_1.time_ >= var_737_1 + var_737_6 and arg_734_1.time_ < var_737_1 + var_737_6 + arg_737_0 then
				arg_734_1.typewritter.percent = 1

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(true)
			end
		end

		arg_734_1.nodeConfigList_ = {}

		arg_734_1:InitPlayNodeList()
	end,
	Play1107506180 = function(arg_738_0, arg_738_1)
		arg_738_1.time_ = 0
		arg_738_1.frameCnt_ = 0
		arg_738_1.state_ = "playing"
		arg_738_1.curTalkId_ = 1107506180
		arg_738_1.duration_ = 5

		SetActive(arg_738_1.tipsGo_, false)

		function arg_738_1.onSingleLineFinish_()
			arg_738_1.onSingleLineUpdate_ = nil
			arg_738_1.onSingleLineFinish_ = nil
			arg_738_1.state_ = "waiting"
		end

		function arg_738_1.playNext_(arg_740_0)
			if arg_740_0 == 1 then
				arg_738_0:Play1107506181(arg_738_1)
			end
		end

		function arg_738_1.onSingleLineUpdate_(arg_741_0)
			local var_741_0 = 0.325

			if 0 < arg_738_1.time_ and arg_738_1.time_ <= 0 + arg_741_0 then
				arg_738_1.talkMaxDuration = 0
				arg_738_1.dialogCg_.alpha = 1

				arg_738_1.dialog_:SetActive(true)
				SetActive(arg_738_1.leftNameGo_, true)

				arg_738_1.leftNameTxt_.text = arg_738_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_738_1.leftNameTxt_.transform)

				arg_738_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_738_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_738_1:RecordName(arg_738_1.leftNameTxt_.text)
				SetActive(arg_738_1.iconTrs_.gameObject, true)
				arg_738_1.iconController_:SetSelectedState("hero")

				arg_738_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_738_1.callingController_:SetSelectedState("normal")

				arg_738_1.keyicon_.color = Color.New(1, 1, 1)
				arg_738_1.icon_.color = Color.New(1, 1, 1)

				local var_741_1 = arg_738_1:FormatText(arg_738_1:GetWordFromCfg(1107506180).content)

				arg_738_1.text_.text = var_741_1

				LuaForUtil.ClearLinePrefixSymbol(arg_738_1.text_)

				local var_741_3 = 13 <= 0 and var_741_0 or var_741_0 * (utf8.len(var_741_1) / 13)

				if (13 <= 0 and var_741_0 or var_741_0 * (utf8.len(var_741_1) / 13)) > 0 and var_741_0 < var_741_3 then
					arg_738_1.talkMaxDuration = var_741_3

					if var_741_3 + 0 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_3 + 0
					end
				end

				arg_738_1.text_.text = var_741_1
				arg_738_1.typewritter.percent = 0

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(false)
				arg_738_1:RecordContent(arg_738_1.text_.text)
			end

			local var_741_4 = math.max(var_741_0, arg_738_1.talkMaxDuration)

			if 0 <= arg_738_1.time_ and arg_738_1.time_ < 0 + var_741_4 then
				arg_738_1.typewritter.percent = (arg_738_1.time_ - 0) / var_741_4

				arg_738_1.typewritter:SetDirty()
			end

			if arg_738_1.time_ >= 0 + var_741_4 and arg_738_1.time_ < 0 + var_741_4 + arg_741_0 then
				arg_738_1.typewritter.percent = 1

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(true)
			end
		end

		arg_738_1.nodeConfigList_ = {}

		arg_738_1:InitPlayNodeList()
	end,
	Play1107506181 = function(arg_742_0, arg_742_1)
		arg_742_1.time_ = 0
		arg_742_1.frameCnt_ = 0
		arg_742_1.state_ = "playing"
		arg_742_1.curTalkId_ = 1107506181
		arg_742_1.duration_ = 8.53

		SetActive(arg_742_1.tipsGo_, false)

		function arg_742_1.onSingleLineFinish_()
			arg_742_1.onSingleLineUpdate_ = nil
			arg_742_1.onSingleLineFinish_ = nil
			arg_742_1.state_ = "waiting"
		end

		function arg_742_1.playNext_(arg_744_0)
			if arg_744_0 == 1 then
				arg_742_0:Play1107506182(arg_742_1)
			end
		end

		function arg_742_1.onSingleLineUpdate_(arg_745_0)
			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 and not isNil(arg_742_1.actors_["1075ui_actor"]) and arg_742_1.var_.characterEffect1075ui_actor == nil then
				arg_742_1.var_.characterEffect1075ui_actor = arg_742_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_745_0 = 0.200000002980232

			if 0 <= arg_742_1.time_ and arg_742_1.time_ < 0 + var_745_0 and not isNil(arg_742_1.actors_["1075ui_actor"]) then
				if arg_742_1.var_.characterEffect1075ui_actor and not isNil(arg_742_1.actors_["1075ui_actor"]) then
					arg_742_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_742_1.time_ >= 0 + var_745_0 and arg_742_1.time_ < 0 + var_745_0 + arg_745_0 and not isNil(arg_742_1.actors_["1075ui_actor"]) and arg_742_1.var_.characterEffect1075ui_actor then
				arg_742_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 then
				arg_742_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action6_1")
			end

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 then
				arg_742_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_745_2 = 0
			local var_745_3 = 1.025

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= var_745_2 + arg_745_0 then
				arg_742_1.talkMaxDuration = 0
				arg_742_1.dialogCg_.alpha = 1

				arg_742_1.dialog_:SetActive(true)
				SetActive(arg_742_1.leftNameGo_, true)

				arg_742_1.leftNameTxt_.text = arg_742_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_742_1.leftNameTxt_.transform)

				arg_742_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_742_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_742_1:RecordName(arg_742_1.leftNameTxt_.text)
				SetActive(arg_742_1.iconTrs_.gameObject, false)
				arg_742_1.callingController_:SetSelectedState("normal")

				local var_745_4 = arg_742_1:GetWordFromCfg(1107506181)
				local var_745_5 = arg_742_1:FormatText(var_745_4.content)

				arg_742_1.text_.text = var_745_5

				LuaForUtil.ClearLinePrefixSymbol(arg_742_1.text_)

				local var_745_7 = 41 <= 0 and var_745_3 or var_745_3 * (utf8.len(var_745_5) / 41)

				if (41 <= 0 and var_745_3 or var_745_3 * (utf8.len(var_745_5) / 41)) > 0 and var_745_3 < var_745_7 then
					arg_742_1.talkMaxDuration = var_745_7

					if var_745_7 + var_745_2 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_7 + var_745_2
					end
				end

				arg_742_1.text_.text = var_745_5
				arg_742_1.typewritter.percent = 0

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506181", "story_v_side_new_1107506.awb") ~= 0 then
					local var_745_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506181", "story_v_side_new_1107506.awb") / 1000

					if var_745_8 + var_745_2 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_8 + var_745_2
					end

					if var_745_4.prefab_name ~= "" and arg_742_1.actors_[var_745_4.prefab_name] ~= nil then
						local var_745_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_742_1.actors_[var_745_4.prefab_name].transform, "story_v_side_new_1107506", "1107506181", "story_v_side_new_1107506.awb")

						arg_742_1:RecordAudio("1107506181", var_745_9)
						arg_742_1:RecordAudio("1107506181", var_745_9)
					else
						arg_742_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506181", "story_v_side_new_1107506.awb")
					end

					arg_742_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506181", "story_v_side_new_1107506.awb")
				end

				arg_742_1:RecordContent(arg_742_1.text_.text)
			end

			local var_745_10 = math.max(var_745_3, arg_742_1.talkMaxDuration)

			if var_745_2 <= arg_742_1.time_ and arg_742_1.time_ < var_745_2 + var_745_10 then
				arg_742_1.typewritter.percent = (arg_742_1.time_ - var_745_2) / var_745_10

				arg_742_1.typewritter:SetDirty()
			end

			if arg_742_1.time_ >= var_745_2 + var_745_10 and arg_742_1.time_ < var_745_2 + var_745_10 + arg_745_0 then
				arg_742_1.typewritter.percent = 1

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(true)
			end
		end

		arg_742_1.nodeConfigList_ = {}

		arg_742_1:InitPlayNodeList()
	end,
	Play1107506182 = function(arg_746_0, arg_746_1)
		arg_746_1.time_ = 0
		arg_746_1.frameCnt_ = 0
		arg_746_1.state_ = "playing"
		arg_746_1.curTalkId_ = 1107506182
		arg_746_1.duration_ = 5

		SetActive(arg_746_1.tipsGo_, false)

		function arg_746_1.onSingleLineFinish_()
			arg_746_1.onSingleLineUpdate_ = nil
			arg_746_1.onSingleLineFinish_ = nil
			arg_746_1.state_ = "waiting"
		end

		function arg_746_1.playNext_(arg_748_0)
			if arg_748_0 == 1 then
				arg_746_0:Play1107506183(arg_746_1)
			end
		end

		function arg_746_1.onSingleLineUpdate_(arg_749_0)
			if 0 < arg_746_1.time_ and arg_746_1.time_ <= 0 + arg_749_0 and not isNil(arg_746_1.actors_["1075ui_actor"]) and arg_746_1.var_.characterEffect1075ui_actor == nil then
				arg_746_1.var_.characterEffect1075ui_actor = arg_746_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_749_0 = 0.200000002980232

			if 0 <= arg_746_1.time_ and arg_746_1.time_ < 0 + var_749_0 and not isNil(arg_746_1.actors_["1075ui_actor"]) then
				if arg_746_1.var_.characterEffect1075ui_actor and not isNil(arg_746_1.actors_["1075ui_actor"]) then
					arg_746_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_746_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_746_1.time_ - 0) / var_749_0)
				end
			end

			if arg_746_1.time_ >= 0 + var_749_0 and arg_746_1.time_ < 0 + var_749_0 + arg_749_0 and not isNil(arg_746_1.actors_["1075ui_actor"]) and arg_746_1.var_.characterEffect1075ui_actor then
				arg_746_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_746_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_749_1 = 0
			local var_749_2 = 0.45

			if 0 < arg_746_1.time_ and arg_746_1.time_ <= var_749_1 + arg_749_0 then
				arg_746_1.talkMaxDuration = 0
				arg_746_1.dialogCg_.alpha = 1

				arg_746_1.dialog_:SetActive(true)
				SetActive(arg_746_1.leftNameGo_, true)

				arg_746_1.leftNameTxt_.text = arg_746_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_746_1.leftNameTxt_.transform)

				arg_746_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_746_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_746_1:RecordName(arg_746_1.leftNameTxt_.text)
				SetActive(arg_746_1.iconTrs_.gameObject, true)
				arg_746_1.iconController_:SetSelectedState("hero")

				arg_746_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_746_1.callingController_:SetSelectedState("normal")

				arg_746_1.keyicon_.color = Color.New(1, 1, 1)
				arg_746_1.icon_.color = Color.New(1, 1, 1)

				local var_749_3 = arg_746_1:FormatText(arg_746_1:GetWordFromCfg(1107506182).content)

				arg_746_1.text_.text = var_749_3

				LuaForUtil.ClearLinePrefixSymbol(arg_746_1.text_)

				local var_749_5 = 18 <= 0 and var_749_2 or var_749_2 * (utf8.len(var_749_3) / 18)

				if (18 <= 0 and var_749_2 or var_749_2 * (utf8.len(var_749_3) / 18)) > 0 and var_749_2 < var_749_5 then
					arg_746_1.talkMaxDuration = var_749_5

					if var_749_5 + var_749_1 > arg_746_1.duration_ then
						arg_746_1.duration_ = var_749_5 + var_749_1
					end
				end

				arg_746_1.text_.text = var_749_3
				arg_746_1.typewritter.percent = 0

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(false)
				arg_746_1:RecordContent(arg_746_1.text_.text)
			end

			local var_749_6 = math.max(var_749_2, arg_746_1.talkMaxDuration)

			if var_749_1 <= arg_746_1.time_ and arg_746_1.time_ < var_749_1 + var_749_6 then
				arg_746_1.typewritter.percent = (arg_746_1.time_ - var_749_1) / var_749_6

				arg_746_1.typewritter:SetDirty()
			end

			if arg_746_1.time_ >= var_749_1 + var_749_6 and arg_746_1.time_ < var_749_1 + var_749_6 + arg_749_0 then
				arg_746_1.typewritter.percent = 1

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(true)
			end
		end

		arg_746_1.nodeConfigList_ = {}

		arg_746_1:InitPlayNodeList()
	end,
	Play1107506183 = function(arg_750_0, arg_750_1)
		arg_750_1.time_ = 0
		arg_750_1.frameCnt_ = 0
		arg_750_1.state_ = "playing"
		arg_750_1.curTalkId_ = 1107506183
		arg_750_1.duration_ = 5

		SetActive(arg_750_1.tipsGo_, false)

		function arg_750_1.onSingleLineFinish_()
			arg_750_1.onSingleLineUpdate_ = nil
			arg_750_1.onSingleLineFinish_ = nil
			arg_750_1.state_ = "waiting"
		end

		function arg_750_1.playNext_(arg_752_0)
			if arg_752_0 == 1 then
				arg_750_0:Play1107506184(arg_750_1)
			end
		end

		function arg_750_1.onSingleLineUpdate_(arg_753_0)
			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1.var_.moveOldPos1075ui_actor = arg_750_1.actors_["1075ui_actor"].transform.localPosition

				local var_753_0 = GameObjectTools.GetOrAddComponent(arg_750_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_753_0 then
					var_753_0:EnableDynamicBone(false)
				end
			end

			local var_753_1 = 0.001

			if 0 <= arg_750_1.time_ and arg_750_1.time_ < 0 + var_753_1 then
				arg_750_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_750_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_750_1.time_ - 0) / var_753_1)
				arg_750_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_750_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_750_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_750_1.actors_["1075ui_actor"].transform.position).z)
				arg_750_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_750_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_750_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_750_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_750_1.time_ >= 0 + var_753_1 and arg_750_1.time_ < 0 + var_753_1 + arg_753_0 then
				arg_750_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_750_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_750_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_750_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_750_1.actors_["1075ui_actor"].transform.position).z)
				arg_750_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_750_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_750_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_750_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_753_2 = GameObjectTools.GetOrAddComponent(arg_750_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_753_2 then
					var_753_2:EnableDynamicBone(true)
				end
			end

			local var_753_3 = 0
			local var_753_4 = 0.55

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= var_753_3 + arg_753_0 then
				arg_750_1.talkMaxDuration = 0
				arg_750_1.dialogCg_.alpha = 1

				arg_750_1.dialog_:SetActive(true)
				SetActive(arg_750_1.leftNameGo_, false)

				arg_750_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_750_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_750_1:RecordName(arg_750_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_750_1.iconTrs_.gameObject, false)
				arg_750_1.callingController_:SetSelectedState("normal")

				local var_753_5 = arg_750_1:FormatText(arg_750_1:GetWordFromCfg(1107506183).content)

				arg_750_1.text_.text = var_753_5

				LuaForUtil.ClearLinePrefixSymbol(arg_750_1.text_)

				local var_753_7 = 22 <= 0 and var_753_4 or var_753_4 * (utf8.len(var_753_5) / 22)

				if (22 <= 0 and var_753_4 or var_753_4 * (utf8.len(var_753_5) / 22)) > 0 and var_753_4 < var_753_7 then
					arg_750_1.talkMaxDuration = var_753_7

					if var_753_7 + var_753_3 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_7 + var_753_3
					end
				end

				arg_750_1.text_.text = var_753_5
				arg_750_1.typewritter.percent = 0

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(false)
				arg_750_1:RecordContent(arg_750_1.text_.text)
			end

			local var_753_8 = math.max(var_753_4, arg_750_1.talkMaxDuration)

			if var_753_3 <= arg_750_1.time_ and arg_750_1.time_ < var_753_3 + var_753_8 then
				arg_750_1.typewritter.percent = (arg_750_1.time_ - var_753_3) / var_753_8

				arg_750_1.typewritter:SetDirty()
			end

			if arg_750_1.time_ >= var_753_3 + var_753_8 and arg_750_1.time_ < var_753_3 + var_753_8 + arg_753_0 then
				arg_750_1.typewritter.percent = 1

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(true)
			end
		end

		arg_750_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_750_1:InitPlayNodeList()
	end,
	Play1107506184 = function(arg_754_0, arg_754_1)
		arg_754_1.time_ = 0
		arg_754_1.frameCnt_ = 0
		arg_754_1.state_ = "playing"
		arg_754_1.curTalkId_ = 1107506184
		arg_754_1.duration_ = 5

		SetActive(arg_754_1.tipsGo_, false)

		function arg_754_1.onSingleLineFinish_()
			arg_754_1.onSingleLineUpdate_ = nil
			arg_754_1.onSingleLineFinish_ = nil
			arg_754_1.state_ = "waiting"
		end

		function arg_754_1.playNext_(arg_756_0)
			if arg_756_0 == 1 then
				arg_754_0:Play1107506185(arg_754_1)
			end
		end

		function arg_754_1.onSingleLineUpdate_(arg_757_0)
			local var_757_0 = 0.25

			if 0 < arg_754_1.time_ and arg_754_1.time_ <= 0 + arg_757_0 then
				arg_754_1.talkMaxDuration = 0
				arg_754_1.dialogCg_.alpha = 1

				arg_754_1.dialog_:SetActive(true)
				SetActive(arg_754_1.leftNameGo_, true)

				arg_754_1.leftNameTxt_.text = arg_754_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_754_1.leftNameTxt_.transform)

				arg_754_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_754_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_754_1:RecordName(arg_754_1.leftNameTxt_.text)
				SetActive(arg_754_1.iconTrs_.gameObject, true)
				arg_754_1.iconController_:SetSelectedState("hero")

				arg_754_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_754_1.callingController_:SetSelectedState("normal")

				arg_754_1.keyicon_.color = Color.New(1, 1, 1)
				arg_754_1.icon_.color = Color.New(1, 1, 1)

				local var_757_1 = arg_754_1:FormatText(arg_754_1:GetWordFromCfg(1107506184).content)

				arg_754_1.text_.text = var_757_1

				LuaForUtil.ClearLinePrefixSymbol(arg_754_1.text_)

				local var_757_3 = 10 <= 0 and var_757_0 or var_757_0 * (utf8.len(var_757_1) / 10)

				if (10 <= 0 and var_757_0 or var_757_0 * (utf8.len(var_757_1) / 10)) > 0 and var_757_0 < var_757_3 then
					arg_754_1.talkMaxDuration = var_757_3

					if var_757_3 + 0 > arg_754_1.duration_ then
						arg_754_1.duration_ = var_757_3 + 0
					end
				end

				arg_754_1.text_.text = var_757_1
				arg_754_1.typewritter.percent = 0

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(false)
				arg_754_1:RecordContent(arg_754_1.text_.text)
			end

			local var_757_4 = math.max(var_757_0, arg_754_1.talkMaxDuration)

			if 0 <= arg_754_1.time_ and arg_754_1.time_ < 0 + var_757_4 then
				arg_754_1.typewritter.percent = (arg_754_1.time_ - 0) / var_757_4

				arg_754_1.typewritter:SetDirty()
			end

			if arg_754_1.time_ >= 0 + var_757_4 and arg_754_1.time_ < 0 + var_757_4 + arg_757_0 then
				arg_754_1.typewritter.percent = 1

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(true)
			end
		end

		arg_754_1.nodeConfigList_ = {}

		arg_754_1:InitPlayNodeList()
	end,
	Play1107506185 = function(arg_758_0, arg_758_1)
		arg_758_1.time_ = 0
		arg_758_1.frameCnt_ = 0
		arg_758_1.state_ = "playing"
		arg_758_1.curTalkId_ = 1107506185
		arg_758_1.duration_ = 5

		SetActive(arg_758_1.tipsGo_, false)

		function arg_758_1.onSingleLineFinish_()
			arg_758_1.onSingleLineUpdate_ = nil
			arg_758_1.onSingleLineFinish_ = nil
			arg_758_1.state_ = "waiting"
		end

		function arg_758_1.playNext_(arg_760_0)
			if arg_760_0 == 1 then
				arg_758_0:Play1107506186(arg_758_1)
			end
		end

		function arg_758_1.onSingleLineUpdate_(arg_761_0)
			local var_761_0 = 0.7

			if 0 < arg_758_1.time_ and arg_758_1.time_ <= 0 + arg_761_0 then
				arg_758_1.talkMaxDuration = 0
				arg_758_1.dialogCg_.alpha = 1

				arg_758_1.dialog_:SetActive(true)
				SetActive(arg_758_1.leftNameGo_, false)

				arg_758_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_758_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_758_1:RecordName(arg_758_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_758_1.iconTrs_.gameObject, false)
				arg_758_1.callingController_:SetSelectedState("normal")

				local var_761_1 = arg_758_1:FormatText(arg_758_1:GetWordFromCfg(1107506185).content)

				arg_758_1.text_.text = var_761_1

				LuaForUtil.ClearLinePrefixSymbol(arg_758_1.text_)

				local var_761_3 = 28 <= 0 and var_761_0 or var_761_0 * (utf8.len(var_761_1) / 28)

				if (28 <= 0 and var_761_0 or var_761_0 * (utf8.len(var_761_1) / 28)) > 0 and var_761_0 < var_761_3 then
					arg_758_1.talkMaxDuration = var_761_3

					if var_761_3 + 0 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_3 + 0
					end
				end

				arg_758_1.text_.text = var_761_1
				arg_758_1.typewritter.percent = 0

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(false)
				arg_758_1:RecordContent(arg_758_1.text_.text)
			end

			local var_761_4 = math.max(var_761_0, arg_758_1.talkMaxDuration)

			if 0 <= arg_758_1.time_ and arg_758_1.time_ < 0 + var_761_4 then
				arg_758_1.typewritter.percent = (arg_758_1.time_ - 0) / var_761_4

				arg_758_1.typewritter:SetDirty()
			end

			if arg_758_1.time_ >= 0 + var_761_4 and arg_758_1.time_ < 0 + var_761_4 + arg_761_0 then
				arg_758_1.typewritter.percent = 1

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(true)
			end
		end

		arg_758_1.nodeConfigList_ = {}

		arg_758_1:InitPlayNodeList()
	end,
	Play1107506186 = function(arg_762_0, arg_762_1)
		arg_762_1.time_ = 0
		arg_762_1.frameCnt_ = 0
		arg_762_1.state_ = "playing"
		arg_762_1.curTalkId_ = 1107506186
		arg_762_1.duration_ = 3.3

		SetActive(arg_762_1.tipsGo_, false)

		function arg_762_1.onSingleLineFinish_()
			arg_762_1.onSingleLineUpdate_ = nil
			arg_762_1.onSingleLineFinish_ = nil
			arg_762_1.state_ = "waiting"
		end

		function arg_762_1.playNext_(arg_764_0)
			if arg_764_0 == 1 then
				arg_762_0:Play1107506187(arg_762_1)
			end
		end

		function arg_762_1.onSingleLineUpdate_(arg_765_0)
			if 0 < arg_762_1.time_ and arg_762_1.time_ <= 0 + arg_765_0 then
				arg_762_1.var_.moveOldPos1075ui_actor = arg_762_1.actors_["1075ui_actor"].transform.localPosition

				local var_765_0 = GameObjectTools.GetOrAddComponent(arg_762_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_765_0 then
					var_765_0:EnableDynamicBone(false)
				end
			end

			local var_765_1 = 0.001

			if 0 <= arg_762_1.time_ and arg_762_1.time_ < 0 + var_765_1 then
				arg_762_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_762_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_762_1.time_ - 0) / var_765_1)
				arg_762_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_762_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_762_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_762_1.actors_["1075ui_actor"].transform.position).z)
				arg_762_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_762_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_762_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_762_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_762_1.time_ >= 0 + var_765_1 and arg_762_1.time_ < 0 + var_765_1 + arg_765_0 then
				arg_762_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_762_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_762_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_762_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_762_1.actors_["1075ui_actor"].transform.position).z)
				arg_762_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_762_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_762_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_762_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_765_2 = GameObjectTools.GetOrAddComponent(arg_762_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_765_2 then
					var_765_2:EnableDynamicBone(true)
				end
			end

			local var_765_3 = arg_762_1.actors_["1075ui_actor"]

			if 0 < arg_762_1.time_ and arg_762_1.time_ <= 0 + arg_765_0 and not isNil(var_765_3) and arg_762_1.var_.characterEffect1075ui_actor == nil then
				arg_762_1.var_.characterEffect1075ui_actor = var_765_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_765_4 = 0.200000002980232

			if 0 <= arg_762_1.time_ and arg_762_1.time_ < 0 + var_765_4 and not isNil(var_765_3) then
				if arg_762_1.var_.characterEffect1075ui_actor and not isNil(var_765_3) then
					arg_762_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_762_1.time_ >= 0 + var_765_4 and arg_762_1.time_ < 0 + var_765_4 + arg_765_0 and not isNil(var_765_3) and arg_762_1.var_.characterEffect1075ui_actor then
				arg_762_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_762_1.time_ and arg_762_1.time_ <= 0 + arg_765_0 then
				arg_762_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action6_2")
			end

			if 0 < arg_762_1.time_ and arg_762_1.time_ <= 0 + arg_765_0 then
				arg_762_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_765_6 = 0
			local var_765_7 = 0.3

			if 0 < arg_762_1.time_ and arg_762_1.time_ <= var_765_6 + arg_765_0 then
				arg_762_1.talkMaxDuration = 0
				arg_762_1.dialogCg_.alpha = 1

				arg_762_1.dialog_:SetActive(true)
				SetActive(arg_762_1.leftNameGo_, true)

				arg_762_1.leftNameTxt_.text = arg_762_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_762_1.leftNameTxt_.transform)

				arg_762_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_762_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_762_1:RecordName(arg_762_1.leftNameTxt_.text)
				SetActive(arg_762_1.iconTrs_.gameObject, false)
				arg_762_1.callingController_:SetSelectedState("normal")

				local var_765_8 = arg_762_1:GetWordFromCfg(1107506186)
				local var_765_9 = arg_762_1:FormatText(var_765_8.content)

				arg_762_1.text_.text = var_765_9

				LuaForUtil.ClearLinePrefixSymbol(arg_762_1.text_)

				local var_765_11 = 12 <= 0 and var_765_7 or var_765_7 * (utf8.len(var_765_9) / 12)

				if (12 <= 0 and var_765_7 or var_765_7 * (utf8.len(var_765_9) / 12)) > 0 and var_765_7 < var_765_11 then
					arg_762_1.talkMaxDuration = var_765_11

					if var_765_11 + var_765_6 > arg_762_1.duration_ then
						arg_762_1.duration_ = var_765_11 + var_765_6
					end
				end

				arg_762_1.text_.text = var_765_9
				arg_762_1.typewritter.percent = 0

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506186", "story_v_side_new_1107506.awb") ~= 0 then
					local var_765_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506186", "story_v_side_new_1107506.awb") / 1000

					if var_765_12 + var_765_6 > arg_762_1.duration_ then
						arg_762_1.duration_ = var_765_12 + var_765_6
					end

					if var_765_8.prefab_name ~= "" and arg_762_1.actors_[var_765_8.prefab_name] ~= nil then
						local var_765_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_762_1.actors_[var_765_8.prefab_name].transform, "story_v_side_new_1107506", "1107506186", "story_v_side_new_1107506.awb")

						arg_762_1:RecordAudio("1107506186", var_765_13)
						arg_762_1:RecordAudio("1107506186", var_765_13)
					else
						arg_762_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506186", "story_v_side_new_1107506.awb")
					end

					arg_762_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506186", "story_v_side_new_1107506.awb")
				end

				arg_762_1:RecordContent(arg_762_1.text_.text)
			end

			local var_765_14 = math.max(var_765_7, arg_762_1.talkMaxDuration)

			if var_765_6 <= arg_762_1.time_ and arg_762_1.time_ < var_765_6 + var_765_14 then
				arg_762_1.typewritter.percent = (arg_762_1.time_ - var_765_6) / var_765_14

				arg_762_1.typewritter:SetDirty()
			end

			if arg_762_1.time_ >= var_765_6 + var_765_14 and arg_762_1.time_ < var_765_6 + var_765_14 + arg_765_0 then
				arg_762_1.typewritter.percent = 1

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(true)
			end
		end

		arg_762_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_762_1:InitPlayNodeList()
	end,
	Play1107506187 = function(arg_766_0, arg_766_1)
		arg_766_1.time_ = 0
		arg_766_1.frameCnt_ = 0
		arg_766_1.state_ = "playing"
		arg_766_1.curTalkId_ = 1107506187
		arg_766_1.duration_ = 5

		SetActive(arg_766_1.tipsGo_, false)

		function arg_766_1.onSingleLineFinish_()
			arg_766_1.onSingleLineUpdate_ = nil
			arg_766_1.onSingleLineFinish_ = nil
			arg_766_1.state_ = "waiting"
		end

		function arg_766_1.playNext_(arg_768_0)
			if arg_768_0 == 1 then
				arg_766_0:Play1107506188(arg_766_1)
			end
		end

		function arg_766_1.onSingleLineUpdate_(arg_769_0)
			if 0 < arg_766_1.time_ and arg_766_1.time_ <= 0 + arg_769_0 and not isNil(arg_766_1.actors_["1075ui_actor"]) and arg_766_1.var_.characterEffect1075ui_actor == nil then
				arg_766_1.var_.characterEffect1075ui_actor = arg_766_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_769_0 = 0.200000002980232

			if 0 <= arg_766_1.time_ and arg_766_1.time_ < 0 + var_769_0 and not isNil(arg_766_1.actors_["1075ui_actor"]) then
				if arg_766_1.var_.characterEffect1075ui_actor and not isNil(arg_766_1.actors_["1075ui_actor"]) then
					arg_766_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_766_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_766_1.time_ - 0) / var_769_0)
				end
			end

			if arg_766_1.time_ >= 0 + var_769_0 and arg_766_1.time_ < 0 + var_769_0 + arg_769_0 and not isNil(arg_766_1.actors_["1075ui_actor"]) and arg_766_1.var_.characterEffect1075ui_actor then
				arg_766_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_766_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_769_1 = 0
			local var_769_2 = 0.35

			if 0 < arg_766_1.time_ and arg_766_1.time_ <= var_769_1 + arg_769_0 then
				arg_766_1.talkMaxDuration = 0
				arg_766_1.dialogCg_.alpha = 1

				arg_766_1.dialog_:SetActive(true)
				SetActive(arg_766_1.leftNameGo_, true)

				arg_766_1.leftNameTxt_.text = arg_766_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_766_1.leftNameTxt_.transform)

				arg_766_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_766_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_766_1:RecordName(arg_766_1.leftNameTxt_.text)
				SetActive(arg_766_1.iconTrs_.gameObject, true)
				arg_766_1.iconController_:SetSelectedState("hero")

				arg_766_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_766_1.callingController_:SetSelectedState("normal")

				arg_766_1.keyicon_.color = Color.New(1, 1, 1)
				arg_766_1.icon_.color = Color.New(1, 1, 1)

				local var_769_3 = arg_766_1:FormatText(arg_766_1:GetWordFromCfg(1107506187).content)

				arg_766_1.text_.text = var_769_3

				LuaForUtil.ClearLinePrefixSymbol(arg_766_1.text_)

				local var_769_5 = 14 <= 0 and var_769_2 or var_769_2 * (utf8.len(var_769_3) / 14)

				if (14 <= 0 and var_769_2 or var_769_2 * (utf8.len(var_769_3) / 14)) > 0 and var_769_2 < var_769_5 then
					arg_766_1.talkMaxDuration = var_769_5

					if var_769_5 + var_769_1 > arg_766_1.duration_ then
						arg_766_1.duration_ = var_769_5 + var_769_1
					end
				end

				arg_766_1.text_.text = var_769_3
				arg_766_1.typewritter.percent = 0

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(false)
				arg_766_1:RecordContent(arg_766_1.text_.text)
			end

			local var_769_6 = math.max(var_769_2, arg_766_1.talkMaxDuration)

			if var_769_1 <= arg_766_1.time_ and arg_766_1.time_ < var_769_1 + var_769_6 then
				arg_766_1.typewritter.percent = (arg_766_1.time_ - var_769_1) / var_769_6

				arg_766_1.typewritter:SetDirty()
			end

			if arg_766_1.time_ >= var_769_1 + var_769_6 and arg_766_1.time_ < var_769_1 + var_769_6 + arg_769_0 then
				arg_766_1.typewritter.percent = 1

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(true)
			end
		end

		arg_766_1.nodeConfigList_ = {}

		arg_766_1:InitPlayNodeList()
	end,
	Play1107506188 = function(arg_770_0, arg_770_1)
		arg_770_1.time_ = 0
		arg_770_1.frameCnt_ = 0
		arg_770_1.state_ = "playing"
		arg_770_1.curTalkId_ = 1107506188
		arg_770_1.duration_ = 4.1

		SetActive(arg_770_1.tipsGo_, false)

		function arg_770_1.onSingleLineFinish_()
			arg_770_1.onSingleLineUpdate_ = nil
			arg_770_1.onSingleLineFinish_ = nil
			arg_770_1.state_ = "waiting"
		end

		function arg_770_1.playNext_(arg_772_0)
			if arg_772_0 == 1 then
				arg_770_0:Play1107506189(arg_770_1)
			end
		end

		function arg_770_1.onSingleLineUpdate_(arg_773_0)
			if 0 < arg_770_1.time_ and arg_770_1.time_ <= 0 + arg_773_0 and not isNil(arg_770_1.actors_["1075ui_actor"]) and arg_770_1.var_.characterEffect1075ui_actor == nil then
				arg_770_1.var_.characterEffect1075ui_actor = arg_770_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_773_0 = 0.200000002980232

			if 0 <= arg_770_1.time_ and arg_770_1.time_ < 0 + var_773_0 and not isNil(arg_770_1.actors_["1075ui_actor"]) then
				if arg_770_1.var_.characterEffect1075ui_actor and not isNil(arg_770_1.actors_["1075ui_actor"]) then
					arg_770_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_770_1.time_ >= 0 + var_773_0 and arg_770_1.time_ < 0 + var_773_0 + arg_773_0 and not isNil(arg_770_1.actors_["1075ui_actor"]) and arg_770_1.var_.characterEffect1075ui_actor then
				arg_770_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_770_1.time_ and arg_770_1.time_ <= 0 + arg_773_0 then
				arg_770_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_770_1.time_ and arg_770_1.time_ <= 0 + arg_773_0 then
				arg_770_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_773_2 = 0
			local var_773_3 = 0.425

			if 0 < arg_770_1.time_ and arg_770_1.time_ <= var_773_2 + arg_773_0 then
				arg_770_1.talkMaxDuration = 0
				arg_770_1.dialogCg_.alpha = 1

				arg_770_1.dialog_:SetActive(true)
				SetActive(arg_770_1.leftNameGo_, true)

				arg_770_1.leftNameTxt_.text = arg_770_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_770_1.leftNameTxt_.transform)

				arg_770_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_770_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_770_1:RecordName(arg_770_1.leftNameTxt_.text)
				SetActive(arg_770_1.iconTrs_.gameObject, false)
				arg_770_1.callingController_:SetSelectedState("normal")

				local var_773_4 = arg_770_1:GetWordFromCfg(1107506188)
				local var_773_5 = arg_770_1:FormatText(var_773_4.content)

				arg_770_1.text_.text = var_773_5

				LuaForUtil.ClearLinePrefixSymbol(arg_770_1.text_)

				local var_773_7 = 17 <= 0 and var_773_3 or var_773_3 * (utf8.len(var_773_5) / 17)

				if (17 <= 0 and var_773_3 or var_773_3 * (utf8.len(var_773_5) / 17)) > 0 and var_773_3 < var_773_7 then
					arg_770_1.talkMaxDuration = var_773_7

					if var_773_7 + var_773_2 > arg_770_1.duration_ then
						arg_770_1.duration_ = var_773_7 + var_773_2
					end
				end

				arg_770_1.text_.text = var_773_5
				arg_770_1.typewritter.percent = 0

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506188", "story_v_side_new_1107506.awb") ~= 0 then
					local var_773_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506188", "story_v_side_new_1107506.awb") / 1000

					if var_773_8 + var_773_2 > arg_770_1.duration_ then
						arg_770_1.duration_ = var_773_8 + var_773_2
					end

					if var_773_4.prefab_name ~= "" and arg_770_1.actors_[var_773_4.prefab_name] ~= nil then
						local var_773_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_770_1.actors_[var_773_4.prefab_name].transform, "story_v_side_new_1107506", "1107506188", "story_v_side_new_1107506.awb")

						arg_770_1:RecordAudio("1107506188", var_773_9)
						arg_770_1:RecordAudio("1107506188", var_773_9)
					else
						arg_770_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506188", "story_v_side_new_1107506.awb")
					end

					arg_770_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506188", "story_v_side_new_1107506.awb")
				end

				arg_770_1:RecordContent(arg_770_1.text_.text)
			end

			local var_773_10 = math.max(var_773_3, arg_770_1.talkMaxDuration)

			if var_773_2 <= arg_770_1.time_ and arg_770_1.time_ < var_773_2 + var_773_10 then
				arg_770_1.typewritter.percent = (arg_770_1.time_ - var_773_2) / var_773_10

				arg_770_1.typewritter:SetDirty()
			end

			if arg_770_1.time_ >= var_773_2 + var_773_10 and arg_770_1.time_ < var_773_2 + var_773_10 + arg_773_0 then
				arg_770_1.typewritter.percent = 1

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(true)
			end
		end

		arg_770_1.nodeConfigList_ = {}

		arg_770_1:InitPlayNodeList()
	end,
	Play1107506189 = function(arg_774_0, arg_774_1)
		arg_774_1.time_ = 0
		arg_774_1.frameCnt_ = 0
		arg_774_1.state_ = "playing"
		arg_774_1.curTalkId_ = 1107506189
		arg_774_1.duration_ = 5

		SetActive(arg_774_1.tipsGo_, false)

		function arg_774_1.onSingleLineFinish_()
			arg_774_1.onSingleLineUpdate_ = nil
			arg_774_1.onSingleLineFinish_ = nil
			arg_774_1.state_ = "waiting"
		end

		function arg_774_1.playNext_(arg_776_0)
			if arg_776_0 == 1 then
				arg_774_0:Play1107506190(arg_774_1)
			end
		end

		function arg_774_1.onSingleLineUpdate_(arg_777_0)
			if 0 < arg_774_1.time_ and arg_774_1.time_ <= 0 + arg_777_0 and not isNil(arg_774_1.actors_["1075ui_actor"]) and arg_774_1.var_.characterEffect1075ui_actor == nil then
				arg_774_1.var_.characterEffect1075ui_actor = arg_774_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_777_0 = 0.200000002980232

			if 0 <= arg_774_1.time_ and arg_774_1.time_ < 0 + var_777_0 and not isNil(arg_774_1.actors_["1075ui_actor"]) then
				if arg_774_1.var_.characterEffect1075ui_actor and not isNil(arg_774_1.actors_["1075ui_actor"]) then
					arg_774_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_774_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_774_1.time_ - 0) / var_777_0)
				end
			end

			if arg_774_1.time_ >= 0 + var_777_0 and arg_774_1.time_ < 0 + var_777_0 + arg_777_0 and not isNil(arg_774_1.actors_["1075ui_actor"]) and arg_774_1.var_.characterEffect1075ui_actor then
				arg_774_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_774_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_777_1 = 0
			local var_777_2 = 0.35

			if 0 < arg_774_1.time_ and arg_774_1.time_ <= var_777_1 + arg_777_0 then
				arg_774_1.talkMaxDuration = 0
				arg_774_1.dialogCg_.alpha = 1

				arg_774_1.dialog_:SetActive(true)
				SetActive(arg_774_1.leftNameGo_, true)

				arg_774_1.leftNameTxt_.text = arg_774_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_774_1.leftNameTxt_.transform)

				arg_774_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_774_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_774_1:RecordName(arg_774_1.leftNameTxt_.text)
				SetActive(arg_774_1.iconTrs_.gameObject, true)
				arg_774_1.iconController_:SetSelectedState("hero")

				arg_774_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_774_1.callingController_:SetSelectedState("normal")

				arg_774_1.keyicon_.color = Color.New(1, 1, 1)
				arg_774_1.icon_.color = Color.New(1, 1, 1)

				local var_777_3 = arg_774_1:FormatText(arg_774_1:GetWordFromCfg(1107506189).content)

				arg_774_1.text_.text = var_777_3

				LuaForUtil.ClearLinePrefixSymbol(arg_774_1.text_)

				local var_777_5 = 14 <= 0 and var_777_2 or var_777_2 * (utf8.len(var_777_3) / 14)

				if (14 <= 0 and var_777_2 or var_777_2 * (utf8.len(var_777_3) / 14)) > 0 and var_777_2 < var_777_5 then
					arg_774_1.talkMaxDuration = var_777_5

					if var_777_5 + var_777_1 > arg_774_1.duration_ then
						arg_774_1.duration_ = var_777_5 + var_777_1
					end
				end

				arg_774_1.text_.text = var_777_3
				arg_774_1.typewritter.percent = 0

				arg_774_1.typewritter:SetDirty()
				arg_774_1:ShowNextGo(false)
				arg_774_1:RecordContent(arg_774_1.text_.text)
			end

			local var_777_6 = math.max(var_777_2, arg_774_1.talkMaxDuration)

			if var_777_1 <= arg_774_1.time_ and arg_774_1.time_ < var_777_1 + var_777_6 then
				arg_774_1.typewritter.percent = (arg_774_1.time_ - var_777_1) / var_777_6

				arg_774_1.typewritter:SetDirty()
			end

			if arg_774_1.time_ >= var_777_1 + var_777_6 and arg_774_1.time_ < var_777_1 + var_777_6 + arg_777_0 then
				arg_774_1.typewritter.percent = 1

				arg_774_1.typewritter:SetDirty()
				arg_774_1:ShowNextGo(true)
			end
		end

		arg_774_1.nodeConfigList_ = {}

		arg_774_1:InitPlayNodeList()
	end,
	Play1107506190 = function(arg_778_0, arg_778_1)
		arg_778_1.time_ = 0
		arg_778_1.frameCnt_ = 0
		arg_778_1.state_ = "playing"
		arg_778_1.curTalkId_ = 1107506190
		arg_778_1.duration_ = 3.67

		SetActive(arg_778_1.tipsGo_, false)

		function arg_778_1.onSingleLineFinish_()
			arg_778_1.onSingleLineUpdate_ = nil
			arg_778_1.onSingleLineFinish_ = nil
			arg_778_1.state_ = "waiting"
		end

		function arg_778_1.playNext_(arg_780_0)
			if arg_780_0 == 1 then
				arg_778_0:Play1107506191(arg_778_1)
			end
		end

		function arg_778_1.onSingleLineUpdate_(arg_781_0)
			if 0 < arg_778_1.time_ and arg_778_1.time_ <= 0 + arg_781_0 and not isNil(arg_778_1.actors_["1075ui_actor"]) and arg_778_1.var_.characterEffect1075ui_actor == nil then
				arg_778_1.var_.characterEffect1075ui_actor = arg_778_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_781_0 = 0.200000002980232

			if 0 <= arg_778_1.time_ and arg_778_1.time_ < 0 + var_781_0 and not isNil(arg_778_1.actors_["1075ui_actor"]) then
				if arg_778_1.var_.characterEffect1075ui_actor and not isNil(arg_778_1.actors_["1075ui_actor"]) then
					arg_778_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_778_1.time_ >= 0 + var_781_0 and arg_778_1.time_ < 0 + var_781_0 + arg_781_0 and not isNil(arg_778_1.actors_["1075ui_actor"]) and arg_778_1.var_.characterEffect1075ui_actor then
				arg_778_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			if 0 < arg_778_1.time_ and arg_778_1.time_ <= 0 + arg_781_0 then
				arg_778_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_778_1.time_ and arg_778_1.time_ <= 0 + arg_781_0 then
				arg_778_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_781_2 = 0
			local var_781_3 = 0.4

			if 0 < arg_778_1.time_ and arg_778_1.time_ <= var_781_2 + arg_781_0 then
				arg_778_1.talkMaxDuration = 0
				arg_778_1.dialogCg_.alpha = 1

				arg_778_1.dialog_:SetActive(true)
				SetActive(arg_778_1.leftNameGo_, true)

				arg_778_1.leftNameTxt_.text = arg_778_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_778_1.leftNameTxt_.transform)

				arg_778_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_778_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_778_1:RecordName(arg_778_1.leftNameTxt_.text)
				SetActive(arg_778_1.iconTrs_.gameObject, false)
				arg_778_1.callingController_:SetSelectedState("normal")

				local var_781_4 = arg_778_1:GetWordFromCfg(1107506190)
				local var_781_5 = arg_778_1:FormatText(var_781_4.content)

				arg_778_1.text_.text = var_781_5

				LuaForUtil.ClearLinePrefixSymbol(arg_778_1.text_)

				local var_781_7 = 16 <= 0 and var_781_3 or var_781_3 * (utf8.len(var_781_5) / 16)

				if (16 <= 0 and var_781_3 or var_781_3 * (utf8.len(var_781_5) / 16)) > 0 and var_781_3 < var_781_7 then
					arg_778_1.talkMaxDuration = var_781_7

					if var_781_7 + var_781_2 > arg_778_1.duration_ then
						arg_778_1.duration_ = var_781_7 + var_781_2
					end
				end

				arg_778_1.text_.text = var_781_5
				arg_778_1.typewritter.percent = 0

				arg_778_1.typewritter:SetDirty()
				arg_778_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506190", "story_v_side_new_1107506.awb") ~= 0 then
					local var_781_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506190", "story_v_side_new_1107506.awb") / 1000

					if var_781_8 + var_781_2 > arg_778_1.duration_ then
						arg_778_1.duration_ = var_781_8 + var_781_2
					end

					if var_781_4.prefab_name ~= "" and arg_778_1.actors_[var_781_4.prefab_name] ~= nil then
						local var_781_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_778_1.actors_[var_781_4.prefab_name].transform, "story_v_side_new_1107506", "1107506190", "story_v_side_new_1107506.awb")

						arg_778_1:RecordAudio("1107506190", var_781_9)
						arg_778_1:RecordAudio("1107506190", var_781_9)
					else
						arg_778_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506190", "story_v_side_new_1107506.awb")
					end

					arg_778_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506190", "story_v_side_new_1107506.awb")
				end

				arg_778_1:RecordContent(arg_778_1.text_.text)
			end

			local var_781_10 = math.max(var_781_3, arg_778_1.talkMaxDuration)

			if var_781_2 <= arg_778_1.time_ and arg_778_1.time_ < var_781_2 + var_781_10 then
				arg_778_1.typewritter.percent = (arg_778_1.time_ - var_781_2) / var_781_10

				arg_778_1.typewritter:SetDirty()
			end

			if arg_778_1.time_ >= var_781_2 + var_781_10 and arg_778_1.time_ < var_781_2 + var_781_10 + arg_781_0 then
				arg_778_1.typewritter.percent = 1

				arg_778_1.typewritter:SetDirty()
				arg_778_1:ShowNextGo(true)
			end
		end

		arg_778_1.nodeConfigList_ = {}

		arg_778_1:InitPlayNodeList()
	end,
	Play1107506191 = function(arg_782_0, arg_782_1)
		arg_782_1.time_ = 0
		arg_782_1.frameCnt_ = 0
		arg_782_1.state_ = "playing"
		arg_782_1.curTalkId_ = 1107506191
		arg_782_1.duration_ = 5

		SetActive(arg_782_1.tipsGo_, false)

		function arg_782_1.onSingleLineFinish_()
			arg_782_1.onSingleLineUpdate_ = nil
			arg_782_1.onSingleLineFinish_ = nil
			arg_782_1.state_ = "waiting"
		end

		function arg_782_1.playNext_(arg_784_0)
			if arg_784_0 == 1 then
				arg_782_0:Play1107506192(arg_782_1)
			end
		end

		function arg_782_1.onSingleLineUpdate_(arg_785_0)
			if 0 < arg_782_1.time_ and arg_782_1.time_ <= 0 + arg_785_0 and not isNil(arg_782_1.actors_["1075ui_actor"]) and arg_782_1.var_.characterEffect1075ui_actor == nil then
				arg_782_1.var_.characterEffect1075ui_actor = arg_782_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_785_0 = 0.200000002980232

			if 0 <= arg_782_1.time_ and arg_782_1.time_ < 0 + var_785_0 and not isNil(arg_782_1.actors_["1075ui_actor"]) then
				if arg_782_1.var_.characterEffect1075ui_actor and not isNil(arg_782_1.actors_["1075ui_actor"]) then
					arg_782_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_782_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_782_1.time_ - 0) / var_785_0)
				end
			end

			if arg_782_1.time_ >= 0 + var_785_0 and arg_782_1.time_ < 0 + var_785_0 + arg_785_0 and not isNil(arg_782_1.actors_["1075ui_actor"]) and arg_782_1.var_.characterEffect1075ui_actor then
				arg_782_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_782_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_785_1 = 0
			local var_785_2 = 0.5

			if 0 < arg_782_1.time_ and arg_782_1.time_ <= var_785_1 + arg_785_0 then
				arg_782_1.talkMaxDuration = 0
				arg_782_1.dialogCg_.alpha = 1

				arg_782_1.dialog_:SetActive(true)
				SetActive(arg_782_1.leftNameGo_, true)

				arg_782_1.leftNameTxt_.text = arg_782_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_782_1.leftNameTxt_.transform)

				arg_782_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_782_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_782_1:RecordName(arg_782_1.leftNameTxt_.text)
				SetActive(arg_782_1.iconTrs_.gameObject, true)
				arg_782_1.iconController_:SetSelectedState("hero")

				arg_782_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_782_1.callingController_:SetSelectedState("normal")

				arg_782_1.keyicon_.color = Color.New(1, 1, 1)
				arg_782_1.icon_.color = Color.New(1, 1, 1)

				local var_785_3 = arg_782_1:FormatText(arg_782_1:GetWordFromCfg(1107506191).content)

				arg_782_1.text_.text = var_785_3

				LuaForUtil.ClearLinePrefixSymbol(arg_782_1.text_)

				local var_785_5 = 20 <= 0 and var_785_2 or var_785_2 * (utf8.len(var_785_3) / 20)

				if (20 <= 0 and var_785_2 or var_785_2 * (utf8.len(var_785_3) / 20)) > 0 and var_785_2 < var_785_5 then
					arg_782_1.talkMaxDuration = var_785_5

					if var_785_5 + var_785_1 > arg_782_1.duration_ then
						arg_782_1.duration_ = var_785_5 + var_785_1
					end
				end

				arg_782_1.text_.text = var_785_3
				arg_782_1.typewritter.percent = 0

				arg_782_1.typewritter:SetDirty()
				arg_782_1:ShowNextGo(false)
				arg_782_1:RecordContent(arg_782_1.text_.text)
			end

			local var_785_6 = math.max(var_785_2, arg_782_1.talkMaxDuration)

			if var_785_1 <= arg_782_1.time_ and arg_782_1.time_ < var_785_1 + var_785_6 then
				arg_782_1.typewritter.percent = (arg_782_1.time_ - var_785_1) / var_785_6

				arg_782_1.typewritter:SetDirty()
			end

			if arg_782_1.time_ >= var_785_1 + var_785_6 and arg_782_1.time_ < var_785_1 + var_785_6 + arg_785_0 then
				arg_782_1.typewritter.percent = 1

				arg_782_1.typewritter:SetDirty()
				arg_782_1:ShowNextGo(true)
			end
		end

		arg_782_1.nodeConfigList_ = {}

		arg_782_1:InitPlayNodeList()
	end,
	Play1107506192 = function(arg_786_0, arg_786_1)
		arg_786_1.time_ = 0
		arg_786_1.frameCnt_ = 0
		arg_786_1.state_ = "playing"
		arg_786_1.curTalkId_ = 1107506192
		arg_786_1.duration_ = 5

		SetActive(arg_786_1.tipsGo_, false)

		function arg_786_1.onSingleLineFinish_()
			arg_786_1.onSingleLineUpdate_ = nil
			arg_786_1.onSingleLineFinish_ = nil
			arg_786_1.state_ = "waiting"
		end

		function arg_786_1.playNext_(arg_788_0)
			if arg_788_0 == 1 then
				arg_786_0:Play1107506193(arg_786_1)
			end
		end

		function arg_786_1.onSingleLineUpdate_(arg_789_0)
			if 0 < arg_786_1.time_ and arg_786_1.time_ <= 0 + arg_789_0 then
				arg_786_1.var_.moveOldPos1075ui_actor = arg_786_1.actors_["1075ui_actor"].transform.localPosition

				local var_789_0 = GameObjectTools.GetOrAddComponent(arg_786_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_789_0 then
					var_789_0:EnableDynamicBone(false)
				end
			end

			local var_789_1 = 0.001

			if 0 <= arg_786_1.time_ and arg_786_1.time_ < 0 + var_789_1 then
				arg_786_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_786_1.var_.moveOldPos1075ui_actor, Vector3.New(0, 100, 0), (arg_786_1.time_ - 0) / var_789_1)
				arg_786_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_786_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_786_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_786_1.actors_["1075ui_actor"].transform.position).z)
				arg_786_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_786_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_786_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_786_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_786_1.time_ >= 0 + var_789_1 and arg_786_1.time_ < 0 + var_789_1 + arg_789_0 then
				arg_786_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_786_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_786_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_786_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_786_1.actors_["1075ui_actor"].transform.position).z)
				arg_786_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_786_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_786_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_786_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_789_2 = GameObjectTools.GetOrAddComponent(arg_786_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_789_2 then
					var_789_2:EnableDynamicBone(true)
				end
			end

			local var_789_3 = 0
			local var_789_4 = 1.25

			if 0 < arg_786_1.time_ and arg_786_1.time_ <= var_789_3 + arg_789_0 then
				arg_786_1.talkMaxDuration = 0
				arg_786_1.dialogCg_.alpha = 1

				arg_786_1.dialog_:SetActive(true)
				SetActive(arg_786_1.leftNameGo_, false)

				arg_786_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_786_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_786_1:RecordName(arg_786_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_786_1.iconTrs_.gameObject, false)
				arg_786_1.callingController_:SetSelectedState("normal")

				local var_789_5 = arg_786_1:FormatText(arg_786_1:GetWordFromCfg(1107506192).content)

				arg_786_1.text_.text = var_789_5

				LuaForUtil.ClearLinePrefixSymbol(arg_786_1.text_)

				local var_789_7 = 50 <= 0 and var_789_4 or var_789_4 * (utf8.len(var_789_5) / 50)

				if (50 <= 0 and var_789_4 or var_789_4 * (utf8.len(var_789_5) / 50)) > 0 and var_789_4 < var_789_7 then
					arg_786_1.talkMaxDuration = var_789_7

					if var_789_7 + var_789_3 > arg_786_1.duration_ then
						arg_786_1.duration_ = var_789_7 + var_789_3
					end
				end

				arg_786_1.text_.text = var_789_5
				arg_786_1.typewritter.percent = 0

				arg_786_1.typewritter:SetDirty()
				arg_786_1:ShowNextGo(false)
				arg_786_1:RecordContent(arg_786_1.text_.text)
			end

			local var_789_8 = math.max(var_789_4, arg_786_1.talkMaxDuration)

			if var_789_3 <= arg_786_1.time_ and arg_786_1.time_ < var_789_3 + var_789_8 then
				arg_786_1.typewritter.percent = (arg_786_1.time_ - var_789_3) / var_789_8

				arg_786_1.typewritter:SetDirty()
			end

			if arg_786_1.time_ >= var_789_3 + var_789_8 and arg_786_1.time_ < var_789_3 + var_789_8 + arg_789_0 then
				arg_786_1.typewritter.percent = 1

				arg_786_1.typewritter:SetDirty()
				arg_786_1:ShowNextGo(true)
			end
		end

		arg_786_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_786_1:InitPlayNodeList()
	end,
	Play1107506193 = function(arg_790_0, arg_790_1)
		arg_790_1.time_ = 0
		arg_790_1.frameCnt_ = 0
		arg_790_1.state_ = "playing"
		arg_790_1.curTalkId_ = 1107506193
		arg_790_1.duration_ = 5

		SetActive(arg_790_1.tipsGo_, false)

		function arg_790_1.onSingleLineFinish_()
			arg_790_1.onSingleLineUpdate_ = nil
			arg_790_1.onSingleLineFinish_ = nil
			arg_790_1.state_ = "waiting"
			arg_790_1.auto_ = false
		end

		function arg_790_1.playNext_(arg_792_0)
			arg_790_1.onStoryFinished_()
		end

		function arg_790_1.onSingleLineUpdate_(arg_793_0)
			local var_793_0 = 0.775

			if 0 < arg_790_1.time_ and arg_790_1.time_ <= 0 + arg_793_0 then
				arg_790_1.talkMaxDuration = 0
				arg_790_1.dialogCg_.alpha = 1

				arg_790_1.dialog_:SetActive(true)
				SetActive(arg_790_1.leftNameGo_, false)

				arg_790_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_790_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_790_1:RecordName(arg_790_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_790_1.iconTrs_.gameObject, false)
				arg_790_1.callingController_:SetSelectedState("normal")

				local var_793_1 = arg_790_1:FormatText(arg_790_1:GetWordFromCfg(1107506193).content)

				arg_790_1.text_.text = var_793_1

				LuaForUtil.ClearLinePrefixSymbol(arg_790_1.text_)

				local var_793_3 = 31 <= 0 and var_793_0 or var_793_0 * (utf8.len(var_793_1) / 31)

				if (31 <= 0 and var_793_0 or var_793_0 * (utf8.len(var_793_1) / 31)) > 0 and var_793_0 < var_793_3 then
					arg_790_1.talkMaxDuration = var_793_3

					if var_793_3 + 0 > arg_790_1.duration_ then
						arg_790_1.duration_ = var_793_3 + 0
					end
				end

				arg_790_1.text_.text = var_793_1
				arg_790_1.typewritter.percent = 0

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(false)
				arg_790_1:RecordContent(arg_790_1.text_.text)
			end

			local var_793_4 = math.max(var_793_0, arg_790_1.talkMaxDuration)

			if 0 <= arg_790_1.time_ and arg_790_1.time_ < 0 + var_793_4 then
				arg_790_1.typewritter.percent = (arg_790_1.time_ - 0) / var_793_4

				arg_790_1.typewritter:SetDirty()
			end

			if arg_790_1.time_ >= 0 + var_793_4 and arg_790_1.time_ < 0 + var_793_4 + arg_793_0 then
				arg_790_1.typewritter.percent = 1

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(true)
			end
		end

		arg_790_1.nodeConfigList_ = {}

		arg_790_1:InitPlayNodeList()
	end,
	Play1107506128 = function(arg_794_0, arg_794_1)
		arg_794_1.time_ = 0
		arg_794_1.frameCnt_ = 0
		arg_794_1.state_ = "playing"
		arg_794_1.curTalkId_ = 1107506128
		arg_794_1.duration_ = 4.1

		SetActive(arg_794_1.tipsGo_, false)

		function arg_794_1.onSingleLineFinish_()
			arg_794_1.onSingleLineUpdate_ = nil
			arg_794_1.onSingleLineFinish_ = nil
			arg_794_1.state_ = "waiting"
		end

		function arg_794_1.playNext_(arg_796_0)
			if arg_796_0 == 1 then
				arg_794_0:Play1107506129(arg_794_1)
			end
		end

		function arg_794_1.onSingleLineUpdate_(arg_797_0)
			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 then
				arg_794_1.var_.moveOldPos1075ui_actor = arg_794_1.actors_["1075ui_actor"].transform.localPosition

				local var_797_0 = GameObjectTools.GetOrAddComponent(arg_794_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_797_0 then
					var_797_0:EnableDynamicBone(false)
				end
			end

			local var_797_1 = 0.001

			if 0 <= arg_794_1.time_ and arg_794_1.time_ < 0 + var_797_1 then
				arg_794_1.actors_["1075ui_actor"].transform.localPosition = Vector3.Lerp(arg_794_1.var_.moveOldPos1075ui_actor, Vector3.New(0, -1.055, -6.16), (arg_794_1.time_ - 0) / var_797_1)
				arg_794_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_794_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_794_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_794_1.actors_["1075ui_actor"].transform.position).z)
				arg_794_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_794_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_794_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_794_1.actors_["1075ui_actor"].transform.localEulerAngles
			end

			if arg_794_1.time_ >= 0 + var_797_1 and arg_794_1.time_ < 0 + var_797_1 + arg_797_0 then
				arg_794_1.actors_["1075ui_actor"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_794_1.actors_["1075ui_actor"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_794_1.actors_["1075ui_actor"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_794_1.actors_["1075ui_actor"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_794_1.actors_["1075ui_actor"].transform.position).z)
				arg_794_1.actors_["1075ui_actor"].transform.localEulerAngles.z = 0
				arg_794_1.actors_["1075ui_actor"].transform.localEulerAngles.x = 0
				arg_794_1.actors_["1075ui_actor"].transform.localEulerAngles = arg_794_1.actors_["1075ui_actor"].transform.localEulerAngles

				local var_797_2 = GameObjectTools.GetOrAddComponent(arg_794_1.actors_["1075ui_actor"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_797_2 then
					var_797_2:EnableDynamicBone(true)
				end
			end

			local var_797_3 = arg_794_1.actors_["1075ui_actor"]

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 and not isNil(var_797_3) and arg_794_1.var_.characterEffect1075ui_actor == nil then
				arg_794_1.var_.characterEffect1075ui_actor = var_797_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_797_4 = 0.200000002980232

			if 0 <= arg_794_1.time_ and arg_794_1.time_ < 0 + var_797_4 and not isNil(var_797_3) then
				if arg_794_1.var_.characterEffect1075ui_actor and not isNil(var_797_3) then
					arg_794_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_794_1.time_ >= 0 + var_797_4 and arg_794_1.time_ < 0 + var_797_4 + arg_797_0 and not isNil(var_797_3) and arg_794_1.var_.characterEffect1075ui_actor then
				arg_794_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_797_6 = "1075ui_actor"

			if arg_794_1.actors_["1075ui_actor"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_actor"))) then
				local var_797_7 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_794_1.stage_.transform)

				var_797_7.name = var_797_6
				var_797_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_794_1.actors_[var_797_6] = var_797_7

				local var_797_8 = var_797_7:GetComponentInChildren(typeof(CharacterEffect))

				var_797_8.enabled = true

				local var_797_9 = GameObjectTools.GetOrAddComponent(var_797_7, typeof(DynamicBoneHelper))

				if var_797_9 then
					var_797_9:EnableDynamicBone(false)
				end

				arg_794_1:ShowWeapon(var_797_8.transform, false)

				arg_794_1.var_[var_797_6 .. "Animator"] = var_797_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_794_1.var_[var_797_6 .. "Animator"].applyRootMotion = true
				arg_794_1.var_[var_797_6 .. "LipSync"] = var_797_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 then
				arg_794_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_797_10 = "1075ui_actor"

			if arg_794_1.actors_["1075ui_actor"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_actor"))) then
				local var_797_11 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_794_1.stage_.transform)

				var_797_11.name = var_797_10
				var_797_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_794_1.actors_[var_797_10] = var_797_11

				local var_797_12 = var_797_11:GetComponentInChildren(typeof(CharacterEffect))

				var_797_12.enabled = true

				local var_797_13 = GameObjectTools.GetOrAddComponent(var_797_11, typeof(DynamicBoneHelper))

				if var_797_13 then
					var_797_13:EnableDynamicBone(false)
				end

				arg_794_1:ShowWeapon(var_797_12.transform, false)

				arg_794_1.var_[var_797_10 .. "Animator"] = var_797_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_794_1.var_[var_797_10 .. "Animator"].applyRootMotion = true
				arg_794_1.var_[var_797_10 .. "LipSync"] = var_797_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 then
				arg_794_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_797_14 = 0
			local var_797_15 = 0.45

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= var_797_14 + arg_797_0 then
				arg_794_1.talkMaxDuration = 0
				arg_794_1.dialogCg_.alpha = 1

				arg_794_1.dialog_:SetActive(true)
				SetActive(arg_794_1.leftNameGo_, true)

				arg_794_1.leftNameTxt_.text = arg_794_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_794_1.leftNameTxt_.transform)

				arg_794_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_794_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_794_1:RecordName(arg_794_1.leftNameTxt_.text)
				SetActive(arg_794_1.iconTrs_.gameObject, false)
				arg_794_1.callingController_:SetSelectedState("normal")

				local var_797_16 = arg_794_1:GetWordFromCfg(1107506128)
				local var_797_17 = arg_794_1:FormatText(var_797_16.content)

				arg_794_1.text_.text = var_797_17

				LuaForUtil.ClearLinePrefixSymbol(arg_794_1.text_)

				local var_797_19 = 18 <= 0 and var_797_15 or var_797_15 * (utf8.len(var_797_17) / 18)

				if (18 <= 0 and var_797_15 or var_797_15 * (utf8.len(var_797_17) / 18)) > 0 and var_797_15 < var_797_19 then
					arg_794_1.talkMaxDuration = var_797_19

					if var_797_19 + var_797_14 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_19 + var_797_14
					end
				end

				arg_794_1.text_.text = var_797_17
				arg_794_1.typewritter.percent = 0

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506128", "story_v_side_new_1107506.awb") ~= 0 then
					local var_797_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506128", "story_v_side_new_1107506.awb") / 1000

					if var_797_20 + var_797_14 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_20 + var_797_14
					end

					if var_797_16.prefab_name ~= "" and arg_794_1.actors_[var_797_16.prefab_name] ~= nil then
						local var_797_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_794_1.actors_[var_797_16.prefab_name].transform, "story_v_side_new_1107506", "1107506128", "story_v_side_new_1107506.awb")

						arg_794_1:RecordAudio("1107506128", var_797_21)
						arg_794_1:RecordAudio("1107506128", var_797_21)
					else
						arg_794_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506128", "story_v_side_new_1107506.awb")
					end

					arg_794_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506128", "story_v_side_new_1107506.awb")
				end

				arg_794_1:RecordContent(arg_794_1.text_.text)
			end

			local var_797_22 = math.max(var_797_15, arg_794_1.talkMaxDuration)

			if var_797_14 <= arg_794_1.time_ and arg_794_1.time_ < var_797_14 + var_797_22 then
				arg_794_1.typewritter.percent = (arg_794_1.time_ - var_797_14) / var_797_22

				arg_794_1.typewritter:SetDirty()
			end

			if arg_794_1.time_ >= var_797_14 + var_797_22 and arg_794_1.time_ < var_797_14 + var_797_22 + arg_797_0 then
				arg_794_1.typewritter.percent = 1

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(true)
			end
		end

		arg_794_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_794_1:InitPlayNodeList()
	end,
	Play1107506129 = function(arg_798_0, arg_798_1)
		arg_798_1.time_ = 0
		arg_798_1.frameCnt_ = 0
		arg_798_1.state_ = "playing"
		arg_798_1.curTalkId_ = 1107506129
		arg_798_1.duration_ = 5

		SetActive(arg_798_1.tipsGo_, false)

		function arg_798_1.onSingleLineFinish_()
			arg_798_1.onSingleLineUpdate_ = nil
			arg_798_1.onSingleLineFinish_ = nil
			arg_798_1.state_ = "waiting"
		end

		function arg_798_1.playNext_(arg_800_0)
			if arg_800_0 == 1 then
				arg_798_0:Play1107506130(arg_798_1)
			end
		end

		function arg_798_1.onSingleLineUpdate_(arg_801_0)
			if 0 < arg_798_1.time_ and arg_798_1.time_ <= 0 + arg_801_0 and not isNil(arg_798_1.actors_["1075ui_actor"]) and arg_798_1.var_.characterEffect1075ui_actor == nil then
				arg_798_1.var_.characterEffect1075ui_actor = arg_798_1.actors_["1075ui_actor"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_801_0 = 0.200000002980232

			if 0 <= arg_798_1.time_ and arg_798_1.time_ < 0 + var_801_0 and not isNil(arg_798_1.actors_["1075ui_actor"]) then
				if arg_798_1.var_.characterEffect1075ui_actor and not isNil(arg_798_1.actors_["1075ui_actor"]) then
					arg_798_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_798_1.var_.characterEffect1075ui_actor.fillRatio = Mathf.Lerp(0, 0.5, (arg_798_1.time_ - 0) / var_801_0)
				end
			end

			if arg_798_1.time_ >= 0 + var_801_0 and arg_798_1.time_ < 0 + var_801_0 + arg_801_0 and not isNil(arg_798_1.actors_["1075ui_actor"]) and arg_798_1.var_.characterEffect1075ui_actor then
				arg_798_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_798_1.var_.characterEffect1075ui_actor.fillRatio = 0.5
			end

			local var_801_1 = 0
			local var_801_2 = 0.35

			if 0 < arg_798_1.time_ and arg_798_1.time_ <= var_801_1 + arg_801_0 then
				arg_798_1.talkMaxDuration = 0
				arg_798_1.dialogCg_.alpha = 1

				arg_798_1.dialog_:SetActive(true)
				SetActive(arg_798_1.leftNameGo_, true)

				arg_798_1.leftNameTxt_.text = arg_798_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_798_1.leftNameTxt_.transform)

				arg_798_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_798_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_798_1:RecordName(arg_798_1.leftNameTxt_.text)
				SetActive(arg_798_1.iconTrs_.gameObject, true)
				arg_798_1.iconController_:SetSelectedState("hero")

				arg_798_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_798_1.callingController_:SetSelectedState("normal")

				arg_798_1.keyicon_.color = Color.New(1, 1, 1)
				arg_798_1.icon_.color = Color.New(1, 1, 1)

				local var_801_3 = arg_798_1:FormatText(arg_798_1:GetWordFromCfg(1107506129).content)

				arg_798_1.text_.text = var_801_3

				LuaForUtil.ClearLinePrefixSymbol(arg_798_1.text_)

				local var_801_5 = 14 <= 0 and var_801_2 or var_801_2 * (utf8.len(var_801_3) / 14)

				if (14 <= 0 and var_801_2 or var_801_2 * (utf8.len(var_801_3) / 14)) > 0 and var_801_2 < var_801_5 then
					arg_798_1.talkMaxDuration = var_801_5

					if var_801_5 + var_801_1 > arg_798_1.duration_ then
						arg_798_1.duration_ = var_801_5 + var_801_1
					end
				end

				arg_798_1.text_.text = var_801_3
				arg_798_1.typewritter.percent = 0

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(false)
				arg_798_1:RecordContent(arg_798_1.text_.text)
			end

			local var_801_6 = math.max(var_801_2, arg_798_1.talkMaxDuration)

			if var_801_1 <= arg_798_1.time_ and arg_798_1.time_ < var_801_1 + var_801_6 then
				arg_798_1.typewritter.percent = (arg_798_1.time_ - var_801_1) / var_801_6

				arg_798_1.typewritter:SetDirty()
			end

			if arg_798_1.time_ >= var_801_1 + var_801_6 and arg_798_1.time_ < var_801_1 + var_801_6 + arg_801_0 then
				arg_798_1.typewritter.percent = 1

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(true)
			end
		end

		arg_798_1.nodeConfigList_ = {}

		arg_798_1:InitPlayNodeList()
	end,
	Play1107506118 = function(arg_802_0, arg_802_1)
		arg_802_1.time_ = 0
		arg_802_1.frameCnt_ = 0
		arg_802_1.state_ = "playing"
		arg_802_1.curTalkId_ = 1107506118
		arg_802_1.duration_ = 5.4

		SetActive(arg_802_1.tipsGo_, false)

		function arg_802_1.onSingleLineFinish_()
			arg_802_1.onSingleLineUpdate_ = nil
			arg_802_1.onSingleLineFinish_ = nil
			arg_802_1.state_ = "waiting"
		end

		function arg_802_1.playNext_(arg_804_0)
			if arg_804_0 == 1 then
				arg_802_0:Play1107506119(arg_802_1)
			end
		end

		function arg_802_1.onSingleLineUpdate_(arg_805_0)
			if arg_802_1.actors_["1075ui_actor"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_actor"))) then
				local var_805_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_802_1.stage_.transform)

				var_805_0.name = "1075ui_actor"
				var_805_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_802_1.actors_["1075ui_actor"] = var_805_0

				local var_805_1 = var_805_0:GetComponentInChildren(typeof(CharacterEffect))

				var_805_1.enabled = true

				local var_805_2 = GameObjectTools.GetOrAddComponent(var_805_0, typeof(DynamicBoneHelper))

				if var_805_2 then
					var_805_2:EnableDynamicBone(false)
				end

				arg_802_1:ShowWeapon(var_805_1.transform, false)

				arg_802_1.var_["1075ui_actor" .. "Animator"] = var_805_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_802_1.var_["1075ui_actor" .. "Animator"].applyRootMotion = true
				arg_802_1.var_["1075ui_actor" .. "LipSync"] = var_805_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_802_1.time_ and arg_802_1.time_ <= 0 + arg_805_0 then
				arg_802_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_805_3 = "1075ui_actor"

			if arg_802_1.actors_["1075ui_actor"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_actor"))) then
				local var_805_4 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_802_1.stage_.transform)

				var_805_4.name = var_805_3
				var_805_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_802_1.actors_[var_805_3] = var_805_4

				local var_805_5 = var_805_4:GetComponentInChildren(typeof(CharacterEffect))

				var_805_5.enabled = true

				local var_805_6 = GameObjectTools.GetOrAddComponent(var_805_4, typeof(DynamicBoneHelper))

				if var_805_6 then
					var_805_6:EnableDynamicBone(false)
				end

				arg_802_1:ShowWeapon(var_805_5.transform, false)

				arg_802_1.var_[var_805_3 .. "Animator"] = var_805_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_802_1.var_[var_805_3 .. "Animator"].applyRootMotion = true
				arg_802_1.var_[var_805_3 .. "LipSync"] = var_805_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_802_1.time_ and arg_802_1.time_ <= 0 + arg_805_0 then
				arg_802_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_805_7 = arg_802_1.actors_["1075ui_actor"]

			if 0 < arg_802_1.time_ and arg_802_1.time_ <= 0 + arg_805_0 and not isNil(var_805_7) and arg_802_1.var_.characterEffect1075ui_actor == nil then
				arg_802_1.var_.characterEffect1075ui_actor = var_805_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_805_8 = 0.200000002980232

			if 0 <= arg_802_1.time_ and arg_802_1.time_ < 0 + var_805_8 and not isNil(var_805_7) then
				if arg_802_1.var_.characterEffect1075ui_actor and not isNil(var_805_7) then
					arg_802_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_802_1.time_ >= 0 + var_805_8 and arg_802_1.time_ < 0 + var_805_8 + arg_805_0 and not isNil(var_805_7) and arg_802_1.var_.characterEffect1075ui_actor then
				arg_802_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_805_10 = 0
			local var_805_11 = 0.5

			if 0 < arg_802_1.time_ and arg_802_1.time_ <= var_805_10 + arg_805_0 then
				arg_802_1.talkMaxDuration = 0
				arg_802_1.dialogCg_.alpha = 1

				arg_802_1.dialog_:SetActive(true)
				SetActive(arg_802_1.leftNameGo_, true)

				arg_802_1.leftNameTxt_.text = arg_802_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_802_1.leftNameTxt_.transform)

				arg_802_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_802_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_802_1:RecordName(arg_802_1.leftNameTxt_.text)
				SetActive(arg_802_1.iconTrs_.gameObject, false)
				arg_802_1.callingController_:SetSelectedState("normal")

				local var_805_12 = arg_802_1:GetWordFromCfg(1107506118)
				local var_805_13 = arg_802_1:FormatText(var_805_12.content)

				arg_802_1.text_.text = var_805_13

				LuaForUtil.ClearLinePrefixSymbol(arg_802_1.text_)

				local var_805_15 = 20 <= 0 and var_805_11 or var_805_11 * (utf8.len(var_805_13) / 20)

				if (20 <= 0 and var_805_11 or var_805_11 * (utf8.len(var_805_13) / 20)) > 0 and var_805_11 < var_805_15 then
					arg_802_1.talkMaxDuration = var_805_15

					if var_805_15 + var_805_10 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_15 + var_805_10
					end
				end

				arg_802_1.text_.text = var_805_13
				arg_802_1.typewritter.percent = 0

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506118", "story_v_side_new_1107506.awb") ~= 0 then
					local var_805_16 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506118", "story_v_side_new_1107506.awb") / 1000

					if var_805_16 + var_805_10 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_16 + var_805_10
					end

					if var_805_12.prefab_name ~= "" and arg_802_1.actors_[var_805_12.prefab_name] ~= nil then
						local var_805_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_802_1.actors_[var_805_12.prefab_name].transform, "story_v_side_new_1107506", "1107506118", "story_v_side_new_1107506.awb")

						arg_802_1:RecordAudio("1107506118", var_805_17)
						arg_802_1:RecordAudio("1107506118", var_805_17)
					else
						arg_802_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506118", "story_v_side_new_1107506.awb")
					end

					arg_802_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506118", "story_v_side_new_1107506.awb")
				end

				arg_802_1:RecordContent(arg_802_1.text_.text)
			end

			local var_805_18 = math.max(var_805_11, arg_802_1.talkMaxDuration)

			if var_805_10 <= arg_802_1.time_ and arg_802_1.time_ < var_805_10 + var_805_18 then
				arg_802_1.typewritter.percent = (arg_802_1.time_ - var_805_10) / var_805_18

				arg_802_1.typewritter:SetDirty()
			end

			if arg_802_1.time_ >= var_805_10 + var_805_18 and arg_802_1.time_ < var_805_10 + var_805_18 + arg_805_0 then
				arg_802_1.typewritter.percent = 1

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(true)
			end
		end

		arg_802_1.nodeConfigList_ = {}

		arg_802_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST32a",
		"TextureConfig/Background/ST37a",
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/R7502",
		"TextureConfig/Background/R7502a",
		"TextureConfig/Background/ST45"
	},
	voices = {
		"story_v_side_new_1107506.awb"
	}
}
